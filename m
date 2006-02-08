From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: git + ssh + key authentication feature-request
Date: Wed, 8 Feb 2006 23:35:42 +0000
Message-ID: <200602082335.42449.alan@chandlerfamily.org.uk>
References: <43EA73C3.2040309@iaglans.de> <7vhd79o6m5.fsf@assigned-by-dhcp.cox.net> <43EA7D57.7040409@iaglans.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Feb 09 00:36:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6yqr-0005KW-KH
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 00:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422635AbWBHXfn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 18:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422636AbWBHXfn
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 18:35:43 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:37596
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1422635AbWBHXfm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 18:35:42 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1F6yqb-0004Fw-N8
	for git@vger.kernel.org; Wed, 08 Feb 2006 23:35:41 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
In-Reply-To: <43EA7D57.7040409@iaglans.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15761>

On Wednesday 08 February 2006 23:23, Nicolas Vilz 'niv' wrote:

> in my case it would be only one system-user which has full access to
> several repositories. At this time, the users which use that account,
> have to give a password, which isn't that bad... it would be easier and
> more secure for me, not to give a password, but ask the users for the
> ssh pubkey..

This sounds like you haven't got sshd set up correctly.  You can get it to log 
you in soley based on keys, and whether or not you give a password is then 
dependent soley on whether your private key has a pass phrase or not and then 
whether or not you are using some ssh-agent to remember them for you.

I have it setup so that access to ssh controlled accounts is soley via key.

Private keys remaining on fixed computers at home have no passphrase, my 
laptop has a private key with a passphrase which I enter once on login.

I have several accounts around the place with my public keys enumerated in 
their .ssh/authorized_keys file, so I have been able to contact git 
repositories with urls like

git@www.chandlerfamily.org.uk
www-data@www.chandlerfamily.org.uk
 and for my own account
just www.chandlerfamily.org.uk

all without entering a password.

But following the discussion thread Junio pointed to I have converted 
everything to shared repositories and I now only use my own account to log 
in.

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
