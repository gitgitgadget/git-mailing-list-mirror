From: Jakub Narebski <jnareb@gmail.com>
Subject: Help! My ISP blocks repo.or.cz. How to push changes?
Date: Mon, 12 Jan 2009 02:46:28 +0100
Message-ID: <200901120246.28364.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 12 02:47:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMBuE-0001Do-Bm
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 02:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbZALBqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 20:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbZALBqa
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 20:46:30 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:17926 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbZALBq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 20:46:29 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1308286nfc.21
        for <git@vger.kernel.org>; Sun, 11 Jan 2009 17:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=dy8HknblhVvqI0e5P2wFdvIKLD/7Ofly+sepA9i8jVs=;
        b=t5UXsbxPEV9yvX0aT5KdCYIzGIoLoDXtgzvnuEZeen15QWruTLZzsgIJ+MKwF3vN+S
         kb9zX7H5w2G/SAxthjRL2irI6Ko4mblQEwmB8lG64WjoBJQoCm9iGLtViIA5hAss6bOD
         gvRfGPaj1mw8PMEq29l1qdSQCxSqRU2Z9SiA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=NwltIWmkpE94vtU6MTfstz/qxpk4Yv39lXLvtCpSggwxj2QOO4QgPkNNl6RGNZc6bB
         3HJvLNvnia9TJMfaiLASzUntuPGYm/xpsgHeqZ6vhu8euXyLhcRqm4x+0wunNdhFNh/e
         f8KZf+977PJjv9aFHnBcmSJXeCb+JZKefT74s=
Received: by 10.210.21.6 with SMTP id 6mr33414855ebu.192.1231724787185;
        Sun, 11 Jan 2009 17:46:27 -0800 (PST)
Received: from ?192.168.1.11? (abwj90.neoplus.adsl.tpnet.pl [83.8.233.90])
        by mx.google.com with ESMTPS id 7sm3748712eyg.52.2009.01.11.17.46.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Jan 2009 17:46:26 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105273>

The ISP I use (Telekomunikacja Polska S.A., aka TP) made some 
unannounced changes for ADSL service (Neostrada) which made it block 
repo.or.cz (and of course its aliases, including git.or.cz where git 
wiki resides). It blocks also gimp.org and some Polish IRC servers 
(irc.freenode.org on which #git resides works O.K.). People speculate 
that this blocking was based on MAPS (Mail Abuse Prevention System, 
which is SPAM backwards) lists to fight SPAM and/or to block botnets,
and uses null routing (IP based) blocking. I have no idea why repo.or.cz 
is blocked: gimp.org is supposedly blocked because it hosts 
irc.gimp.org on the same IP. By block I mean that even ping doesn't 
work (no reply at all).

I can access git wiki via one of many free HTTP proxies; currently I use 
http://www.4proxy.de so there are only slight problems there.  


The problems is with fetching (via git:// protocol) of forks of git 
repository on repo.or.cz, and pushing (via SSH) to a few of my git 
repositories hosted on repo.or.cz.

Do you have any suggestions to bypass this block for git? I have access 
to Linux shell account (no root access, though) which doesn't have 
problems with repo.or.cz, so I think I could set up SSH tunnel: but 
how? And what to do with access via git:// - move to SSH too?

Thanks in advance
-- 
Jakub Narebski
Poland

http://forums.thedailywtf.com/forums/t/10789.aspx
