From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #01; Tue, 9)
Date: Tue, 9 Nov 2010 21:11:08 +0100
Message-ID: <AANLkTi=RPf1D-htMtcPhyxJa7d_DcjDuZr_TcGDubjPS@mail.gmail.com>
References: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 21:11:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFuXF-0003ra-JP
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 21:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031Ab0KIULN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 15:11:13 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33252 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385Ab0KIULK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 15:11:10 -0500
Received: by fxm16 with SMTP id 16so5301049fxm.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 12:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Txk5d50DHLG89C9eVtiFDhzjHMqHPQ+iG7lieLvJvWc=;
        b=XSBCS/DHw9WFz6Uldm1v35WaMpexksF7vkZm38JpOt+yV89VNm9YwKzTZZpBUkGypn
         zFrVk4YWHKpesf0VcNBwxjzZ3ed1huo/icCVXadYDVh64FKjBdW2jBnNYNeepGEd1iUY
         lu2F8o79yNRIV7WgUPe3Zmeu4sLYtqbSmqpJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MZmFpnAZZQ/ZVqv1oJEZvYfrDUyFJOoKMT0VK1+D12t7DN1aLDUwLKLQ5HlnJ7rJZM
         sTY7eFOpj3XZsrv8WCHltBOyjpoTeLOaRq6ebZSoIpnZ8vrX0L/mZVbHcyUiULxvsmNw
         tRHjVPl2JoZdzhcux4eY1Tz7me3BSap3i//b4=
Received: by 10.223.79.2 with SMTP id n2mr5733143fak.133.1289333468340; Tue,
 09 Nov 2010 12:11:08 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Tue, 9 Nov 2010 12:11:08 -0800 (PST)
In-Reply-To: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161069>

On Tue, Nov 9, 2010 at 20:53, Junio C Hamano <gitster@pobox.com> wrote:

> * ab/i18n (2010-10-07) 161 commits
> =C2=A0- po/de.po: complete German translation
> =C2=A0- po/sv.po: add Swedish translation
> =C2=A0- gettextize: git-bisect bisect_next_check "You need to" messag=
e
> =C2=A0- gettextize: git-bisect [Y/n] messages
> =C2=A0- gettextize: git-bisect bisect_replay + $1 messages
> =C2=A0- gettextize: git-bisect bisect_reset + $1 messages
> =C2=A0- gettextize: git-bisect bisect_run + $@ messages
> =C2=A0- gettextize: git-bisect die + eval_gettext messages
> =C2=A0- gettextize: git-bisect die + gettext messages
> =C2=A0- gettextize: git-bisect echo + eval_gettext message
> =C2=A0- gettextize: git-bisect echo + gettext messages
> =C2=A0- gettextize: git-bisect gettext + echo message
> =C2=A0- gettextize: git-bisect add git-sh-i18n
> =C2=A0- gettextize: git-stash drop_stash say/die messages
> =C2=A0- gettextize: git-stash "unknown option" message
> =C2=A0- gettextize: git-stash die + eval_gettext $1 messages
> =C2=A0- gettextize: git-stash die + eval_gettext $* messages
> =C2=A0- gettextize: git-stash die + eval_gettext messages
> =C2=A0- gettextize: git-stash die + gettext messages
> =C2=A0- gettextize: git-stash say + gettext messages
> =C2=A0- gettextize: git-stash echo + gettext message
> =C2=A0- gettextize: git-stash add git-sh-i18n
> =C2=A0- gettextize: git-submodule "blob" and "submodule" messages
> =C2=A0- gettextize: git-submodule "path not initialized" message
> =C2=A0- gettextize: git-submodule "[...] path is ignored" message
> =C2=A0- gettextize: git-submodule "Entering [...]" message
> =C2=A0- gettextize: git-submodule $errmsg messages
> =C2=A0- gettextize: git-submodule "Submodule change[...]" messages
> =C2=A0- gettextize: git-submodule "cached cannot be used" message
> =C2=A0- gettextize: git-submodule $update_module say + die messages
> =C2=A0- gettextize: git-submodule die + eval_gettext messages
> =C2=A0- gettextize: git-submodule say + eval_gettext messages
> =C2=A0- gettextize: git-submodule echo + eval_gettext messages
> =C2=A0- gettextize: git-submodule add git-sh-i18n
> =C2=A0- gettextize: git-pull "rebase against" / "merge with" messages
> =C2=A0- gettextize: git-pull "[...] not currently on a branch" messag=
e
> =C2=A0- gettextize: git-pull "You asked to pull" message
> =C2=A0- gettextize: git-pull split up "no candidate" message
> =C2=A0- gettextize: git-pull eval_gettext + warning message
> =C2=A0- gettextize: git-pull eval_gettext + die message
> =C2=A0- gettextize: git-pull die messages
> =C2=A0- gettextize: git-pull add git-sh-i18n
> =C2=A0- gettext docs: add "Testing marked strings" section to po/READ=
ME
> =C2=A0- gettext docs: the Git::I18N Perl interface
> =C2=A0- gettext docs: the git-sh-i18n.sh Shell interface
> =C2=A0- gettext docs: the gettext.h C interface
> =C2=A0- gettext docs: add "Marking strings for translation" section i=
n po/README
> =C2=A0- gettext docs: add a "Testing your changes" section to po/READ=
ME
> =C2=A0- po/pl.po: add Polish translation
> =C2=A0- po/hi.po: add Hindi Translation
> =C2=A0- po/en_GB.po: add British English translation
> =C2=A0- po/de.po: add German translation
> =C2=A0- Makefile: only add gettext tests on XGETTEXT_INCLUDE_TESTS=3D=
YesPlease
> =C2=A0- gettext docs: add po/README file documenting Git's gettext
> =C2=A0- gettextize: git-am printf(1) message to eval_gettext
> =C2=A0- gettextize: git-am core say messages
> =C2=A0- gettextize: git-am "Apply?" message
> =C2=A0- gettextize: git-am clean_abort messages
> =C2=A0- gettextize: git-am cannot_fallback messages
> =C2=A0- gettextize: git-am die messages
> =C2=A0- gettextize: git-am eval_gettext messages
> =C2=A0- gettextize: git-am multi-line getttext $msg; echo
> =C2=A0- gettextize: git-am one-line gettext $msg; echo
> =C2=A0- gettextize: git-am add git-sh-i18n
> =C2=A0- gettext tests: add GETTEXT_POISON tests for shell scripts
> =C2=A0- gettext tests: add GETTEXT_POISON support for shell scripts
> =C2=A0- Makefile: MSGFMT=3D"msgfmt --check" under GNU_GETTEXT
> =C2=A0- Makefile: add GNU_GETTEXT, set when we expect GNU gettext
> =C2=A0- gettextize: git-shortlog basic messages
> =C2=A0- gettextize: git-revert split up "could not revert/apply" mess=
age
> =C2=A0- gettextize: git-revert literal "me" messages
> =C2=A0- gettextize: git-revert "Your local changes" message
> =C2=A0- gettextize: git-revert basic messages
> =C2=A0- gettextize: git-notes "Refusing to %s notes in %s" message
> =C2=A0- gettextize: git-notes GIT_NOTES_REWRITE_MODE error message
> =C2=A0- gettextize: git-notes basic commands
> =C2=A0- gettextize: git-gc "Auto packing the repository" message
> =C2=A0- gettextize: git-gc basic messages
> =C2=A0- gettextize: git-describe basic messages
> =C2=A0- gettextize: git-clean clean.requireForce messages
> =C2=A0- gettextize: git-clean basic messages
> =C2=A0- gettextize: git-bundle basic messages
> =C2=A0- gettextize: git-archive basic messages
> =C2=A0- gettextize: git-status "renamed: " message
> =C2=A0- gettextize: git-status "Initial commit" message
> =C2=A0- gettextize: git-status "Changes to be committed" message
> =C2=A0- gettextize: git-status shortstatus messages
> =C2=A0- gettextize: git-status "nothing to commit" messages
> =C2=A0- gettextize: git-status basic messages
> =C2=A0- gettextize: git-push "prevent you from losing" message
> =C2=A0- gettextize: git-push basic messages
> =C2=A0- gettextize: git-tag tag_template message
> =C2=A0- gettextize: git-tag basic messages
> =C2=A0- gettextize: git-reset "Unstaged changes after reset" message
> =C2=A0- gettextize: git-reset reset_type_names messages
> =C2=A0- gettextize: git-reset basic messages
> =C2=A0- gettextize: git-rm basic messages
> =C2=A0- gettextize: git-mv "bad" messages
> =C2=A0- gettextize: git-mv basic messages
> =C2=A0- gettextize: git-merge "Wonderful" message
> =C2=A0- gettextize: git-merge "You have not concluded your merge" mes=
sages
> =C2=A0- gettextize: git-merge "Updating %s..%s" message
> =C2=A0- gettextize: git-merge basic messages
> =C2=A0- gettextize: git-log "--OPT does not make sense" messages
> =C2=A0- gettextize: git-log basic messages
> =C2=A0- gettextize: git-grep "--open-files-in-pager" message
> =C2=A0- gettextize: git-grep basic messages
> =C2=A0- gettextize: git-fetch split up "(non-fast-forward)" message
> =C2=A0- gettextize: git-fetch update_local_ref messages
> =C2=A0- gettextize: git-fetch formatting messages
> =C2=A0- gettextize: git-fetch basic messages
> =C2=A0- gettextize: git-diff basic messages
> =C2=A0- gettextize: git-commit advice messages
> =C2=A0- gettextize: git-commit "enter the commit message" message
> =C2=A0- gettextize: git-commit print_summary messages
> =C2=A0- gettextize: git-commit formatting messages
> =C2=A0- gettextize: git-commit "middle of a merge" message
> =C2=A0- gettextize: git-commit basic messages
> =C2=A0- gettextize: git-checkout "Switched to a .. branch" message
> =C2=A0- gettextize: git-checkout "HEAD is now at" message
> =C2=A0- gettextize: git-checkout describe_detached_head messages
> =C2=A0- gettextize: git-checkout: our/their version message
> =C2=A0- gettextize: git-checkout basic messages
> =C2=A0- gettextize: git-branch "(no branch)" message
> =C2=A0- gettextize: git-branch "git branch -v" messages
> =C2=A0- gettextize: git-branch "Deleted branch [...]" message
> =C2=A0- gettextize: git-branch "remote branch '%s' not found" message
> =C2=A0- gettextize: git-branch basic messages
> =C2=A0- gettextize: git-add refresh_index message
> =C2=A0- gettextize: git-add "remove '%s'" message
> =C2=A0- gettextize: git-add "pathspec [...] did not match" message
> =C2=A0- gettextize: git-add "Use -f if you really want" message
> =C2=A0- gettextize: git-add "no files added" message
> =C2=A0- gettextize: git-add basic messages
> =C2=A0- gettextize: git-clone "Cloning into" message
> =C2=A0- gettextize: git-clone basic messages
> =C2=A0- gettext tests: test message re-encoding under C
> =C2=A0- po/is.po: add Icelandic translation
> =C2=A0- gettext tests: mark a test message as not needing translation
> =C2=A0- gettext tests: test re-encoding with a UTF-8 msgid under Shel=
l
> =C2=A0- gettext tests: test message re-encoding under Shell
> =C2=A0- gettext tests: add detection for is_IS.ISO-8859-1 locale
> =C2=A0- gettext tests: test if $VERSION exists before using it
> =C2=A0- gettextize: git-init "Initialized [...] repository" message
> =C2=A0- gettextize: git-init basic messages
> =C2=A0- gettext tests: skip lib-gettext.sh tests under GETTEXT_POISON
> =C2=A0- gettext tests: add GETTEXT_POISON=3DYesPlease Makefile parame=
ter
> =C2=A0- gettext.c: use libcharset.h instead of langinfo.h when availa=
ble
> =C2=A0- gettext.c: work around us not using setlocale(LC_CTYPE, "")
> =C2=A0- builtin.h: Include gettext.h
> =C2=A0- Makefile: use variables and shorter lines for xgettext
> =C2=A0- Makefile: tell xgettext(1) that our source is in UTF-8
> =C2=A0- Makefile: provide a --msgid-bugs-address to xgettext(1)
> =C2=A0- Makefile: A variable for options used by xgettext(1) calls
> =C2=A0- gettext tests: locate i18n lib&data correctly under --valgrin=
d
> =C2=A0- gettext: setlocale(LC_CTYPE, "") breaks Git's C function assu=
mptions
> =C2=A0- gettext tests: rename test to work around GNU gettext bug
> =C2=A0- gettext: add infrastructure for translating Git with gettext
> =C2=A0- builtin: use builtin.h for all builtin commands
> =C2=A0- tests: use test_cmp instead of piping to diff(1)
> =C2=A0- t7004-tag.sh: re-arrange git tag comment for clarity
>
> Will merge to 'next' to see what happens; it is getting ridiculously
> painful to keep re-resolving the conflicts with other topics in fligh=
t,
> even with the help with rerere.

I'll supply some stuff on top of it. Like git-sh-i18n--envsubst soon.

Not essential, since next can be rewound. But useful and less buggier.

And thanks. Getting out out of the "pu" purgatory will be nice :)
