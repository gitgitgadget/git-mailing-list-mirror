From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Has someone tried to do "git revert <commit> -- <path>"
Date: Mon, 28 Nov 2011 16:46:18 +0100
Message-ID: <CACBZZX6H7g711C9yoi4pv_DWv021P4vfn-CvVYa-7zufqSQeJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 28 16:46:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RV3Pr-0007IG-59
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 16:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076Ab1K1Pql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 10:46:41 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45511 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000Ab1K1Pqk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 10:46:40 -0500
Received: by faas1 with SMTP id s1so2766553faa.19
        for <git@vger.kernel.org>; Mon, 28 Nov 2011 07:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=7lyX7XXhjGlOP2YxRupvPwvvjzjiGAU0h4zEGGfRhgQ=;
        b=E/5fXk+t3gxp6t+KNhhoNu3LwcQ+8FNgf9ILvGvzL91oo0xwxsTY0p61DVW1OaeDbG
         iQh5SNurmDF+C6MxAVLV7MGecSEgpWjOVC+AaXp93usGhv62Qbgo3q+JbIBzAGXadDOu
         gfmOvhGizDzSCvvH/bpri85cDcYPd6Q0/NhA0=
Received: by 10.204.152.4 with SMTP id e4mr45303008bkw.56.1322495199122; Mon,
 28 Nov 2011 07:46:39 -0800 (PST)
Received: by 10.204.69.71 with HTTP; Mon, 28 Nov 2011 07:46:18 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186018>

Sometimes I want to partially revert a commit, what I'll do is:

    git revert --no-commit <commit> &&
    git reset &&
    git add <paths> &&
    git commit

At which point I'll manually type in the commit window:

    Partially revert "description(<commit>)"

    This partially reverts <commit>. Only <paths> have been reverted.

Has someone tried to patch the revert logic to just support an
optional paths parameter, in which case this wouldn't need to be so
hard.
