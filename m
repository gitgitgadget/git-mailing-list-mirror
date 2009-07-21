From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: clone
Date: Tue, 21 Jul 2009 10:05:07 +0200
Message-ID: <4A6576B3.7000503@drmicha.warpmail.net>
References: <D229D90E-0294-475D-B7AC-6C7B23CC169A@roalddevries.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Roald de Vries <rdv@roalddevries.nl>
X-From: git-owner@vger.kernel.org Tue Jul 21 10:05:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTAMC-0006l0-DS
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 10:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbZGUIFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 04:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbZGUIFY
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 04:05:24 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55556 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752083AbZGUIFX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2009 04:05:23 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 40B443BB314;
	Tue, 21 Jul 2009 04:05:23 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 21 Jul 2009 04:05:23 -0400
X-Sasl-enc: PTFiE3KCMwnR7bmKI0LiNpMUEV9HTLMFag9CZhKmHgPT 1248163522
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 978693169B;
	Tue, 21 Jul 2009 04:05:22 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1pre) Gecko/20090718 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <D229D90E-0294-475D-B7AC-6C7B23CC169A@roalddevries.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123649>

Roald de Vries venit, vidit, dixit 20.07.2009 16:33:
> Dear all,
> 
> If I clone a repository with multiple branches to 'newdir', and then  
> type 'git branch' in 'newdir', I see only 1 branch. 'git branch -r'  
> gives me all branches. Is that correct behaviour? If so, why? And  
> mainly: can I configure git to clone all original branches to non- 
> remote branches?
> 
> Kind regards, Roald

A for the 2nd part (1st one answered by Jeff), you can "git clone --mirror".

But me suspects that you actually want (s)cp -rp, do you?

Michael
