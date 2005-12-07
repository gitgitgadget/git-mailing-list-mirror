From: Andreas Ericsson <ae@op5.se>
Subject: Re: dotfile support
Date: Wed, 07 Dec 2005 16:28:48 +0100
Message-ID: <4396FFB0.4040203@op5.se>
References: <20050416230058.GA10983@ucw.cz> <118833cc05041618017fb32a2@mail.gmail.com> <20050416183023.0b27b3a4.pj@sgi.com> <Pine.LNX.4.58.0504162138020.7211@ppc970.osdl.org> <42620092.9040402@dwheeler.com> <Pine.LNX.4.58.0504170857580.7211@ppc970.osdl.org> <42628D1B.3000207@dwheeler.com> <20051207145646.GA9207@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Dec 07 16:31:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek1Dx-00043F-IT
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 16:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVLGP2u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 10:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVLGP2u
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 10:28:50 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:29669 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751124AbVLGP2u
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 7 Dec 2005 10:28:50 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 251376BCBE
	for <git@vger.kernel.org>; Wed,  7 Dec 2005 16:28:49 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20051207145646.GA9207@tumblerings.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13327>

Zack Brown wrote:
> Hi,
> 
> What's the status of dotfile support? I can only find one thread that really
> discusses the issue:
> 

What sort of "dotfile support" are you hinting at? git being able to 
handle them, or git being able to ignore them? Both are implemented. The 
former by default and the latter through .gitignore.

Files you want to version-control ofcourse has to be added with "git 
add", but that's not just dotfiles and it's really the only sane behaviour.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
