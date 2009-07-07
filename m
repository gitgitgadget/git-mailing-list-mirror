From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Checking for fast-forward
Date: Tue, 07 Jul 2009 13:01:30 +0200
Message-ID: <4A532B0A.5090405@drmicha.warpmail.net>
References: <ca4f67be0907060936v7bf7c44y4395717fff854fd4@mail.gmail.com>	<20090706232614.32602ccc@schatten>	<4A530594.20100@drmicha.warpmail.net> <20090707124657.1b0fe4df@schatten>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Lee Griffiths <poddster@gmail.com>, git@vger.kernel.org
To: Florian Mickler <florian@mickler.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 13:02:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MO8R6-0004FJ-Ax
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 13:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754663AbZGGLBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 07:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754641AbZGGLBq
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 07:01:46 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:56183 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754352AbZGGLBq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jul 2009 07:01:46 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 7AD9E3AEAA7;
	Tue,  7 Jul 2009 07:01:49 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 07 Jul 2009 07:01:49 -0400
X-Sasl-enc: mDM9AbvNkWHR59stD05WRhGxagt98+D++rwaMNEGcOBL 1246964509
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 91728EB89;
	Tue,  7 Jul 2009 07:01:48 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.1pre) Gecko/20090707 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090707124657.1b0fe4df@schatten>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122835>

Florian Mickler venit, vidit, dixit 07.07.2009 12:46:
> On Tue, 07 Jul 2009 10:21:40 +0200
> Michael J Gruber <git@drmicha.warpmail.net> wrote:
> 
>> If $(git rev-list bar..remotes/origin/foo) is empty then the branch
>> foo in the remote repo can be fast-forwarded to bar.
>>
>> Chhers,
>> Michael
> 
> in that case you could also do 
> 'git cherry bar origin/foo'
> 
> that shows you all commits that are in origin/foo but not in bar. 

Well, that goes through all commits "bar..remotes/origin/foo" and
computes patch-ids. It is porcelain. Don't use it for scripting.

Michael
