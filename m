From: Andreas Ericsson <ae@op5.se>
Subject: Re: Adding push configuration to .git/config
Date: Thu, 22 Nov 2007 12:59:04 +0100
Message-ID: <47456F08.5020606@op5.se>
References: <20071121105517.GA11875@denkbrett.schottelius.org>	<7vabp79hjt.fsf@gitster.siamese.dyndns.org>	<C297CFC3-8DD0-4EEE-8FD3-BF997F6E269A@zib.de>	<7vd4u28z90.fsf@gitster.siamese.dyndns.org>	<7E8CB606-6CBD-4736-A2CB-0A1E1BD219D3@zib.de>	<Pine.LNX.4.64.0711221120300.27959@racer.site> <7v7ika5wld.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>,
	Nico -telmich- Schottelius <nico-linux-git@schottelius.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 12:59:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvAiT-0002sz-Eh
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:59:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454AbXKVL7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 06:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752449AbXKVL7N
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:59:13 -0500
Received: from mail.op5.se ([193.201.96.20]:54317 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752295AbXKVL7K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 06:59:10 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id AC9071F08069;
	Thu, 22 Nov 2007 12:59:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fu+HfvK8SSfr; Thu, 22 Nov 2007 12:59:07 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id CB6661F08067;
	Thu, 22 Nov 2007 12:59:06 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <7v7ika5wld.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65811>

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> I have to say that I slowly grow an antipathy for "git push" without 
>> parameters.  _All_ of the confusions with push that I saw stem from being 
>> too lazy to say where and what you want to push.
> 
> The same thing can be said for "fetch" by the way.

I disagree, since "fetch" at worst will auto-update the remote-tracking
branches only, while "push" may publish changes that are downright
wrong and never meant for publishing. What's worse is that fixing up
published history is a whole lot messier than it is to fix ones own
remote-tracking branches.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
