From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2011, #02; Sun, 20)
Date: Tue, 22 Mar 2011 11:57:58 +0100
Message-ID: <AANLkTimsiM6k9t8H6q4cwB9i42Q4ysNJb2MYyeYYnF5D@mail.gmail.com>
References: <7vy649vah1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 11:58:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1zHy-0000Xe-DG
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 11:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967Ab1CVK6F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2011 06:58:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34249 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602Ab1CVK6C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2011 06:58:02 -0400
Received: by fxm17 with SMTP id 17so6295862fxm.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 03:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lRYOKHDtPbQDH8fBKKtJJKz6PRPD3OQU/+qBUwuNDGE=;
        b=CPr3CCZCDyxnq/7P+sIdBTMmgU6DOeATPPA8rm3PlhXvtcdvgwuETt5ixJVEKnd9qL
         yV1qzl8BKa9hEKnEP+4DMLe5JxDfkOljA6zw3Bd80k4byQpOWLR/nyhpcn7SHg0FfBvM
         Jxv3Alexnh2t1KfJ8PzAlr+qGnmtAp2dDcLwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=u8jqZPm0Ncm0kKQo4XWrI2E/wBpBkF+zMoZTqf8wlorYx3/8EyB22AfDa0R3o28F1V
         tDERoKVVnhhnnr/SC2/SZFzNtbjquSGQXf0cck3hbhhnYh7k2d8IFoDako8ncWHqMWqW
         adYt8UPr3apoGXBya18c3yCjVkic8zCj3+Y0U=
Received: by 10.223.54.148 with SMTP id q20mr1126290fag.84.1300791478148; Tue,
 22 Mar 2011 03:57:58 -0700 (PDT)
Received: by 10.223.123.198 with HTTP; Tue, 22 Mar 2011 03:57:58 -0700 (PDT)
In-Reply-To: <7vy649vah1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169721>

On Sun, Mar 20, 2011 at 20:49, Junio C Hamano <gitster@pobox.com> wrote=
:

> [Graduated to "master"]
>
> * ab/i18n-basic (2011-02-25) 9 commits
> =C2=A0(merged to 'next' on 2011-03-10 at ab70d57)
> =C2=A0+ i18n: "make distclean" should clean up after "make pot"
> =C2=A0+ i18n: Makefile: "pot" target to extract messages marked for t=
ranslation
> =C2=A0+ i18n: add stub Q_() wrapper for ngettext
> =C2=A0+ i18n: do not poison translations unless GIT_GETTEXT_POISON en=
vvar is set
> =C2=A0+ i18n: add GETTEXT_POISON to simulate unfriendly translator
> =C2=A0+ i18n: add no-op _() and N_() wrappers
> =C2=A0+ commit, status: use status_printf{,_ln,_more} helpers
> =C2=A0+ commit: refer to commit template as s->fp
> =C2=A0+ wt-status: add helpers for printing wt-status lines
> =C2=A0(this branch is used by ab/i18n-st.)

Thanks a lot for merging this down.

> * ab/i18n-st (2011-02-22) 69 commits
> =C2=A0- i18n: git-shortlog basic messages
> =C2=A0- i18n: git-revert split up "could not revert/apply" message
> =C2=A0- i18n: git-revert literal "me" messages
> =C2=A0- i18n: git-revert "Your local changes" message
> =C2=A0- i18n: git-revert basic messages
> =C2=A0- i18n: git-notes GIT_NOTES_REWRITE_MODE error message
> =C2=A0- i18n: git-notes basic commands
> =C2=A0- i18n: git-gc "Auto packing the repository" message
> =C2=A0- i18n: git-gc basic messages
> =C2=A0- i18n: git-describe basic messages
> =C2=A0- i18n: git-clean clean.requireForce messages
> =C2=A0- i18n: git-clean basic messages
> =C2=A0- i18n: git-bundle basic messages
> =C2=A0- i18n: git-archive basic messages
> =C2=A0- i18n: git-status "renamed: " message
> =C2=A0- i18n: git-status "Initial commit" message
> =C2=A0- i18n: git-status "Changes to be committed" message
> =C2=A0- i18n: git-status shortstatus messages
> =C2=A0- i18n: git-status "nothing to commit" messages
> =C2=A0- i18n: git-status basic messages
> =C2=A0- i18n: git-push "prevent you from losing" message
> =C2=A0- i18n: git-push basic messages
> =C2=A0- i18n: git-tag tag_template message
> =C2=A0- i18n: git-tag basic messages
> =C2=A0- i18n: git-reset "Unstaged changes after reset" message
> =C2=A0- i18n: git-reset reset_type_names messages
> =C2=A0- i18n: git-reset basic messages
> =C2=A0- i18n: git-rm basic messages
> =C2=A0- i18n: git-mv "bad" messages
> =C2=A0- i18n: git-mv basic messages
> =C2=A0- i18n: git-merge "Wonderful" message
> =C2=A0- i18n: git-merge "You have not concluded your merge" messages
> =C2=A0- i18n: git-merge "Updating %s..%s" message
> =C2=A0- i18n: git-merge basic messages
> =C2=A0- i18n: git-log "--OPT does not make sense" messages
> =C2=A0- i18n: git-log basic messages
> =C2=A0- i18n: git-grep "--open-files-in-pager" message
> =C2=A0- i18n: git-grep basic messages
> =C2=A0- i18n: git-fetch split up "(non-fast-forward)" message
> =C2=A0- i18n: git-fetch update_local_ref messages
> =C2=A0- i18n: git-fetch formatting messages
> =C2=A0- i18n: git-fetch basic messages
> =C2=A0- i18n: git-diff basic messages
> =C2=A0- i18n: git-commit advice messages
> =C2=A0- i18n: git-commit "enter the commit message" message
> =C2=A0- i18n: git-commit print_summary messages
> =C2=A0- i18n: git-commit formatting messages
> =C2=A0- i18n: git-commit "middle of a merge" message
> =C2=A0- i18n: git-commit basic messages
> =C2=A0- i18n: git-checkout "Switched to a .. branch" message
> =C2=A0- i18n: git-checkout "HEAD is now at" message
> =C2=A0- i18n: git-checkout describe_detached_head messages
> =C2=A0- i18n: git-checkout: our/their version message
> =C2=A0- i18n: git-checkout basic messages
> =C2=A0- i18n: git-branch "(no branch)" message
> =C2=A0- i18n: git-branch "git branch -v" messages
> =C2=A0- i18n: git-branch "Deleted branch [...]" message
> =C2=A0- i18n: git-branch "remote branch '%s' not found" message
> =C2=A0- i18n: git-branch basic messages
> =C2=A0- i18n: git-add "Unstaged changes" message
> =C2=A0- i18n: git-add "remove '%s'" message
> =C2=A0- i18n: git-add "did not match any files" message
> =C2=A0- i18n: git-add "The following paths are ignored" message
> =C2=A0- i18n: git-add basic messages
> =C2=A0- i18n: git-clone "Cloning into" message
> =C2=A0- i18n: git-clone "Cloning into" message
> =C2=A0- i18n: git-clone basic messages
> =C2=A0- i18n: git-init "Initialized [...] repository" message
> =C2=A0- i18n: git-init basic messages

What's your plan for merging this to master?

Once this is in I'll rebase my ab/i18n on master, sort out that
eval_gettext() issue you raised (maybe we don't need
git-sh-i18n--envsubst after all), and submit the shell script i18n
translations.
