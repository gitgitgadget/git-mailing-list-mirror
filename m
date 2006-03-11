From: sean <seanlkml@sympatico.ca>
Subject: Re: annotate.perl triggers rpm bug
Date: Sat, 11 Mar 2006 02:39:28 -0500
Message-ID: <BAYC1-PASMTP05C2917E365D29EAEC88A0AEE20@CEZ.ICE>
References: <BAYC1-PASMTP0815EFABBF5266FB641C65AEED0@CEZ.ICE>
	<7v64mlxxq2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 11 08:41:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHyjN-0005QF-43
	for gcvg-git@gmane.org; Sat, 11 Mar 2006 08:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbWCKHlf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Mar 2006 02:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbWCKHlf
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Mar 2006 02:41:35 -0500
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]:502 "EHLO
	BAYC1-PASMTP05.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751630AbWCKHle (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Mar 2006 02:41:34 -0500
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP05.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 10 Mar 2006 23:41:33 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 64804644C28;
	Sat, 11 Mar 2006 02:41:32 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060311023928.538097fd.seanlkml@sympatico.ca>
In-Reply-To: <7v64mlxxq2.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.14; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 11 Mar 2006 07:41:34.0078 (UTC) FILETIME=[385EF1E0:01C644DF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 10 Mar 2006 23:11:01 -0800
Junio C Hamano <junkio@cox.net> wrote:

> Sheesh -- broken packaging.

Yeah, not rpm's proudest moment.

> How about upcasing the word like other lines?

That seems to fix the dependency problem too and makes a little
more sense.

Sean


diff --git a/git-annotate.perl b/git-annotate.perl
index feea0a2..9df72a1 100755
--- a/git-annotate.perl
+++ b/git-annotate.perl
@@ -20,7 +20,7 @@ sub usage() {
 	-r, --rename
 			Follow renames (Defaults on).
 	-S, --rev-file revs-file
-			use revs from revs-file instead of calling git-rev-list
+			Use revs from revs-file instead of calling git-rev-list
 	-h, --help
 			This message.
 ';
