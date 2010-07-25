From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: git gui problem
Date: Sun, 25 Jul 2010 22:24:36 +0100
Message-ID: <877hkjw8yz.fsf@fox.patthoyts.tk>
References: <AANLkTinDSwL7hjza5eruKjZUIxUD0TkpSXmcM-UWu-Fs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Justin Fedick <justin.fedick@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 23:24:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od8gp-0001g4-V0
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 23:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755Ab0GYVYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 17:24:50 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:50739 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752103Ab0GYVYt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jul 2010 17:24:49 -0400
Received: from [172.23.170.136] (helo=anti-virus01-07)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Od8gh-00039s-Sb; Sun, 25 Jul 2010 22:24:47 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1Od8gZ-0004th-8l; Sun, 25 Jul 2010 22:24:39 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 7A39822B77; Sun, 25 Jul 2010 22:24:36 +0100 (BST)
X-Url: http://www.patthoyts.tk/
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
In-Reply-To: <AANLkTinDSwL7hjza5eruKjZUIxUD0TkpSXmcM-UWu-Fs@mail.gmail.com> (Justin Fedick's message of "Thu\, 22 Jul 2010 22\:31\:38 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151794>

Justin Fedick <justin.fedick@gmail.com> writes:

>Hey everyone,
>
>I'm having trouble trying to view the git gui. I'm using OSX and I
>can't seem to get the GUI to come up. When I type "git gui" in the
>root directory of my project, it the icon comes up in my dock and the
>toolbar switches to the git gui toolbar at the top, but the window
>never comes up. When I click on the icon at the bottom, my project
>address comes up at the top of that menu, but when I click on it no
>window appears. Any help here would be great.
>
>If that was unclear (which I'm sure if was), please ask any questions
>that you think would help clear up any confusion. I need to get this
>back up ASAP so I can continue to work on my app.

I'm not at all familiar with MacOS but I believe wish on Mac
implements the console command as on Windows so you could try adding
'console show' near the top of the file (say just after the line
renaming the send command). This should then give you a way to explore
the running application. If it shows but then fails to paint maybe
it is stuck in some kind of loop. Or maybe a 'wm deiconify .' will
show the hidden main window - sounds like the main window is hidden to
me.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
