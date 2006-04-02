From: "Paul Schulz" <pschulz01@gmail.com>
Subject: [Patch] Key help for gitk
Date: Sun, 2 Apr 2006 09:51:16 +0930
Message-ID: <cc9bf44d0604011621m1952b17er6f8c7e0fe1595b53@mail.gmail.com>
References: <cc9bf44d0604011616w18b9a7c3nc55a393f30a2b55a@mail.gmail.com>
Reply-To: paul@mawsonlakes.org
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_39802_20804967.1143937276578"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 02 02:21:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPqLp-0007ue-VT
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 02:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWDBAVS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Apr 2006 19:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWDBAVS
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Apr 2006 19:21:18 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:14297 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932325AbWDBAVR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Apr 2006 19:21:17 -0500
Received: by zproxy.gmail.com with SMTP id o37so1353845nzf
        for <git@vger.kernel.org>; Sat, 01 Apr 2006 16:21:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=hDcaif+pmmnd2znQzJ4iKT1NvuuRvS12OVFdlPZS0ezzSbbiycEp1Gwax9Npma6Pp8OkF2YrHWv5XjRspBT/498OKa6qMdKNslwWYlzf6bc6+q1f3PB/lY5xvjC/1NpQGsE2ZuB9f3srxbzruU6MUlUBlwjF7HNxNQ6IH79as9Q=
Received: by 10.35.9.2 with SMTP id m2mr304076pyi;
        Sat, 01 Apr 2006 16:21:16 -0800 (PST)
Received: by 10.35.105.2 with HTTP; Sat, 1 Apr 2006 16:21:16 -0800 (PST)
To: paulus@samba.org
In-Reply-To: <cc9bf44d0604011616w18b9a7c3nc55a393f30a2b55a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18251>

------=_Part_39802_20804967.1143937276578
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Greetings,

 gitk has a few more key options than I was aware (font
increase/decrease for example). The following patch adds some details
to the 'About' dialog.
 (These need to be reviewed for sanity, as I can't work out how the
search keys are ment to work.)

 Paul Schulz

------=_Part_39802_20804967.1143937276578
Content-Type: text/x-patch; name=patch-gitk-20060402.diff; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: quoted-printable
X-Attachment-Id: f_elim9fwe
Content-Disposition: attachment; filename="patch-gitk-20060402.diff"

diff --git a/gitk b/gitk
index fa1e83c..85d70d9 100755
--- a/gitk
+++ b/gitk
@@ -722,7 +722,41 @@ Gitk - a commit viewer for git
=20
 Copyright =A9 2005-2006 Paul Mackerras
=20
-Use and redistribute under the terms of the GNU General Public License} \
+Use and redistribute under the terms of the GNU General Public License
+
+Keys
+----
+<Down> - Move down a line
+<Up> - Move up a line
+<Right> -
+<Left> -
+<Delete> -
+<BackSpace> -
+<Space> - Scroll Diff
+p - Previous commit
+n - Next commit
+z - Go back (?)
+x - Go forward (?)
+i - Previuos line
+k - Next line
+j - Go back
+l - Go forward
+b - ?
+d - ?
+u - ?
+/ - Next find result (?)
+<Return> - Find result
+? - Previous find result
+f - Next file
+<Ctl-q> - Quit
+<Ctl-f> - Find
+<Ctl-g> - Find next
+<Ctl-r> - Find previous
+<Ctl-equal> - Incrument font size
+<Ctl-KP_Add> - Incrument font size
+<Ctl-minus> - Decrement font size
+<Ctl-KP_Subtract> - Decrement font size
+} \
 =09    -justify center -aspect 400
     pack $w.m -side top -fill x -padx 20 -pady 20
     button $w.ok -text Close -command "destroy $w"



------=_Part_39802_20804967.1143937276578--
