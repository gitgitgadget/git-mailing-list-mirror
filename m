From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2010, #05; Sat, 21)
Date: Mon, 23 Aug 2010 18:51:49 +0000
Message-ID: <AANLkTin-3d6mDvW3ET1wGyTwvSOaL8CTKK0uZiFiEkz_@mail.gmail.com>
References: <7v4oen5clj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 20:51:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Onc7g-00015m-Bf
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 20:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069Ab0HWSvv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Aug 2010 14:51:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53095 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107Ab0HWSvu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Aug 2010 14:51:50 -0400
Received: by fxm13 with SMTP id 13so3217929fxm.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 11:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kN6Qtk7shedMQhZQkf+JGUYTAiTJ740wKRE67yddZfM=;
        b=KSgiDKz3kdLBd8VWV93v7tpWh5x77Prn0VbHPzzpLD6PDzHgg8j5Z3XmkVP501JObv
         zJxjv9dwhSyRROdn5EcCrybjUVMAanOKLGPO4QtKwX9kHfSDdo1VGsv3P6FkpBSBXLbZ
         P2TZY8pSPMk/NC/gZ4vLEVJaLASUUrf0yCCME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=d+EpIGsY7I8SdA7FTamSGKdvZtEBIEKonfCo/P+E9qt/G/ZsNN042Ey0w7cNc3osp3
         NFasBRw7/z78IL1g7QFXDipqjkNa5ug1iZcqROg5350p9vSqj46XcSD3ylVoemedrdL4
         9rNiEeEBzhfzEMARysZIexN8mcprDcG8wcjPU=
Received: by 10.223.109.2 with SMTP id h2mr4787333fap.95.1282589509217; Mon,
 23 Aug 2010 11:51:49 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Mon, 23 Aug 2010 11:51:49 -0700 (PDT)
In-Reply-To: <7v4oen5clj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154243>

On Sun, Aug 22, 2010 at 07:30, Junio C Hamano <gitster@pobox.com> wrote=
:

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

=46WIW I won't be submitting new stuff on top of this for a while. So a=
s
far as that's concerned it can go into next.
