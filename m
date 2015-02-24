From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Copyright on wildmatch.c
Date: Tue, 24 Feb 2015 10:59:39 -0800
Message-ID: <xmqqzj83qgo4.fsf@gitster.dls.corp.google.com>
References: <CAMDzUtyitrK__iE9ykfTuP+Ooq0FwMPp_NVgBfBGbSV52+OPoQ@mail.gmail.com>
	<CAMDzUtymj21ckMrA87q1TATeWuH6kS_TBrsJ_jVjfeH50CaniA@mail.gmail.com>
	<CACsJy8Do77QSKSERPE26bKJ0gANB0XmPVBLwb1QKAW4qe0ouAQ@mail.gmail.com>
	<CAMDzUtz_BhW_tuQLy+AiNY7hz_HXCmHOtUNDgMBc=Taeon_Dwg@mail.gmail.com>
	<CACsJy8APLtweaf-q8+nCzJC-8J_vNZp-Y=AtNkX4NPuYr1jb=Q@mail.gmail.com>
	<CAMDzUtxf0gF=JDgEk9EU3W2VWuP-Qy8-Kz-fTx_Y16UeFRGiYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Guilherme <guibufolo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 19:59:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQKhz-0006bn-TG
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 19:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498AbbBXS7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 13:59:47 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50530 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753098AbbBXS7r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 13:59:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 666DA3AA97;
	Tue, 24 Feb 2015 13:59:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hAOw96p+QnT52eBmfdCWcxXjGS4=; b=q3Bq3l
	kdFK6VDnA35TP0JWJ92oBjXFdHnatY1A25gKrgmbWdmpZAW9YFtXpKyYok8aVl2b
	db11KZ7cXaYs+BWGLe7AR3D06N9cnXzexwpZmZXRRoxLljdXVjK133wdmf3ItNUx
	5T+lICadkv9Fbp0P6jNJ0QIQh6SxMR9uyLTEE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AsMEIIbb7+kafLpn2/By5khpMPJViKkw
	ezEWn0ZP10zF3aN9Qc7fhztYWX8id80PVw3PCqJG5LiijMe+LoDy3zDoT/1e8nei
	usiB897b88/u2mwOpTLzdK8G+0rTNj/zP+phdQWGEybgHXhpQJtPHrPollBt2s9v
	0wl0KhLWQ64=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DC2C3AA96;
	Tue, 24 Feb 2015 13:59:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D85DE3AA95;
	Tue, 24 Feb 2015 13:59:40 -0500 (EST)
In-Reply-To: <CAMDzUtxf0gF=JDgEk9EU3W2VWuP-Qy8-Kz-fTx_Y16UeFRGiYA@mail.gmail.com>
	(Guilherme's message of "Tue, 24 Feb 2015 13:17:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 497B4E5C-BC57-11E4-BB91-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264338>

Guilherme <guibufolo@gmail.com> writes:

> I'm not sure on how i would rewrite hex.c it is just an array.
>
> From git-compat-util.h i only needed a subset of the file (Lines 699
> to 785), as you assumed, but rewriting it also seems pointless as it
> is only a few defines and 4 very short functions.

I do not think I have any contributions of significance under
copyright protection in the parts of that file.  The ctype-related
lines in git-compat-util.h attribute to me primarily because they
were moved by 4050c0df (Clean up compatibility definitions,
2005-12-05) from what Linus wrote in another file to the present
location.
