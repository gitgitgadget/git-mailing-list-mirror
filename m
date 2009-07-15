From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git/Terminal issue
Date: Wed, 15 Jul 2009 13:51:01 +0200
Message-ID: <4A5DC2A5.2010504@drmicha.warpmail.net>
References: <24495974.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: GleMarS <glen@erskinedesign.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 13:51:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR31D-0005jk-9M
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 13:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369AbZGOLvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 07:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754362AbZGOLvT
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 07:51:19 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41987 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754354AbZGOLvS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jul 2009 07:51:18 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 0A8563B1C5D;
	Wed, 15 Jul 2009 07:51:18 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 15 Jul 2009 07:51:18 -0400
X-Sasl-enc: QIxYsxeoAQOY/8caq9zbx56qJd9xxW47+5qTk9+59Zq7 1247658677
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8288376B6;
	Wed, 15 Jul 2009 07:51:17 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1pre) Gecko/20090712 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <24495974.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123300>

GleMarS venit, vidit, dixit 15.07.2009 13:27:
> 
> Hi,
> 
> I'm getting rage. Basically whenever I navigate to a folder that contains a
> .git folder in Terminal (os x leopard), it prints a load of usage text. it's
> driving me mad, I've uninstalled - re-installed etc etc and no joy.
> 
> I have set up git on other machines without any issue so I'm baffled. Output
> image attached.
> 
> Help appreciated.
> 
> http://www.nabble.com/file/p24495974/terminal_low.jpg 
> 
> 
> Cheers.

Are you using bash completion for git by any chance? Something calls
"git branch" with incorrect parameters, and it may be the call which
recalculates the bits for PS1.

Michael
