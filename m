From: Junio C Hamano <gitster@pobox.com>
Subject: Re: --squash has no effect in git subtree push?
Date: Thu, 07 May 2015 11:05:20 -0700
Message-ID: <xmqqy4l0p8kf.fsf@gitster.dls.corp.google.com>
References: <CAMbsUu5g=r867_WOhLCySG3caKj1jhmQgfzBxK4TYV27+nUpsg@mail.gmail.com>
	<CAMbsUu4v9w6+wiAUm2hpiNrDaoL3U9Z_suXR3NPVGo-JhH3E+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git develop <git@vger.kernel.org>
To: Danny Lin <danny0838@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 20:05:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqQBA-0003Po-Is
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 20:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbbEGSF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 14:05:29 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64148 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751686AbbEGSF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 14:05:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A3AA4E35D;
	Thu,  7 May 2015 14:05:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n/kNE+Y7Sn3Yz04Fyy8G+BzHczo=; b=PDxq6G
	PbvP5GGhM9SkpwkrgdU0tCQHe3cWdKaKpCvAplVFf/G57lkjVt6CAoNAsHMTppzj
	v9+MQHmZZD2Xy3c5zkUfx3ENBZWWx/CxctapiMUgG/fCPNjjVCyYPk0NMnChzjOU
	p5jWQ5h1ZcWXQDWRmbfVbLjicGfTO24a7GzwY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XZo3jYbH/HMv159ct1ZBPPBor9OBrlTS
	t4h9IbkRMBLaSXP83JfoZ9PK0tXdgNI9e5O0zedt700TZ7d7oB5SHQWBKPlxMtNg
	bj63zfepgnMX4rRS+ymCyqgnldPHcP5O/77P7o2D/wuSgGlnLemDj6CiDLVwexy/
	ItvGiHpPZOs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FA5B4E35C;
	Thu,  7 May 2015 14:05:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7E1684E349;
	Thu,  7 May 2015 14:05:21 -0400 (EDT)
In-Reply-To: <CAMbsUu4v9w6+wiAUm2hpiNrDaoL3U9Z_suXR3NPVGo-JhH3E+Q@mail.gmail.com>
	(Danny Lin's message of "Thu, 7 May 2015 15:52:33 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A07DCCB0-F4E3-11E4-B873-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268564>

Danny Lin <danny0838@gmail.com> writes:

> diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
> index 54e4b4a..60d76cd 100644
> --- a/contrib/subtree/git-subtree.txt
> +++ b/contrib/subtree/git-subtree.txt
> @@ -146,7 +146,7 @@ OPTIONS
>  OPTIONS FOR add, merge, push, pull
>  ----------------------------------
>  --squash::
> -    This option is only valid for add, merge, push and pull
> +    This option is only valid for add, merge, and pull

You seem to have lost leading TABs in the patch somehow.

I manually typed the same change and commited, so no need to resend
this one, but for future reference, please try sending a patch to
yourself (and nobody else) and make sure what you reeived applies
cleanly with "git am" on the commit you based your patch on.

And if it doesn't, figure out where tabs are eaten and lines are
wrapped and fix that problem before sending the patch to the list.

Thanks.
