From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 20/24] update-index: test the system before enabling untracked cache
Date: Wed, 21 Jan 2015 00:32:25 -0800
Message-ID: <xmqqwq4gy1nq.fsf@gitster.dls.corp.google.com>
References: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
	<1421759013-8494-21-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 09:32:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDqiH-0006SX-AN
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 09:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbbAUIc3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2015 03:32:29 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55513 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750803AbbAUIc2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2015 03:32:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F39A2645E;
	Wed, 21 Jan 2015 03:32:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mZEB+1rI5sAb
	ieBw1xcAMHuvGZ0=; b=Ch5V1Km1oM57HzWFmJXUI/YF4AAwUihCh1YC5xhdgNfz
	22RoyJ+bXKJ0amanpSaVSWQaHEBQKJPE1V5Rml7qVeeF5G2/iQInNpET/oiqQlTp
	Q+QYLLL3TV4XT44UVZ9LZUjL9qSk0EPNAwh6UMxy0ylINVF9Az80/C3QM5WYuFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Yyh+C4
	GHN+My8j00VdSa7to2AhcnIXSYTRf08zX7tHkg20kSA5bg7jD19UhOejZdHyywOR
	NqCnqXgFjk1djJGc9dGt7HHEjFUAu1AE+AT5xPybadqy+l25ADm73PSv9ys6jkr9
	OGukzS3VFI84nXydR3lUW4ziiU23IuD2yIyT0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 978062645D;
	Wed, 21 Jan 2015 03:32:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2FA6E26457;
	Wed, 21 Jan 2015 03:32:27 -0500 (EST)
In-Reply-To: <1421759013-8494-21-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 20
 Jan 2015 20:03:29 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0802210A-A148-11E4-9DDC-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262713>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

It appears that this hijacks a fixed name dir-mtime-test at the root
level of every project managed by Git.  Is that intended?

Shouldn't --use-untracked-cache option require the working tree
(i.e. die in a bare repository)?
