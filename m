From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision: add --reflog-message=<pattern> to grep reflog
 messages
Date: Wed, 26 Sep 2012 07:07:30 -0700
Message-ID: <7vpq58ubbx.fsf@alter.siamese.dyndns.org>
References: <1348661565-30484-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 16:07:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGsH8-0001Oq-By
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 16:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961Ab2IZOHd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Sep 2012 10:07:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61470 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752550Ab2IZOHd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Sep 2012 10:07:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 752B26583;
	Wed, 26 Sep 2012 10:07:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+2/vkR0bal3/
	PyCK+2ZK7YH7oPc=; b=nlkSAvtbU+oN/z3B5CJNeJ9K4wI+w43Rsif2L/APkWcR
	Rzy+vRD55eBlzT0MRBrcVVN0/TVZ2VLdSNnp4kY1cD58kMLFkqR/iAcq3JVI3DNr
	S8V/cL5hh+9kFxrkxwz2K5mKJr4mWFCIFZlxtGI9jU0dFXCy7IgRVE6GRgSxMzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AIIFE2
	Tdy1QBA0S2pd20QWgx3CozrWMUXz4ziULHqLuV2hVEeVt8TyUXrZibPg27goUau4
	4XUC98gnPxErmR6x5DZqvi/VYxg5aYGlmifypJNCTsrLiz4imfqf0T6GNay5sNq4
	r9tcxaOSQZYUsN9P1lrUSFDCfBHS5Bejp2Se8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 627446582;
	Wed, 26 Sep 2012 10:07:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D93906580; Wed, 26 Sep 2012
 10:07:31 -0400 (EDT)
In-Reply-To: <1348661565-30484-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 26 Sep
 2012 19:12:45 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8374C65E-07E3-11E2-8042-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206416>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Both "git log" and "git reflog show" recognize this option.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

How well does it interact with --grep and/or --all-match?
