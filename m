From: Kumar Gala <galak@kernel.crashing.org>
Subject: problem with plain git clone
Date: Wed, 3 May 2006 09:18:48 -0500
Message-ID: <7CAB7A96-2C63-4B05-B0C6-72FC5B74D960@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed May 03 16:19:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbIBu-0000Hz-FM
	for gcvg-git@gmane.org; Wed, 03 May 2006 16:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWECOSz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 10:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbWECOSz
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 10:18:55 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:22552 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S964887AbWECOSz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 May 2006 10:18:55 -0400
Received: from cpe-66-69-212-100.austin.res.rr.com ([66.69.212.100] helo=[192.168.1.101])
	by nommos.sslcatacombnetworking.com with esmtp (Exim 4.52)
	id 1FbIBm-0001NE-CF
	for git@vger.kernel.org; Wed, 03 May 2006 09:18:51 -0500
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.749.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19483>

Anyone see an issues like the following:

[kgala@kgala_lnx z]$ git clone git://git.kernel.org:/pub/scm/boot/u- 
boot/galak/u-boot.git
git clone git://git.kernel.org:/pub/scm/boot/u-boot/galak/u-boot.git
fatal: unable to connect a socket (Connection timed out)
fetch-pack from 'git://git.kernel.org:/pub/scm/boot/u-boot/galak/u- 
boot.git' failed.

I've clearly done something crazy, but I setup this repository today  
with a simple:

git clone -n rsync://rsync.denx.de/git/u-boot.git
mv u-boot/.git/ u-boot.git

- kumar
