From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: error: failed to push some refs
Date: Sat, 6 Mar 2010 18:18:49 -0800
Message-ID: <20100307021848.GI2529@spearce.org>
References: <15b345f1003061815y52a4e842u9373731cecd8ec60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Anderson <zelnaga@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 03:19:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No65C-0003Ol-05
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 03:19:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332Ab0CGCS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 21:18:59 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41882 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164Ab0CGCS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 21:18:59 -0500
Received: by gyh3 with SMTP id 3so307921gyh.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 18:18:58 -0800 (PST)
Received: by 10.151.21.17 with SMTP id y17mr2658739ybi.332.1267928338197;
        Sat, 06 Mar 2010 18:18:58 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 22sm3023229iwn.0.2010.03.06.18.18.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 18:18:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <15b345f1003061815y52a4e842u9373731cecd8ec60@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141633>

Thomas Anderson <zelnaga@gmail.com> wrote:
> I cloned git://github.com/symfony/symfony.git to C:/git/test-root and
> then cloned C:/git/test-root twice to C:/git/test-clone and
> C:/git/test-clone2.  I modify the README file in C:/git/test-clone,
> stage it, commit it and then try to push it to C:/git/test-root and
> get this message:
> 
> To prevent you from losing history, non-fast-forward updates were rejected
> Merge the remote changes before pushing again.  See the 'non-fast forward'
> section of 'git push --help' for details.
> Pushing to C:/git/test-root
> To C:/git/test-root
>  ! [rejected]        master -> master (non-fast forward)
> error: failed to push some refs to 'C:/git/test-root'
> 
> What does that even mean?

Exactly what the message said to you:

  To prevent you from losing history, non-fast-forward updates were rejected
  Merge the remote changes before pushing again.  See the 'non-fast forward'
  section of 'git push --help' for details.

Someone else (your other clone) modified your project in the interim.
To prevent losing their change, you need to use `git pull` to bring
in their work, merge it with your own, and then you can push it to
the destination.

For more details, check the `git push` manpage section suggested
by the error message above.

-- 
Shawn.
