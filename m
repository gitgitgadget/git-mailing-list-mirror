From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Adding push configuration to .git/config
Date: Wed, 21 Nov 2007 23:02:08 +0100
Message-ID: <90095755-2B2B-49DA-9841-7399CB53585A@zib.de>
References: <20071121105517.GA11875@denkbrett.schottelius.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
X-From: git-owner@vger.kernel.org Wed Nov 21 23:02:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuxdG-0001XQ-4h
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 23:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbXKUWBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 17:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752609AbXKUWBA
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 17:01:00 -0500
Received: from mailer.zib.de ([130.73.108.11]:48386 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752283AbXKUWA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 17:00:59 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lALM0uSJ014145;
	Wed, 21 Nov 2007 23:00:56 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1afe9.pool.einsundeins.de [77.177.175.233])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lALM0t7C004110
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 21 Nov 2007 23:00:55 +0100 (MET)
In-Reply-To: <20071121105517.GA11875@denkbrett.schottelius.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65708>


On Nov 21, 2007, at 11:55 AM, Nico -telmich- Schottelius wrote:

> Hello guys!
>
> We are working pretty much with branches here and I think it would be
> pretty cool, to make git-push recognize some configuratio in
> ~/.git/config that describes where to push what:
>
>    git-push origin master:<name of worker> is what we currenty do
>    manually
>
> Nice would be
>
> [branch "master"]
>    remote-push          = origin
>    remote-push-merge    = another_branch

This was discussed in a similar form here:

http://marc.info/?l=git&m=119384331712996&w=2
http://marc.info/?l=git&m=119400354601328&w=2

So, yes, I think it would be very useful.  I did not yet find
time to implement it.


> And thus perhaps also changing the existing specs:
>
>    remote = ... to remote-fetch = ...
>    merge = ... to remote-fetch-merge =

This is a logical consequence.  It gives more freedom to pull
from one repo and push to another one.

I'm not fully convinced, though, of the configuration names
you propose.  However, I have no better suggestion right away.


> And perhaps it would also make sense to replace "refs/heads/master"  
> with
> only "master"?

No.  We use full refnames everywhere.  I think we should stick
with them.

	Steffen
