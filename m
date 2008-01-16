From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 17:05:57 +0200
Message-ID: <478E1D55.3050108@dawes.za.net>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com> <alpine.LSU.1.00.0801161113170.17650@racer.site> <alpine.DEB.1.00.0801161521500.5260@bender.nucleusys.com> <20080116135420.GA21588@coredump.intra.peff.net> <alpine.DEB.1.00.0801161606160.5260@bender.nucleusys.com> <20080116141836.GA22639@coredump.intra.peff.net> <alpine.DEB.1.00.0801161622030.5260@bender.nucleusys.com> <20080116143219.GA22744@coredump.intra.peff.net> <alpine.DEB.1.00.0801161634080.5260@bender.nucleusys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Petko Manolov <petkan@nucleusys.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 16:09:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF9tb-00069M-NC
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 16:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420AbYAPPJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 10:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753334AbYAPPJK
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 10:09:10 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:54908 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157AbYAPPJI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 10:09:08 -0500
Received: from spunkymail-a4.g.dreamhost.com (mailbigip.dreamhost.com [208.97.132.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id E423F17A8BA
	for <git@vger.kernel.org>; Wed, 16 Jan 2008 07:09:07 -0800 (PST)
Received: from [192.168.201.100] (dsl-243-111-82.telkomadsl.co.za [41.243.111.82])
	by spunkymail-a4.g.dreamhost.com (Postfix) with ESMTP id 8470D3B9EF;
	Wed, 16 Jan 2008 07:07:02 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <alpine.DEB.1.00.0801161634080.5260@bender.nucleusys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70687>

Petko Manolov wrote:
> On Wed, 16 Jan 2008, Jeff King wrote:
> 
>> OK, that was the answer I was looking for; it looks like you are out
>> of luck.
> 
> Story of my life. :-)
> 
>> As an experiment, it might be worth trying to store the uncompressed
>> versions instead (git will delta _and_ compress them for you).
> 
> I don't have them uncompressed.
> 
> I can try to convert those files into ascii format and then save them in 
> the repository.  Since most changes are incremental git should be able 
> to generate relatively small delta, which should compress well enough.
> 
> Thanks for the hint.
> 
> 
>         Petko

That is unlikely to help, since git can find deltas in binary files just 
as easily as in text files. All you are doing is changing the encoding.

Rogan
