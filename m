From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: push problem for new repo on repo.or.cz
Date: Mon, 09 Mar 2009 17:46:55 +0100
Message-ID: <49B547FF.3020807@drmicha.warpmail.net>
References: <49B53DAF.9080004@drmicha.warpmail.net> <alpine.DEB.1.00.0903091713010.6358@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 09 17:49:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgiez-0004xV-CD
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 17:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908AbZCIQrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 12:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752988AbZCIQrM
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 12:47:12 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:41988 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751910AbZCIQrK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2009 12:47:10 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 175872EBE9D;
	Mon,  9 Mar 2009 12:47:09 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 09 Mar 2009 12:47:09 -0400
X-Sasl-enc: FVN8NZFvDzGea572CTPzaNPFI2k26CiOylJLhWc9qK0a 1236617228
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 52F1930CBF;
	Mon,  9 Mar 2009 12:47:08 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090305 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <alpine.DEB.1.00.0903091713010.6358@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112716>

Johannes Schindelin venit, vidit, dixit 09.03.2009 17:14:
> Hi,
> 
> On Mon, 9 Mar 2009, Michael J Gruber wrote:
> 
>> I have problems pushing into a new project on repo.or.cz. My user (mjg)
>> is added in the admin interface, the key is correct because I've been
>> using it for a while already for other projects (forks though). I'm
>> using a qualified refspec. What else could be wrong on my side, assuming
>> it's not the scripts on repo.or.cz? My git is 1.6.2.
> 
> I guess it is your impatience.
> 
> Users are not really added from the web interface, that would be 
> dangerous, as the web application would need more permissions than it 
> deserves.  Therefore, the web application writes to a file which is 
> handled by a cron job with those permissions.
> 
> So, wait 10 minutes and try again; I am sure it will work then.

You mean like as in 360 seconds? I can't wait!!!

Well, actually, I tried several times, and it's been more like something
between half an hour and an hour now. The project's gitweb site is up,
so something has had the permissions to create something, so to say, or
else I would have suspected cronjob inflicted time quantisation or
backlog as you did. Which is why I suspected that I missed something
(such as having to set
core.allowDenialofPushToEmptyRepoWithoutExplicitForceOption to false).

OK, I'll try again tomorrow. How patient is that ;)

Michael
