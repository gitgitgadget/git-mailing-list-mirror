From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] git-unbundle - unbundle objects and references for
 disconnected transfer.
Date: Wed, 14 Feb 2007 17:43:13 -0500
Message-ID: <45D39081.2010709@verizon.net>
References: <11714622292110-git-send-email-mdl123@verizon.net>
 <11714622292295-git-send-email-mdl123@verizon.net>
 <11714622293142-git-send-email-mdl123@verizon.net>
 <20070214194537.GD28290@spearce.org> <45D377A8.1080404@verizon.net>
 <20070214210300.GF28290@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 23:43:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHSqQ-0000Rb-5f
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 23:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbXBNWnT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 17:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbXBNWnT
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 17:43:19 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:30727 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbXBNWnS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 17:43:18 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDH00KQS5S0I3K1@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 14 Feb 2007 16:43:14 -0600 (CST)
In-reply-to: <20070214210300.GF28290@spearce.org>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39770>

Shawn O. Pearce wrote:
> I don't really have an opinion here, as I'm fortunate enough that
> I can use an SSH or an anonymous git connection between all of my
> repositories, and thus don't really have a need for bundle/unbundle.
>
> Its just one of those operations which I thought would not happen
> often, and when it did, probably would be big.  In which case keeping
> the packfile would make the unbundle run faster, as you don't need
> to create a huge mess of loose objects.
Fair enough - I've made that change, also your other suggestion about 
piping refs directly to pack-objects. Thanks for both.

Mark
