From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Cloning marks pack for .keep
Date: Mon, 07 Jul 2008 23:27:46 +0200
Message-ID: <48728A52.8080107@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 07 23:28:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFyGT-0005WY-Jg
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 23:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756305AbYGGV1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 17:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756799AbYGGV1u
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 17:27:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:44660 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756277AbYGGV1t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 17:27:49 -0400
Received: (qmail invoked by alias); 07 Jul 2008 21:27:47 -0000
Received: from 89-186.1-85.cust.bluewin.ch (EHLO [192.168.123.202]) [85.1.186.89]
  by mail.gmx.net (mp007) with SMTP; 07 Jul 2008 23:27:47 +0200
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX18bSMJhjugbCN2JVbZYe5CEuscsk81Jei6kt/42tU
	PO2DKFBFIMMIBX
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
X-Enigmail-Version: 0.95.6
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87658>

After cloning a local repository with "git clone file://...", the
resulting repo had one big pack file, as expected, but also a
matching ".keep" file.  Certainly this is a bug, isn't it?  The
same happens if I clone git.git.  I used git 1.5.6.1 but observed
the same with the current master.  I bisected this behavior to
commit fa740529 by Shawn O. Pearce (CC'ing him).  Since this dates
back to 2007, I wonder if maybe only I am seeing this, but I
cannot think of any reason for it.

(I already mentioned this on IRC today.)

jlh
