From: Christian Couder <christian.couder@gmail.com>
Subject: Re: seg fault in "git format-patch"
Date: Sun, 31 May 2015 22:26:15 +0200
Message-ID: <CAP8UFD0Pi3_hF0+S3AXktD5NkBL_Q1mU_oN4fULyZemDEUr8Jg@mail.gmail.com>
References: <556B5D4C.4030406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Development <git@vger.kernel.org>
To: Bruce Korb <bruce.korb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 22:26:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yz9oP-0000Bu-Os
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 22:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758422AbbEaU0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 16:26:17 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37721 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbbEaU0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 16:26:16 -0400
Received: by wifw1 with SMTP id w1so81952670wif.0
        for <git@vger.kernel.org>; Sun, 31 May 2015 13:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=85AIjCQCLvAWeY3MVdqtPMcJhLbbmBnkyMh13n54yQg=;
        b=SFgYSln9dV0cfF5d2UxuwA6YrD78pzwqdJ3z+YO6hX0cdsgpf+kRtZLP7vLdJzzgFi
         CB8lTrTxPodZ0fEtPBdxCnj81t49ifPDuDzyZ8xvbO+9MKLlrDJgkOcUhELS21/rVm/U
         AsVTFBbvy8XSGzKybl5Ig3Z/C5+QSnAbsVjYoU9+LRnkVhMtb7wRkrhoZCzniTN4DllB
         mEwnfNDZAuoggYMYB51avZuXdtjAYFrf/7ySN6b0gDCGN2IEmifl0phud6qwVwk9TKcJ
         n5ct7mkWB1BJoMO10inUr6537aPu56dTcRwPXL6VIyF1M666UYM5TirgUS5i+iS21zvC
         kmxA==
X-Received: by 10.194.178.227 with SMTP id db3mr21713247wjc.82.1433103975041;
 Sun, 31 May 2015 13:26:15 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Sun, 31 May 2015 13:26:15 -0700 (PDT)
In-Reply-To: <556B5D4C.4030406@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270349>

On Sun, May 31, 2015 at 9:13 PM, Bruce Korb <bruce.korb@gmail.com> wrote:
> $ git format-patch -o patches --ignore-if-in-upstream
> 14949fa8f39d29e44b43f4332ffaf35f11546502..2de9eef391259dfc8748dbaf76a5d55427f37b0d
> Segmentation fault
> /u/gnu/proj/gnu-pw-mgr
> $ git format-patch -o patches
> 14949fa8f39d29e44b43f4332ffaf35f11546502..2de9eef391259dfc8748dbaf76a5d55427f37b0d
> patches/0001-remove-dead-code.patch
> patches/0002-dead-code-removal.patch
> patches/0003-add-sort-pw-cfg-program.patch
> patches/0004-add-doc-for-sort-pw-cfg.patch
> patches/0005-clean-up-doc-makefile.patch
> patches/0006-clean-up-doc-makefile.patch
> patches/0007-happy-2015-and-add-delete-option.patch
> patches/0008-fix-doc-Makefile.am.patch
> patches/0009-re-fix-copyright.patch
> patches/0010-finish-debugging-remove_pwid.patch
> patches/0011-only-update-file-if-something-was-removed.patch
> patches/0012-update-NEWS.patch
> patches/0013-bootstrap-cleanup.patch

Could you tell us which git version you are using? You can use "git --version".
The operating system you are using could also be useful.
And maybe you could also run git under gdb and give us the output of
the "bt" (backtrace) gdb command when it crashes?

Thanks,
Christian.
