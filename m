From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 00:30:38 +0000
Organization: linutronix
Message-ID: <1115857838.22180.250.camel@tglx>
References: <1115847510.22180.108.camel@tglx>
	 <2780.10.10.10.24.1115848852.squirrel@linux1>
	 <1115849141.22180.123.camel@tglx>
	 <2807.10.10.10.24.1115850254.squirrel@linux1>
	 <1115850619.22180.133.camel@tglx>
	 <2853.10.10.10.24.1115850996.squirrel@linux1>
	 <1115851718.22180.153.camel@tglx>
	 <2883.10.10.10.24.1115852463.squirrel@linux1>
	 <1115854419.22180.196.camel@tglx>
	 <2997.10.10.10.24.1115855049.squirrel@linux1>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 02:22:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW1Sy-0006oO-Jn
	for gcvg-git@gmane.org; Thu, 12 May 2005 02:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVELA3t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 20:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVELA3t
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 20:29:49 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:50563
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261249AbVELA3q
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 20:29:46 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 0AA5065C003;
	Thu, 12 May 2005 02:29:45 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id E69F22807D;
	Thu, 12 May 2005 02:29:46 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <2997.10.10.10.24.1115855049.squirrel@linux1>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-05-11 at 19:44 -0400, Sean wrote:
> What problem are you trying to solve?  

The problem to explain the obvious facts to an agnostic

> Has dave or russell or anybody with
> multiple repositories given you reason to think they have a problem
> tracking their personal repositories?   I doubt it very much.

Aarg. Did you ever get in contact with QA departements ?

Assume you have:  bugfix - stable - devel repositories.

You have to track down a problem in bugfix and the source of it.
It does not matter whether the maintainer of "bugfix" pulled it from
devel or from stable. It's his fault anyway. 

But we are not talking about faults and guiltiness. We want to identify
the location and the context _where_ and _why_ this change was created.

The current solution of git makes it impossible to retrieve this
information in a consistent way. 

So you have no quick solution to figure out what happened. Quite
contrary, you have to dissect inconsistent information.

See also the thread about "Stop git-rev-list at sha1 match".

> The chain of command might be good to know in the same way that an
> accurate signed-off-by chain is good to know.

This sentence makes me guess, that you actually are working in a QA
departement and therefor trying to maximize the amount of irrelevant
information.

tglx


