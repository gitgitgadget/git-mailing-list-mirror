From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] git-gui USer's Survey 2007 (was: If you would write git from scratch now, what would you change?)
Date: Wed, 28 Nov 2007 00:59:41 +0100
Organization: At home
Message-ID: <fiib19$dj6$1@ger.gmane.org>
References: <200711252248.27904.jnareb@gmail.com> <fiet88$68n$1@ger.gmane.org> <e5bfff550711261125i92fb057i85d7217b18cd495d@mail.gmail.com> <20071127012013.GG14735@spearce.org> <fifstd$ilj$1@ger.gmane.org> <20071127015833.GL14735@spearce.org> <Pine.LNX.4.64.0711271136050.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 01:00:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxALy-0006Dq-Sa
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 01:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759703AbXK0X7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 18:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755982AbXK0X7x
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 18:59:53 -0500
Received: from main.gmane.org ([80.91.229.2]:36590 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759930AbXK0X7w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 18:59:52 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IxAL9-0004NE-QQ
	for git@vger.kernel.org; Tue, 27 Nov 2007 23:59:43 +0000
Received: from abvx114.neoplus.adsl.tpnet.pl ([83.8.221.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 23:59:43 +0000
Received: from jnareb by abvx114.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 23:59:43 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvx114.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66276>

Johannes Schindelin wrote:

> On Mon, 26 Nov 2007, Shawn O. Pearce wrote:
> 
>> Actually I might revisit this XUL concept using an HTTP server and AJAX.  
>> I could actually link the damn HTTP server against libgit.a (Junio will 
>> hate me).  If the server dies XUL can notice it and simply restart it.
> 
> But if you can restart the HTTP server via XUL, you can start other git 
> programs directly.
> 
> What you'd have to do is (urgh) write a wrapper via start_command() 
> which would recognize that the second process die()d.
> 
> All in all, I think if you want to switch from Tcl/Tk to another language 
> for git-gui, for the sake of attracting more developers, it might be wiser 
> to go Java than XUL.

Wont we get with the same problems as egit/jgit?

----
This is proposed set of questions for git-gui mini survey...

1. What language and what toolkit should git-gui be written in?
   (single choice)

   a. Tcl/Tk    (current implementation)
   b. C++/Qt
   c. C/GTK+
   d. Python    (native)
   e. Python/PyQt
   f. Python/PyGTK
   g. Ruby
   h. Java/Swing
   i. Java/SWT
   j. XUL+JavaScript+CSS/XULRunner
   k. other
   l. no opinion

2. If you have chosen "other" in question above, what language and
   toolkit should it be? C/XForms? C#/Mono? C/wxWidgets? XAML+Silverlight?
   GTK2-Perl? C/OpenGL? ;-)

3. Do you contribute to git-gui?
   Yes/No

4. If git-gui would use other language/toolkit, would you contribute?
   Yes/No

5. What languages and what toolkits you are proficient with (to send
   patches)? 
   (multiple choice)

   a. Tcl/Tk    (current implementation)
   b. C++/Qt
   c. C/GTK+
   d. Python    (native)
   e. Python/PyQt
   f. Python/PyGTK
   g. Ruby
   h. Java/Swing
   i. Java/SWT
   j. XUL+JavaScript+CSS/XULRunner
   k. other
   l. N/A

6. What other?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
