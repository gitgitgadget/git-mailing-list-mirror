From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH v2 3/3] gitk: Allow displaying time zones from author
 and commit timestamps
Date: Mon, 30 May 2011 17:45:40 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1105301739290.23145@dr-wily.mit.edu>
References: <alpine.DEB.2.02.1101191445130.23868@dr-wily.mit.edu> <alpine.DEB.2.02.1101191447340.23868@dr-wily.mit.edu> <20110529044656.GA8881@brick.ozlabs.ibm.com> <alpine.DEB.2.02.1105291740410.23145@dr-wily.mit.edu> <alpine.DEB.2.02.1105292305390.23145@dr-wily.mit.edu>
 <m2sjrw9e21.fsf@igel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon May 30 23:47:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRAJ4-0003BQ-Lt
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 23:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516Ab1E3Vpr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 17:45:47 -0400
Received: from DMZ-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.35]:58727 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751574Ab1E3Vpp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 17:45:45 -0400
X-AuditID: 12074423-b7babae000007c6b-3d-4de410014a6f
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
	by dmz-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 54.44.31851.10014ED4; Mon, 30 May 2011 17:45:37 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id p4ULji81028221;
	Mon, 30 May 2011 17:45:44 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p4ULjeEu023863
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 30 May 2011 17:45:43 -0400 (EDT)
In-Reply-To: <m2sjrw9e21.fsf@igel.home>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42IRYrdT0WUUeOJr8OCluEXXlW4mizVHFrNb
	9C/tYHNg9jh0uIPRY+6uPkaPz5vkApijuGxSUnMyy1KL9O0SuDL2z2lgKzjNXTFp4znmBsbZ
	nF2MnBwSAiYS39f/YoKwxSQu3FvP1sXIxSEksI9R4l3Xb0YIZwOjxNkT66Aye5gkznbcZu9i
	5OBgEdCWePcDbBKbgJrE3A2T2UFsEQEtiZ6JE9lAbGYBK4kza9aygtjCAokSe+/2g9VwCqhL
	tM84AlbDK+AoMefIUmaI+WuZJL4ffg12kqiArsTm7qVQRYISJ2c+YYEYqi5x4NNFRghbW+L+
	zTa2CYyCs5CUzUJSNgtJ2QJG5lWMsim5Vbq5iZk5xanJusXJiXl5qUW6Znq5mSV6qSmlmxjB
	Qe2ivIPxz0GlQ4wCHIxKPLzc+x/7CrEmlhVX5h5ilORgUhLlvc/1xFeILyk/pTIjsTgjvqg0
	J7X4EKMEB7OSCO83PqAcb0piZVVqUT5MSpqDRUmcd66kuq+QQHpiSWp2ampBahFMVoaDQ0mC
	V4IfqFGwKDU9tSItM6cEIc3EwQkynAdo+C2w4cUFibnFmekQ+VOMilLivIYgzQIgiYzSPLhe
	WNJ5xSgO9IowLz9IFQ8wYcF1vwIazAQ0uPfdQ5DBJYkIKakGRttNXB4/vm+0ymmvDpkonZ4s
	843NdMWrrlUOPNEfjsjvu8Yk+iLY3mHa+uromjnLMl/5/y/Y8ftalb+/onHjo9UsCWkS9XoP
	HVfGC59Yy9NU4/3DnEt90ufW09HLF6g9WvJIjOvfCbXClKipCmbvZKbfdjns3fEn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174780>

On Mon, 30 May 2011, Andreas Schwab wrote:
> > +		catch {set savedTZ $env(TZ)}
>                 if {[info exits env(TZ)]} {set savedTZ $env(TZ)}

That felt like a lot of noise just to save and restore an environment=20
variable, but since I more or less learned Tcl just to write this patch=
,=20
I=E2=80=99ll defer to your judgement of style here.

Thanks,
Anders


diff --git a/gitk b/gitk
index c77771e..6a4c8ed 100755
--- a/gitk
+++ b/gitk
@@ -11026,14 +11026,20 @@ proc formatdate {d} {
 	if {[string match {*%[zZ]*} $datetimeformat]} {
 	    if {[catch {set d [clock format [lindex $d 0] -timezone [lindex $=
d 1] -format $datetimeformat]}]} {
 		# Tcl < 8.5 does not support -timezone.  Emulate it by
-		# setting TZ=3DUnknown=C2=B1NNNN.
+		# setting TZ=3DUnknown=C2=B1NN:NN.
 		global env
-		catch {set savedTZ $env(TZ)}
+		if {[info exists env(TZ)]} {
+		    set savedTZ $env(TZ)
+		}
 		set zone [lindex $d 1]
 		set sign [string map {+ - - +} [string index $zone 0]]
 		set env(TZ) Unknown$sign[string range $zone 1 2]:[string range $zone=
 3 4]
 		set d [clock format [lindex $d 0] -format $datetimeformat]
-		if {[catch {set env(TZ) $savedTZ}]} {unset env(TZ)}
+		if {[info exists savedTZ]} {
+		    set env(TZ) $savedTZ
+		} else {
+		    unset env(TZ)
+		}
 	    }
 	} else {
 	    set d [clock format [lindex $d 0] -format $datetimeformat]
