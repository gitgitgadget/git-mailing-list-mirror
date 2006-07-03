From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] consider previous pack undeltified object state only
 when reusing delta data
Date: Mon, 03 Jul 2006 10:11:02 +0200
Message-ID: <44A8D116.5070709@op5.se>
References: <20060628223744.GA24421@coredump.intra.peff.net> <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606291053280.1213@localhost.localdomain> <20060629180011.GA4392@coredump.intra.peff.net> <Pine.LNX.4.64.0606291410420.1213@localhost.localdomain> <20060629185335.GA6704@coredump.intra.peff.net> <Pine.LNX.4.64.0606291458110.1213@localhost.localdomain> <20060629195201.GA10786@coredump.intra.peff.net> <Pine.LNX.4.64.0606291616480.1213@localhost.localdomain> <Pine.LNX.4.64.0606291352110.12404@g5.osdl.org> <Pine.LNX.4.64.0606291723060.1213@localhost.localdomain> <Pine.LNX.4.64.0606291428150.12404@g5.osdl.org> <Pine.LNX.4.64.0606291743010.1213@localhost.localdomain> <7vwtazobkw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606292335190.1213@localhost.localdomain> <Pine.LNX.4.63.0606301144450.29667@wbgn013.biozentrum.uni-wuerzburg.de> <44A518D6.8040901@op5.se> <Pine.LNX.4.64.06
 06301132510.1213@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 10:11:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxJWO-0005gZ-UY
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 10:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWGCILF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 04:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWGCILF
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 04:11:05 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:42127 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750803AbWGCILE
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 04:11:04 -0400
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 395276BCD4; Mon,  3 Jul 2006 10:11:03 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0606301132510.1213@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23163>

Nicolas Pitre wrote:
> On Fri, 30 Jun 2006, Andreas Ericsson wrote:
> 
>>Johannes Schindelin wrote:
>>>
>>>>Without this there would never be a chance to improve packing for
>>>>previously undeltified objects.
>>>
>>>
>>>Earlier this year, I was quite surprised to learn that multiple repackings
>>>actually improved packing. Does that patch mean this feature is gone?
>>>
>>
>>The patch Linus sent removes that feature. This one re-introduces it.
> 
> 
> Not really.
> 
> Actually that multiple repacking "feature" was rather an artifact of the 
> delta data reuse code and not really by design.  Here's what happened 
> before:
> 

Thanks for the extensive and very clear info. Lovely to see a competent 
programmer who can also explain how things work. :)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
