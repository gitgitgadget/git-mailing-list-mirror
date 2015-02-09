From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 17/21] list-files: show directories as well as files
Date: Mon, 09 Feb 2015 14:28:33 -0800
Message-ID: <xmqqiofawwha.fsf@gitster.dls.corp.google.com>
References: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
	<1423386099-19994-18-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 23:28:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKwou-0000eE-4h
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 23:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761222AbbBIW2k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Feb 2015 17:28:40 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753238AbbBIW2j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Feb 2015 17:28:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0580D37B94;
	Mon,  9 Feb 2015 17:28:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1f0LEdEd0Ie/
	Laipy1HGE9gDl8Q=; b=QHNRCmBB1NKPTNGHqVqvYGq23xQ4aLYp1NJ2T31NNgCz
	9iMxdyw5La0xvQPCqv/QX5LOky6Vtl0NAdWaFJmf/HcZlgR1G8IlxtcxsDrGep4/
	42zKmlKhyZFzmy1dhTC1zz0+rmcE6mftu5aDZGWp8eaTlgncp1jS+FADCf1eaBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hSCjNL
	ZYqu7zlLsHVCboFnnj7Bmf61HN/QgVYgt7B8rk5pIWr1Cb9SgKGhU9ZrS9Y97BX9
	pwvjGmYulLRtNnhBeol+pUHrmOOEvh3uazLbmePntiQbpgpJvVPkxRQ+pIh+id41
	WE2llmmxVdLZ9KIQNxboHg1VgExJk/oIGk+rM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F16B537B93;
	Mon,  9 Feb 2015 17:28:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 610FB37B8D;
	Mon,  9 Feb 2015 17:28:35 -0500 (EST)
In-Reply-To: <1423386099-19994-18-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 8 Feb
 2015 16:01:35 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FC6FB240-B0AA-11E4-A413-38A39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263614>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +	if (show_dirs &&strchr(ce->name, '/') &&

Oops.  Will fix it up locally.
