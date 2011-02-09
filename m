From: Yann Dirson <dirson@bertin.fr>
Subject: grub-mkrescue: manpage points to non-existent info doc
Date: Wed, 09 Feb 2011 09:18:45 +0100
Organization: Bertin Technologies
Message-ID: <20110209091845.2145da9b@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 09 09:33:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn5UU-0000dq-9l
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 09:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835Ab1BIId3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 03:33:29 -0500
Received: from blois.bertin.fr ([195.68.26.9]:61155 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075Ab1BIId2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 03:33:28 -0500
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 88F65542B4
	for <git@vger.kernel.org>; Wed,  9 Feb 2011 09:33:27 +0100 (CET)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 6736D542B2
	for <git@vger.kernel.org>; Wed,  9 Feb 2011 09:33:27 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0LGC00BI6D3QD960@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Wed, 09 Feb 2011 09:33:27 +0100 (CET)
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-6.5.0.1024-17944.005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166396>

Package: grub-common
Version: 1.99~20110112-1

manpage says:

       The full documentation for grub-mkrescue is maintained as a
       Texinfo manual.  If the info and grub-mkrescue programs are
       properly installed at your site, the command

              info grub-mkrescue

       should give you access to the complete manual.

info doc is not present, and apt-file confirms it does not exist:

$ apt-file search grub-mkrescue
grub-common: /usr/bin/grub-mkrescue
grub-common: /usr/share/man/man1/grub-mkrescue.1.gz


-- 
Yann Dirson - Bertin Technologies
