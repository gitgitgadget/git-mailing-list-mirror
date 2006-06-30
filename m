From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] consider previous pack undeltified object state only
 when reusing delta data
Date: Fri, 30 Jun 2006 14:28:06 +0200
Message-ID: <44A518D6.8040901@op5.se>
References: <20060628223744.GA24421@coredump.intra.peff.net> <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606291053280.1213@localhost.localdomain> <20060629180011.GA4392@coredump.intra.peff.net> <Pine.LNX.4.64.0606291410420.1213@localhost.localdomain> <20060629185335.GA6704@coredump.intra.peff.net> <Pine.LNX.4.64.0606291458110.1213@localhost.localdomain> <20060629195201.GA10786@coredump.intra.peff.net> <Pine.LNX.4.64.0606291616480.1213@localhost.localdomain> <Pine.LNX.4.64.0606291352110.12404@g5.osdl.org> <Pine.LNX.4.64.0606291723060.1213@localhost.localdomain> <Pine.LNX.4.64.0606291428150.12404@g5.osdl.org> <Pine.LNX.4.64.0606291743010.1213@localhost.localdomain> <7vwtazobkw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606292335190.1213@localhost.localdomain> <Pine.LNX.4.63.0606301144450.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 14:28:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwI6Y-0006ix-3p
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 14:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbWF3M2K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 08:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWF3M2J
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 08:28:09 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:7135 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S932559AbWF3M2I (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 08:28:08 -0400
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 3EBB96BCD8; Fri, 30 Jun 2006 14:28:07 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606301144450.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22983>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 29 Jun 2006, Nicolas Pitre wrote:
> 
> 
>>Without this there would never be a chance to improve packing for 
>>previously undeltified objects.
> 
> 
> Earlier this year, I was quite surprised to learn that multiple repackings 
> actually improved packing. Does that patch mean this feature is gone?
> 

The patch Linus sent removes that feature. This one re-introduces it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
