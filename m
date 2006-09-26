From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: [PATCH] gitk: add some key-bind
Date: Wed, 27 Sep 2006 00:27:06 +0900
Message-ID: <87y7s61wdx.fsf_-_@duaron.myhome.or.jp>
References: <873bag12k3.fsf@duaron.myhome.or.jp>
	<7vpsdjryj2.fsf@assigned-by-dhcp.cox.net>
	<873bae3b5x.fsf_-_@duaron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Sep 26 17:34:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSEsy-0005Be-VL
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 17:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWIZPaN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 11:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWIZPaN
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 11:30:13 -0400
Received: from mail.parknet.jp ([210.171.160.80]:53769 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932123AbWIZPaL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 11:30:11 -0400
X-AuthUser: hirofumi@parknet.jp
Received: from ibmpc.myhome.or.jp ([210.171.168.39]:1951)
	by parknet.jp with [XMail 1.21 ESMTP Server]
	id <SACAC> for <git@vger.kernel.org> from <hirofumi@mail.parknet.co.jp>;
	Wed, 27 Sep 2006 00:29:10 +0900
Received: from duaron.myhome.or.jp (duaron.myhome.or.jp [192.168.0.2])
	by ibmpc.myhome.or.jp (8.13.8/8.13.8/Debian-2) with ESMTP id k8QFS8pJ004855
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 27 Sep 2006 00:28:10 +0900
Received: from duaron.myhome.or.jp (localhost [127.0.0.1])
	by duaron.myhome.or.jp (8.13.8/8.13.8/Debian-2) with ESMTP id k8QFS7vp005300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 27 Sep 2006 00:28:07 +0900
Received: (from hirofumi@localhost)
	by duaron.myhome.or.jp (8.13.8/8.13.8/Submit) id k8QFR7GG005031;
	Wed, 27 Sep 2006 00:27:07 +0900
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <873bae3b5x.fsf_-_@duaron.myhome.or.jp> (OGAWA Hirofumi's message of "Wed\, 27 Sep 2006 00\:22\:34 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27799>

This add initial user of prevfile(), and additional some key-binds for
emacs users.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 gitk |    6 ++++++
 1 file changed, 6 insertions(+)

diff -puN gitk~gitk-key-emacs gitk
--- git/gitk~gitk-key-emacs	2006-09-27 00:17:31.000000000 +0900
+++ git-hirofumi/gitk	2006-09-27 00:17:31.000000000 +0900
@@ -672,6 +672,10 @@ proc makewindow {} {
     bind . <Control-Key-Down> "allcanvs yview scroll 1 units"
     bind . <Control-Key-Prior> "allcanvs yview scroll -1 pages"
     bind . <Control-Key-Next> "allcanvs yview scroll 1 pages"
+    bind . <Control-p> "$ctext yview scroll -1 units"
+    bind . <Control-n> "$ctext yview scroll 1 units"
+    bind . <Alt-v> "$ctext yview scroll -1 pages"
+    bind . <Control-v> "$ctext yview scroll 1 pages"
     bindkey <Key-Delete> "$ctext yview scroll -1 pages"
     bindkey <Key-BackSpace> "$ctext yview scroll -1 pages"
     bindkey <Key-space> "$ctext yview scroll 1 pages"
@@ -690,6 +694,8 @@ proc makewindow {} {
     bindkey <Key-Return> {findnext 0}
     bindkey ? findprev
     bindkey f nextfile
+    bindkey P prevfile
+    bindkey N nextfile
     bind . <Control-q> doquit
     bind . <Control-f> dofind
     bind . <Control-g> {findnext 0}
_
