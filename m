From: David Krmpotic <david.krmpotic@gmail.com>
Subject: Fwd: segmentation fault 11
Date: Sun, 8 Feb 2015 18:56:14 +0100
Message-ID: <CAOFaZ+42Wbk8t_UmLGwxhRo+ZZOhpUT32o5wuj+LcJhaELOu5A@mail.gmail.com>
References: <CAOFaZ+5=bkWZpy1vFZjqMCgkWQySxGhLyfKhyH-VWDLJ28nTVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 18:57:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKW6O-0004Lr-EM
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 18:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758490AbbBHR44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 12:56:56 -0500
Received: from mail-qg0-f41.google.com ([209.85.192.41]:54842 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758454AbbBHR4z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 12:56:55 -0500
Received: by mail-qg0-f41.google.com with SMTP id i50so17710868qgf.0
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 09:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=EMSH45ScRl7MUSb3wSMT462nB37saZf7mwMbOFTG5CE=;
        b=hIe6kBRWfl1zfYAmpjw1jcVxZP2koF739FPLFWIh5ih5LEjVQFVSF9f4m6hflaI+YN
         iDUtCi1cNE01ARVmYivt/jBNM8MhLI2PoRjRQtjvT7OAN1QAsEqrxR34PHAzrHU3umJZ
         H2NMamgheqdiOLIqCcNnpziJIw12slWx/j04CIBYfmm7jpHrVVRkTrYMuHpIDNbCBMW6
         z87Nxn5+shNXZk73FULNLGB03k98V3bGE7WdWXe5lWjEtmUyZlv+Y3Q6aiERbKoFxh4k
         gU+dTjLM9mdii0yUOy42RSmaQ8CNyBwsAoIgVgrFTWaQN/Wk41QGrXUjDuJ+y3+nVsPQ
         Amgw==
X-Received: by 10.224.88.1 with SMTP id y1mr17869649qal.91.1423418214530; Sun,
 08 Feb 2015 09:56:54 -0800 (PST)
Received: by 10.140.37.52 with HTTP; Sun, 8 Feb 2015 09:56:14 -0800 (PST)
In-Reply-To: <CAOFaZ+5=bkWZpy1vFZjqMCgkWQySxGhLyfKhyH-VWDLJ28nTVQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263531>

I updated to 2.3.0 on my OSX 10.9.5 and when trying to push to github
(git push -u origin master), I get:

Segmentation fault: 11

Switched back to 1.8.5.5 and it works...

Report: http://cl.ly/1u3E412N0D2Z

Exception Type:  EXC_BAD_ACCESS (SIGSEGV)
Exception Codes: KERN_INVALID_ADDRESS at 0x0000000000000000

VM Regions Near 0:
-->
    __TEXT                 0000000102b1c000-0000000102c78000 [ 1392K]
r-x/rwx SM=COW  /usr/local/Cellar/git/2.3.0/bin/git

Thread 0 Crashed:: Dispatch queue: com.apple.main-thread
