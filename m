From: Bill Purcell <flyeng4@gmail.com>
Subject: git-daemon not responding
Date: Thu, 2 Jul 2009 09:29:43 -0500
Message-ID: <20090702142942.GA6694@william-laptop>
References: <20090702133417.GD7158@william-laptop> <20090702135542.GE7158@william-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 16:35:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMNNo-0008BI-JR
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 16:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbZGBOfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 10:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753217AbZGBOfS
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 10:35:18 -0400
Received: from mail-ew0-f215.google.com ([209.85.219.215]:52037 "EHLO
	mail-ew0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbZGBOfG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 10:35:06 -0400
X-Greylist: delayed 312 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Jul 2009 10:35:05 EDT
Received: by ewy11 with SMTP id 11so194077ewy.37
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 07:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=RCqrLH2GRwQuinULuEeRIujQoTe4x+hX9ftdkKb2T94=;
        b=orp4wYJVPkEndjFOymFDqkTOfv1A9NhYM82ZrkVB3KG3p3BZK3pb3tfOT8q4+UtZvg
         qu6M86D+ij5xPgj3uownBikkTQzB+D4/miVDeyMjaNz/qKVs+lyMGV4QyNN1Gt1ejen6
         57r6sY+On84eoVy1tFCXmdj1ScZP1lPvwHqKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nr6lC7S7lau2h7bloc96cL9SjVE98OjL2RT0zPvEDl0RUiG/VbvTR8INZLf3+azT2g
         ZZQtdrLPDAU/1MYupuu4Idq3nJOlHGmtdqCzr1gBlrCd9QT41PAmBjAaFx1CWuDR+/p4
         WUPlcTeYmrqVUqiDJhOqpdnwp7UWtZldUp1lM=
Received: by 10.216.52.76 with SMTP id d54mr31496wec.119.1246544995661;
        Thu, 02 Jul 2009 07:29:55 -0700 (PDT)
Received: from localhost (static-209-107-234-220.consolidated.net [209.107.234.220])
        by mx.google.com with ESMTPS id i34sm5850714gve.13.2009.07.02.07.29.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Jul 2009 07:29:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090702135542.GE7158@william-laptop>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122650>

On Thu, Jul 02, 2009 at 08:55:42AM -0500, Bill Purcell wrote:
I started git-daemon with
 
sudo -u git git-daemon --reuseaddr --verbose --base-path=/home/git/repositories/ --detach

[08:26:38]william ~$ grep 9418 /etc/services 
git             9418/tcp                        # Git Version Control System
 
[08:30:38]william /home/git$ ls
total 8.0K
drwxrwxrwx 2 git git 4.0K 2009-07-01 01:05 gitosis
drwxrwxrwx 5 git git 4.0K 2009-07-01 22:00 repositories
 
[08:30:39]william /home/git$ ls repositories/
total 12K
drwxr-xr-x 8 git git 4.0K 2009-07-01 21:57 fedha.git
drwxrwxrwx 8 git git 4.0K 2009-07-01 01:05 gitosis-admin.git
drwxr-xr-x 8 git git 4.0K 2009-07-01 22:00 montco.git

When I go to my local machine and try to clone I get this result ...

[08:31:16]william /tmp$ git clone git://whpiv.net/montco.git
Initialized empty Git repository in /tmp/montco/.git/

With no response.  I have waited about five minutes and gave up.  Any
recommendations on how to approach this.  How do I tell if git-daemon
is working correctly? 

I have opened port 9418 on my router and firewall.  So think I am reaching
my server, I just don't know how to tell what git-daemon is telling
git-clone or if they are even communicating at all.

-- 
whp
