From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2010, #04; Wed, 18)
Date: Thu, 19 Aug 2010 12:53:16 +0000
Message-ID: <AANLkTim9AHj0oLkbdQ8dnjWYxDNnVQQ7q=7AfhZynetN@mail.gmail.com>
References: <7vfwyb8skr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 14:53:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om4ch-00031N-FR
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 14:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986Ab0HSMxU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 08:53:20 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53775 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab0HSMxS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Aug 2010 08:53:18 -0400
Received: by fxm13 with SMTP id 13so982827fxm.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 05:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RvfWtBi8ZpKHJFJlGvYiHZkhXmg0Fk7NuBrgKViUXSU=;
        b=ptRR+slwf49L/M1qw6u5AxX2OfI8oQ9sGOvH7LkUJJ6JLU9uonxOP/7bHKCHQJm0Sz
         9/ccWsqWsk2bhviQ3ISItT6RGuuatPm82uHZl/7g3VT0KSCZvXwYoBvrX6uRv+TzfReo
         tkUxt1ONX7WxvymzBMXLcIRHxh7yeztFakJ1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dsmCUs5lt+gSCktxbTsOdVhASpk9FVeq8aril73/Ah3SM+rfX21ZMNX4qCaTNoHVV4
         pI5BcKdSy8ZgSrDdUqSPx5+mOOZH5anl7fN0cof6/xSG5UGacCtWhlTCw0dPaCfLgQam
         P12rfFzFVUvPR35T8jSwcueaTQP3cm+Yzh2DE=
Received: by 10.223.111.137 with SMTP id s9mr9316307fap.30.1282222396786; Thu,
 19 Aug 2010 05:53:16 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Thu, 19 Aug 2010 05:53:16 -0700 (PDT)
In-Reply-To: <7vfwyb8skr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153920>

On Wed, Aug 18, 2010 at 22:27, Junio C Hamano <gitster@pobox.com> wrote=
:

> [New Topics]
>
> * ab/maint-reset-mixed-w-pathspec-advice (2010-08-15) 1 commit
> =C2=A0- reset: Better warning message on git reset --mixed <paths>
>
> Probably needs a "better" title; the commit shouldn't advertise itsel=
f
> being "better" (or "clean" for that matter), but say what it changed =
and
> leave it to the readers to judge if it is better.

s/Better/Clarify/ is as good as I can make it without making the
subject line too long.

> * ab/test-1 (2010-08-18) 5 commits
> =C2=A0. t/t0000-basic.sh: Run the passing TODO test inside its own te=
st-lib
> =C2=A0. test-lib: Allow overriding of TEST_DIRECTORY
> =C2=A0. test-lib: Use "$GIT_BUILD_DIR" instead of "$TEST_DIRECTORY"/.=
=2E/
> =C2=A0. test-lib: Use $TEST_DIRECTORY or $GIT_BUILD_DIR instead of $(=
pwd) and ../
> =C2=A0. Merge branch 'ab/i18n' into ab/test-1
> =C2=A0(this branch uses ab/i18n and ab/test.)
>
> Not merged to 'pu' as it seemed to have broken something.

What does it seem to have broken? I can't fix it if I don't know
what's wrong. It Works For Me.

> * ab/perl-install (2010-08-03) 1 commit
> =C2=A0(merged to 'next' on 2010-08-14 at f2a27ee)
> =C2=A0+ perl/Makefile: Unset INSTALL_BASE when making perl.mak
>
> * ab/test (2010-08-16) 43 commits
> =C2=A0(merged to 'next' on 2010-08-18 at f88bdb1)
> =C2=A0+ cvs tests: do not touch test CVS repositories shipped with so=
urce
> =C2=A0+ t/t9602-cvsimport-branches-tags.sh: Add a PERL prerequisite
> =C2=A0+ t/t9601-cvsimport-vendor-branch.sh: Add a PERL prerequisite
> =C2=A0+ t/t7105-reset-patch.sh: Add a PERL prerequisite
> =C2=A0+ t/t9001-send-email.sh: convert setup code to tests
> =C2=A0+ t/t9001-send-email.sh: change from skip_all=3D* to prereq ski=
p
> =C2=A0+ t/t9001-send-email.sh: Remove needless PROG=3D* assignment
> =C2=A0+ t/t9600-cvsimport.sh: change from skip_all=3D* to prereq skip
> =C2=A0+ lib-patch-mode tests: change from skip_all=3D* to prereq skip
> =C2=A0+ t/t3701-add-interactive.sh: change from skip_all=3D* to prere=
q skip
> =C2=A0+ tests: Move FILEMODE prerequisite to lib-prereq-FILEMODE.sh
> =C2=A0+ t/Makefile: Create test-results dir for smoke target
> =C2=A0+ git-notes: Run partial expensive test everywhere
> =C2=A0+ t/t3300-funny-names: change from skip_all=3D* to prereq skip
> =C2=A0+ t/t3902-quoted: change from skip_all=3D* to prereq skip
> =C2=A0+ t/t4016-diff-quote: change from skip_all=3D* to prereq skip
> =C2=A0+ t/t5503-tagfollow: change from skip_all=3D* to prereq skip
> =C2=A0+ t/t7005-editor: change from skip_all=3D* to prereq skip
> =C2=A0+ t/t5705-clone-2gb: change from skip_all=3D* to prereq skip
> =C2=A0+ t/t1304-default-acl: change from skip_all=3D* to prereq skip
> =C2=A0+ t/README: Update "Skipping tests" to align with best practice=
s
> =C2=A0+ t/t7800-difftool.sh: Skip with prereq on no PERL
> =C2=A0+ t/t5800-remote-helpers.sh: Skip with prereq on python <2.4
> =C2=A0+ t/t4004-diff-rename-symlink.sh: use three-arg <prereq>
> =C2=A0+ tests: implicitly skip SYMLINKS tests using <prereq>
> =C2=A0+ Makefile: make gcov invocation configurable
> =C2=A0+ t/README: Add a note about the dangers of coverage chasing
> =C2=A0+ t/README: A new section about test coverage
> =C2=A0+ Makefile: Add cover_db_html target
> =C2=A0+ Makefile: Add cover_db target
> =C2=A0+ Makefile: Split out the untested functions target
> =C2=A0+ Makefile: Include subdirectories in "make cover" reports
> =C2=A0+ gitignore: Ignore files generated by "make coverage"
> =C2=A0+ t/README: Add SMOKE_{COMMENT,TAGS}=3D to smoke_report target
> =C2=A0+ t/Makefile: Can't include GIT-BUILD-OPTIONS, it's a .sh
> =C2=A0+ t/README: Document the Smoke testing
> =C2=A0+ tests: Infrastructure for Git smoke testing
> =C2=A0+ test-lib: Multi-prereq support only checked the last prereq
> =C2=A0+ tests: A SANITY test prereq for testing if we're root
> =C2=A0+ t/README: Document the predefined test prerequisites
> =C2=A0+ test-lib: Print missing prerequisites in test output
> =C2=A0+ test-lib: Add support for multiple test prerequisites
> =C2=A0+ test-lib: Don't write test-results when HARNESS_ACTIVE
> =C2=A0(this branch is used by ab/test-1.)
>
> Previously many individual topic branches from the same author, all
> regarding tests. =C2=A0I thought it probably was ready for 'next' but=
 was
> holding off as we seem to still keep getting many fixes on top.

Thanks for merging these.

> * ab/i18n (2010-07-25) 4 commits
> =C2=A0- tests: locate i18n lib&data correctly under --valgrind
> =C2=A0- gettext: setlocale(LC_CTYPE, "") breaks Git's C function assu=
mptions
> =C2=A0- tests: rename test to work around GNU gettext bug
> =C2=A0- Add infrastructure for translating Git with gettext
> =C2=A0(this branch is used by ab/test-1.)

mmm, i18n brewing :)
