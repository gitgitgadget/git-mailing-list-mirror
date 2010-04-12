From: Mihamina Rakotomandimby <mihamina@gulfsat.mg>
Subject: simplest git deamon?
Date: Mon, 12 Apr 2010 16:47:40 +0300
Organization: Gulfsat
Message-ID: <20100412164740.740050cb@pbmiha.malagasy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 12 16:17:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1KS7-00056a-Pn
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 16:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356Ab0DLORW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 10:17:22 -0400
Received: from static-104-36.blueline.mg ([41.204.104.36]:58904 "EHLO
	mail.blueline.mg" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751151Ab0DLORW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 10:17:22 -0400
X-Greylist: delayed 1522 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Apr 2010 10:17:21 EDT
Received: from localhost (static-104-53.blueline.mg [41.204.104.53])
	by mail.blueline.mg (Postfix) with ESMTP id B58BBF92B
	for <git@vger.kernel.org>; Mon, 12 Apr 2010 16:52:02 +0300 (EAT)
X-Virus-Scanned: par antivirus2.malagasy.com
X-Spam-Flag: NO
X-Spam-Score: -2.778
X-Spam-Level: 
X-Spam-Status: No, score=-2.778 required=7 tests=[AWL=-0.179, BAYES_00=-2.599]
Received: from mail.blueline.mg ([41.204.104.38])
	by localhost (antivirus2.malagasy.com [41.204.104.53]) (amavisd-new, port 10024)
	with ESMTP id MBgqtwz2Mx39 for <git@vger.kernel.org>;
	Mon, 12 Apr 2010 16:51:47 +0300 (EAT)
Received: from pbmiha.malagasy.com (freedsl-1.blueline.mg [41.204.101.82])
	by mail.blueline.mg (Postfix) with ESMTP id 52EBEF81F
	for <git@vger.kernel.org>; Mon, 12 Apr 2010 16:47:51 +0300 (EAT)
Received: from localhost ([127.0.0.1] helo=pbmiha.malagasy.com)
	by pbmiha.malagasy.com with esmtp (Exim 4.69)
	(envelope-from <mihamina@gulfsat.mg>)
	id 1O1JzJ-0001kL-24
	for git@vger.kernel.org; Mon, 12 Apr 2010 16:47:41 +0300
X-Mailer: Claws Mail 3.7.2 (GTK+ 2.18.3; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144730>

Manao ahoana, Hello, Bonjour,

I would like to setup a git repository, on a Debian machine.
I would like to access it only with git:// (no http://, no ssh://,...)

How to implement read/write restriction when just wanting to use
"git://" without dealing with SSH?

http://www.kernel.org/pub/software/scm/git/docs/everyday.html, at it's
bottom tlak about this but it requires SSH.
https://help.ubuntu.com/community/Git talks about gitosis, but it
requires keys.

I have the GIT repository setup, with the "git://"-only access scheme, 
but anyone may push into this.

I expected just a flat file the SVN way (But I dont want to use SVN):

  [users]
  alice: al_pass
  bob  : b_pass
  
  [groups]
  senior:alice,bob
  
  [permissions]
  @senior:all
  @anonymous:clone

How could I do that?

Misaotra, Thanks, Merci.

-- 
       Architecte Informatique chez Blueline/Gulfsat:
    Administration Systeme, Recherche & Developpement
                +261 34 29 155 34 / +261 33 11 207 36
