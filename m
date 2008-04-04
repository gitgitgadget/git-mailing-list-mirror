From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: Achieving efficient storage of weirdly structured repos
Date: Fri, 4 Apr 2008 16:16:25 +0200
Message-ID: <DBD32AF9-AFF9-4DA2-9122-9997773C64ED@ai.rug.nl>
References: <7BE3E865-C30D-49B8-A1D9-898109514990@sun.com> <alpine.LFD.1.00.0804031402530.14670@woody.linux-foundation.org> <m3tziita2y.fsf@localhost.localdomain> <alpine.LFD.1.00.0804040844470.2947@xanadu.home>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Roman Shaposhnik <rvs@Sun.COM>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Apr 04 16:17:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhmjO-00051z-Qc
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 16:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208AbYDDOQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 10:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755370AbYDDOQn
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 10:16:43 -0400
Received: from smtp-1.orange.nl ([193.252.22.241]:20639 "EHLO smtp-1.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752930AbYDDOQn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 10:16:43 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6009.orange.nl (SMTP Server) with ESMTP id 536A2700009B
	for <git@vger.kernel.org>; Fri,  4 Apr 2008 16:16:41 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6009.orange.nl (SMTP Server) with ESMTP id 103277000096;
	Fri,  4 Apr 2008 16:16:40 +0200 (CEST)
X-ME-UUID: 20080404141641664.103277000096@mwinf6009.orange.nl
In-Reply-To: <alpine.LFD.1.00.0804040844470.2947@xanadu.home>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78805>


On 4 apr 2008, at 15:11, Nicolas Pitre wrote:
> I think we're simply facing the same situation as with the initial GCC
> repository which shrank from 3GB down to 300MB or so due to misfitted
> repacking parameters.

I'd say so too. I imported the first 14000 revisions of that hg  
repository and the resulting pack file was just 25 MB after repacking.

- Pieter
