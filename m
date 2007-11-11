From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t7005 and vi in GIT_EXEC_PATH
Date: Sun, 11 Nov 2007 15:58:18 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711111557370.4362@racer.site>
References: <9A9986E7-E03D-458A-9A19-A3EF0E7B203D@silverinsanity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 16:59:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrFCx-0000y6-PG
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 16:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755089AbXKKP6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 10:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754945AbXKKP6b
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 10:58:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:55463 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754755AbXKKP6a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 10:58:30 -0500
Received: (qmail invoked by alias); 11 Nov 2007 15:58:28 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp036) with SMTP; 11 Nov 2007 16:58:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX192B5px0+l2XyK8QAA1XAxbvMTSO4ngoDaFpwD1Ui
	njCjaYig2R1pdA
X-X-Sender: gene099@racer.site
In-Reply-To: <9A9986E7-E03D-458A-9A19-A3EF0E7B203D@silverinsanity.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64470>

Hi,

On Sat, 10 Nov 2007, Brian Gernhardt wrote:

> If vi is in GIT_EXEC_PATH, then t7005-editor.sh fails because the real 
> vi is invoked instead of the test vi script.  This is because the git 
> wrapper puts GIT_EXEC_PATH ahead of ".".  I see no easy solution to this 
> problem, and thought I should bring it up with the list.

I don't understand.  GIT_EXEC_PATH should be set to the build directory 
when you are running the tests.  Unless you copy vi _there_, you should 
not have any problem.

Ciao,
Dscho
