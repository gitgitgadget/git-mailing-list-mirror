From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: disallowing push to currently checked-out branch
Date: Tue, 17 Feb 2009 01:41:40 +0100
Message-ID: <499A07C4.5000908@gmail.com>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi> <20090216000443.GB3503@coredump.intra.peff.net> <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm> <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm> <alpine.LNX.1.00.0902160322530.19665@iabervon.org> <7veixybw7u.fsf@gitster.siamese.dyndns.org> <loom.20090216T101457-231@post.gmane.org> <20090216135812.GA20377@coredump.intra.peff.net> <49999ED6.7010608@gmail.com> <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302> <4999BD54.8090805@gmail.com> <alpine.DEB.1.00.0902162103580.6289@intel-tinevez-2-302> <4999FFCE.3060605@gmail.com> <alpine.DEB.1.00.0902170112580.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 01:43:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZE3M-0004tP-7w
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 01:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbZBQAlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 19:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbZBQAln
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 19:41:43 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:63650 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbZBQAln (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 19:41:43 -0500
Received: by bwz5 with SMTP id 5so3540102bwz.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 16:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=219g11p2upiHnW9WJ11RXG4T28kQFFSa9AJPjXwKiwE=;
        b=hTx8n37k2APLOnuWCptc4nfMZofwaFwvU3foO1mho2POFeHqoleQSQpUIJIQiaE1BP
         yo0Kge7AXOzSYUdOdC32FdWE1MBC95WHwefoREXvx8CIZZJU3X8nncYAzaaR1veGFx+j
         /QQF7KNmFrjvAjYTx9cVbtz8V4OM4OnouXiew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=nb+lFAf+uXjVNnOyH4MC3RBCLNJ4ex9I7TDADDQxn7UgVBu/T9Ga/SQlHJrb3vBJOL
         MROi56GHdBnq6MO45DSBgrQDg42bsnZcP1h8jJUnhNwNxxBlt5ZGIh31c4zOzEhWVaAW
         3WaNf+9ZjinUyy/oHWhZE7OI7bsp40+/XbWLE=
Received: by 10.103.12.8 with SMTP id p8mr2373825mui.44.1234831301127;
        Mon, 16 Feb 2009 16:41:41 -0800 (PST)
Received: from ?192.168.1.99? (host172-56-dynamic.10-87-r.retail.telecomitalia.it [87.10.56.172])
        by mx.google.com with ESMTPS id i5sm849935mue.13.2009.02.16.16.41.40
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Feb 2009 16:41:40 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <alpine.DEB.1.00.0902170112580.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110271>

Johannes Schindelin wrote:
> Of course, you can go on and on and on with the detached HEAD ide, but so 
> far you haven't convinced me that this is a sensible thing to do.
>   
I will not... it's time to sleep where I am! And I am just a user of git 
and you are a developer, which makes me think that you might know much 
better.
But the exchange was insightful, thanks.

Rather, I'll turn again the question...

Let us assume that I am working on branch B and that my worktree is 
based on commit XYZ. Let's also assume that someone pushes behind my 
shoulders and moves the tip of B (or even deletes B alltogether) either 
in one or in multiple pushes.  Is there an easy way so that I can now 
find out at what commit (XYZ) I was before the push(es)?  That would 
already make me quite satisfied, because with this I can write wrappers 
or aliases that can check the HEAD against that commit on every 
status/commit operation and warn the user just in case.

Sergio

> Ciao,
> Dscho
>
>   
