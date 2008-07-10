From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Fix problem with authentification on http repository.
Date: Thu, 10 Jul 2008 13:30:47 +0200
Message-ID: <4875F2E7.1010209@op5.se>
References: <7v8x6pjb4c.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709300039430.28395@racer.site> <7v4phdja01.fsf@gitster.siamese.dyndns.org> <7v4p6zmx0l.fsf@gitster.siamese.dyndns.org> <20080709055150.GA28482@glandium.org> <7vlk0blgg0.fsf@gitster.siamese.dyndns.org> <20080709075345.GA22022@glandium.org> <7vhcazlbch.fsf@gitster.siamese.dyndns.org> <20080709085651.GA23453@glandium.org> <alpine.DEB.1.00.0807091341230.5277@eeepc-johanness> <20080710072420.GA5167@sigill.intra.peff.net> <alpine.DEB.1.00.0807101248360.3135@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>, jean.guyader@linkea.org,
	git@vger.kernel.org, Jean Guyader <jean.guyader@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 10 13:32:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGuO3-00013U-F6
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 13:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923AbYGJLbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 07:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753916AbYGJLbh
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 07:31:37 -0400
Received: from mail.op5.se ([193.201.96.20]:52949 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753827AbYGJLbg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 07:31:36 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 527591B80084;
	Thu, 10 Jul 2008 13:31:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TZZweZpZctww; Thu, 10 Jul 2008 13:31:06 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 64ED11B8007E;
	Thu, 10 Jul 2008 13:31:05 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <alpine.DEB.1.00.0807101248360.3135@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87969>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 10 Jul 2008, Jeff King wrote:
> 
>> On Wed, Jul 09, 2008 at 01:43:07PM +0200, Johannes Schindelin wrote:
>>
>>>> Note that http://user:pass@server/path/ /should/ work (but that 
>>>> would need validation), though not a good idea on command line.
>>> Well, now that the programs using URLs are all builtins, we can 
>>> actually do something about it.  We can edit out the "user[:pass]@" 
>>> part out of argv, which usually means that "ps" will not see it 
>>> anymore.
>> Wouldn't there still be a race condition for publicly broadcasting your 
>> password via ps?
> 
> Yes.  For a brief amount of time, but yes.
> 
> BTW I thought I remembered one program xxx'ing out the password via argv, 
> but unfortunately I do not remember which one it was.
> 

The mysql client does (or did) it, although perhaps only on systems that
support it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
