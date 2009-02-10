From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: RFH: spawning pager takes long time when when unconnected from
 network
Date: Tue, 10 Feb 2009 08:57:47 +0100
Message-ID: <4991337B.2010102@viscovery.net>
References: <loom.20090210T015515-886@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Raible <raible+git@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 08:59:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWnWa-0006BB-Et
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 08:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbZBJH5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 02:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbZBJH5w
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 02:57:52 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:52975 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbZBJH5w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 02:57:52 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LWnV6-0007r4-E1; Tue, 10 Feb 2009 08:57:48 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1BD2F6D9; Tue, 10 Feb 2009 08:57:48 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <loom.20090210T015515-886@post.gmane.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109185>

Eric Raible schrieb:
> I've got a weird one which I haven't been able to figure out.
> The problem is that git sometimes takes a long time (~5-10 seconds)
> before producing output when it needs to internally spawn a pager.
> 
> This only occurs when I'm not plugged in to a network.
> When I'm plugged in everything operates at the normal speed.
> 
> This would be slow: git diff some-branch
> This would be fast: git diff some-branch | less
> 
> Unsetting core.pager (IOW setting core.pager="") is also fast.

Do you have a directory in your PATH that points to a disconnected network
drive? Do you use the default pager settings, or did you customize the pager?

-- Hannes
