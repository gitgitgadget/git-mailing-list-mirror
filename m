From: Steffen Prohaska <prohaska@zib.de>
Subject: GitMe: check if cygwin is in PATH; if so abort installer
Date: Sat, 11 Aug 2007 19:41:20 +0200
Message-ID: <3DA53F0C-9E1D-475F-BA7A-2B79D4FEFBCF@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 19:40:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJux8-0001M5-0P
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 19:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294AbXHKRkh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 13:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754178AbXHKRkh
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 13:40:37 -0400
Received: from mailer.zib.de ([130.73.108.11]:38011 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753822AbXHKRkf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 13:40:35 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7BHeWbL019559;
	Sat, 11 Aug 2007 19:40:33 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1a312.pool.einsundeins.de [77.177.163.18])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7BHeVSc005722
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 11 Aug 2007 19:40:32 +0200 (MEST)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55616>

Johannes, Marius,
I pushed a commit to msysgit.git's mob branch that adds
a check to the GitMe installer if cygwin is in the PATH:

32ad66aed4899bab11849bdecf254a823cb6cf4b GitMe: check if cygwin is in  
PATH; if so abort installer.

I did check the shell script but I didn't build a full
installer. The change seems obvious to me. However, I
did not verified it in a real-world test.

btw,
would you like to see patches sent to the list for review?
Or is pushing them to the mob branch sufficient? Pushing
them to mob only is much easier for me.

	Steffen
