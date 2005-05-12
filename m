From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 13:43:50 +0200
Organization: linutronix
Message-ID: <1115898230.11872.8.camel@tglx>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com>
	 <1115854733.22180.202.camel@tglx> <428297DB.8030905@zytor.com>
	 <1115858022.22180.256.camel@tglx> <7vekcdmd16.fsf@assigned-by-dhcp.cox.net>
	 <1115884637.22180.277.camel@tglx>
	 <1895.10.10.10.24.1115890333.squirrel@linux1>
	 <1115890792.22180.306.camel@tglx>
	 <3656.10.10.10.24.1115891188.squirrel@linux1>
	 <1115896713.22180.314.camel@tglx>
	 <3745.10.10.10.24.1115897090.squirrel@linux1>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, "H. Peter Anvin" <hpa@zytor.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 13:35:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWByN-0005RQ-39
	for gcvg-git@gmane.org; Thu, 12 May 2005 13:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVELLm7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 07:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVELLm6
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 07:42:58 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:34184
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261467AbVELLm5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 07:42:57 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id AF65965C003;
	Thu, 12 May 2005 13:42:53 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 02F1228284;
	Thu, 12 May 2005 13:42:56 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <3745.10.10.10.24.1115897090.squirrel@linux1>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-05-12 at 07:24 -0400, Sean wrote:
> Right, that's what a fast forward head is.  It replaces a sync / merge and
> the  trees become exactly syncronized via a shared head.   I have mixed
> feelings about fast forward heads, but they don't hide _too_ much
> information.  

The question is how hard it is to do a reconstruction. In the current
state automatic reconstruction is simply not possible. 

> Is there any _useful_ question you can ask where the answer
> is lost for all time because of this.

I want to see the history of _any_ repository in the order of  changes
in the specific repository. The fast forward heads without additional
information simply do not allow this. 

I want to see the history of a file in the correct order. The current
solution ends up with useless file version diffs or annotates where
changes are shown in random order and therefor worthless.

tglx


