From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: pre-commit hook
Date: Sat, 21 Feb 2009 12:28:57 +0100
Message-ID: <499FE579.1050700@drmicha.warpmail.net>
References: <20090220091127.GA7415@b2j> <7v63j5t6r3.fsf@gitster.siamese.dyndns.org> <20090221035748.GC7409@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 12:30:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Laq4C-0005T2-Iy
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 12:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbZBUL3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 06:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbZBUL3Q
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 06:29:16 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54152 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751632AbZBUL3P (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Feb 2009 06:29:15 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 3C2492A2110;
	Sat, 21 Feb 2009 06:29:12 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Sat, 21 Feb 2009 06:29:13 -0500
X-Sasl-enc: V27bwRWAwM9wsjnwztmGv7HxSPH9T2R3yXmEsSQeOj9Y 1235215746
Received: from localhost.localdomain (p4FC60312.dip0.t-ipconnect.de [79.198.3.18])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 481D01C933;
	Sat, 21 Feb 2009 06:29:06 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090219 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090221035748.GC7409@b2j>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110942>

bill lam venit, vidit, dixit 21.02.2009 04:57:
> On Fri, 20 Feb 2009, Junio C Hamano wrote:
>>     if git-rev-parse --verify HEAD 2>/dev/null
> 
> Isn't git-rev-parse (and all git-??? ) was deprecated in 1.6.2 ?
> 

It's OK in hooks because the path is set appropriately there.

Michael
