From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 0/2] Documentation: kicking the "reset --hard" habit
Date: Fri, 29 Oct 2010 03:35:16 -0500
Message-ID: <20101029083516.GA26290@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bebarino@gmail.com, srabbelier@gmail.com,
	Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 29 10:35:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBkQu-0007M6-OY
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 10:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760665Ab0J2If3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 04:35:29 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48067 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897Ab0J2If1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 04:35:27 -0400
Received: by gyg4 with SMTP id 4so1791317gyg.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 01:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=0R3siAmyhsXWefSK9jqb3r5AteI3cSGgbo4t3m+WHqc=;
        b=oXljgdoa6IF4+i27I+Y/8/Ndume+TcmP8nYPLwwYLhs+egPY0XmvastxPiJnbtK3Pi
         phkGMqXjNmT4OU57PnzCCwSZlMOyS1JWXkXgBtrAFBaTbQ9pC2xgdr2eFuLENEjvIg2K
         ervCAluyswtvDLKIsjSCuagGjY//urOcbTyJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=SzbqSxhDKBStTMPXlAgvoJ2LvF6poQUISjmf4TvgGjcOmXfuBeMWQ33pRtD3edV6+n
         aqHeLhM5KNERkDeao6loQpvcPkx4+KN5XON1EJaB/ZFgaV7II/CB4ii/jpLM3IZ/hNLx
         lqcAw0RL+CBK00CujTVBx5xYrRezmTVpbh5CI=
Received: by 10.150.197.6 with SMTP id u6mr2809915ybf.184.1288341326589;
        Fri, 29 Oct 2010 01:35:26 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id m4sm1531110yha.26.2010.10.29.01.35.24
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 29 Oct 2010 01:35:25 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160319>

Hi,

Kira on IRC reminded me that our introductory documentation does
not explain how to use the new reset --keep and --merge primitives.

Sadly, at least the user manual change suggested below is probably
not suitable, since reset --keep and --merge have not been around
since git 1.5.3 days.  Ideas for working around that and other
comments would be welcome.

Jonathan Nieder (2):
  Documentation: suggest "reset --merge" more often
  Documentation: suggest "reset --keep" more often

 Documentation/git-bisect-lk2009.txt               |    2 +-
 Documentation/git-bisect.txt                      |    2 +-
 Documentation/git-checkout.txt                    |    2 +-
 Documentation/git-merge.txt                       |    2 +-
 Documentation/git-rerere.txt                      |    2 +-
 Documentation/git-reset.txt                       |   13 ++++++-----
 Documentation/gitcore-tutorial.txt                |    6 ++--
 Documentation/gitworkflows.txt                    |    2 +-
 Documentation/howto/maintain-git.txt              |    4 +-
 Documentation/howto/separating-topic-branches.txt |    2 +-
 Documentation/user-manual.txt                     |   22 ++++++++++++++------
 11 files changed, 34 insertions(+), 25 deletions(-)
