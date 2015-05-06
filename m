From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: -r -d(D) should say "remote-tracking branch"
Date: Wed, 06 May 2015 13:29:01 -0700
Message-ID: <xmqqtwvpsb5e.fsf@gitster.dls.corp.google.com>
References: <CAMbsUu5pKiQ76WrCXvziQ8zER-Mc5oVt7tGnC7Q3RMVX2r8ZXQ@mail.gmail.com>
	<CAN0XMOJ8QJ14B15BoFrr7d7L-jE06yUbquo8pW3OCj4wmUk2Rw@mail.gmail.com>
	<xmqq4mnpvbgt.fsf@gitster.dls.corp.google.com>
	<CAMbsUu4iAD0kGh_ZzbLBS4P69Hz-T4Mv0krLst+M7SVc=v=Dog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git <git@vger.kernel.org>
To: Danny Lin <danny0838@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 22:29:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq5wN-0007fx-Ia
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 22:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbbEFU3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 16:29:07 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751219AbbEFU3E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 16:29:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D9A54FBE9;
	Wed,  6 May 2015 16:29:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PItccWZ/M40e+w3S4Y3l9Gusd1U=; b=PPwwkX
	ncJsI8WMSel7RE2Hkb/SscMrueeAKgihzLsf4bkUJRzJ+QvrjTEUZoSUsQe6lCad
	cbFIiNdlyvf7O+d7uqaKyHL5tninm3MZ8yJ/niVMwlHlTyWg/5AB/oMC9PS/BF7B
	XuoEBpv1bJ3EM7w/S1JPxDDkwmAtKRuhzXZWE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=teAA3A284Qu/p/UG+yu3w6YKF1GFDGM/
	0oMFlbs/Cs+75Tp1WMGe4RtdHoh4yLePBOX1aIQB73eHXEyrIAfPTx2cILsVhsuh
	yEe+CAG9pt52DAqVeqP3K0rKALZ5QakJnKVffA+B+kT5EfxM7kDzFeQoNNknfEVx
	y23OFxEWEgM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 64AD84FBE8;
	Wed,  6 May 2015 16:29:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D43B44FBE6;
	Wed,  6 May 2015 16:29:02 -0400 (EDT)
In-Reply-To: <CAMbsUu4iAD0kGh_ZzbLBS4P69Hz-T4Mv0krLst+M7SVc=v=Dog@mail.gmail.com>
	(Danny Lin's message of "Thu, 7 May 2015 03:01:55 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 88CDEE20-F42E-11E4-9EDF-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268495>

Danny Lin <danny0838@gmail.com> writes:

> git branch -r -d(D) currently says "delete remote branch",
> which should be "remote-tracking branch".
>
> Signed-off-by: Danny Lin <danny0838@gmail.com>
> ---

Thanks.

The patch is whitespace damaged and does not apply, though.  I
manually typed the same change and commited with a tweaked log
message, so no need to resend this one, but for future reference,
please try sending a patch to yourself and make sure it applies
cleanly (and if it doesn't, figure out where tabs are eaten and
lines are wrapped and fix that problem before sending the patch to
the list).


>  builtin/branch.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index dc6f0b2..3560c51 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -242,7 +242,7 @@ static int delete_branches(int argc, const char
> **argv, int force, int kinds,
>                          sha1, &flags);
>          if (!target) {
>              error(remote_branch
> -                  ? _("remote branch '%s' not found.")
> +                  ? _("remote-tracking branch '%s' not found.")
>                    : _("branch '%s' not found."), bname.buf);
>              ret = 1;
>              continue;
> @@ -257,7 +257,7 @@ static int delete_branches(int argc, const char
> **argv, int force, int kinds,
>
>          if (delete_ref(name, sha1, REF_NODEREF)) {
>              error(remote_branch
> -                  ? _("Error deleting remote branch '%s'")
> +                  ? _("Error deleting remote-tracking branch '%s'")
>                    : _("Error deleting branch '%s'"),
>                    bname.buf);
>              ret = 1;
> @@ -265,7 +265,7 @@ static int delete_branches(int argc, const char
> **argv, int force, int kinds,
>          }
>          if (!quiet) {
>              printf(remote_branch
> -                   ? _("Deleted remote branch %s (was %s).\n")
> +                   ? _("Deleted remote-tracking branch %s (was %s).\n")
>                     : _("Deleted branch %s (was %s).\n"),
>                     bname.buf,
>                     (flags & REF_ISBROKEN) ? "broken"
