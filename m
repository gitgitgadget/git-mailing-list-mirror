From: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] gitweb: escape searchtext and parameters for replay
Date: Wed, 29 Apr 2009 14:52:27 +0200
Message-ID: <0626233F-50D5-4F7E-9009-506FEA77571D@aepfle.de>
References: <337ECD47-D343-40F2-9E41-9E7D8531C5DF@aepfle.de> <1241005459-17311-1-git-send-email-git@drmicha.warpmail.net> <200904291428.46244.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 14:53:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz9HH-0007mE-1H
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 14:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448AbZD2Mwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 08:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbZD2Mwe
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 08:52:34 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:36175 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbZD2Mwd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 08:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1241009552; l=404;
	s=domk; d=aepfle.de;
	h=References:Date:Subject:Mime-Version:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:To:From:Cc:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=Qlzw7ZgMPnIcfGG4bDcKpBDg4gk=;
	b=b5fgQwowK5byoHSZxYxfs9tCnfpUe9qkZ1Gcx//ubruLtZ1yB/fgizIu7/QPz+j0/vB
	WEeSEE9pwjwiFoIqTDNCpCJdTl06EGq0z4mG7Yhi8hu0kbyfVMMzGDw2ime35x8hM3vKs
	eNLXwHkogoR/b7D4kwY+FvQyD6nrPfVfhww=
X-RZG-AUTH: :P2EQZQWpfu9jTztxfPzuU9A5K3T2AgG4vCx9L62AnOp4JNgVHIVt
X-RZG-CLASS-ID: mo05
Received: from [192.168.2.100]
	(dslb-084-057-095-146.pools.arcor-ip.net [84.57.95.146])
	by post.strato.de (fruni mo35) (RZmta 18.31)
	with AES128-SHA encrypted ESMTP id a01d03l3TCinfG ;
	Wed, 29 Apr 2009 14:52:30 +0200 (MEST)
In-Reply-To: <200904291428.46244.jnareb@gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117880>

Am 29.04.2009 um 14:28 schrieb Jakub Narebski:

> On Wed, 29 April 2009, Michael J Gruber wrote:

>>> It should be s=torvalds%40linux instead of s=torvalds\@linux
>
> If you by hand edit URL changing '\@' to simply '@', does changed
> gitweb URL works correctly?

I tried akpm@osdl.org, and @ and . was escaped with a backslash.
Removing both, and using the plain mail address worked.

Olaf
