From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Wed, 11 May 2005 22:05:41 +0000
Organization: linutronix
Message-ID: <1115849141.22180.123.camel@tglx>
References: <1115847510.22180.108.camel@tglx>
	 <2780.10.10.10.24.1115848852.squirrel@linux1>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 23:58:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVzCn-0004Xf-LQ
	for gcvg-git@gmane.org; Wed, 11 May 2005 23:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVEKWE5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 18:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVEKWE5
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 18:04:57 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:44674
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261275AbVEKWEz
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 18:04:55 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id A879E65C003;
	Thu, 12 May 2005 00:04:48 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 3FEB928284;
	Thu, 12 May 2005 00:04:50 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <2780.10.10.10.24.1115848852.squirrel@linux1>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-05-11 at 18:00 -0400, Sean wrote:
> To make this useful you're also going to have to change the parent entries
> to something like:
> 
> parent SHA1 REPOID
> 
> At least when the referenced commit has a repoid that doesn't match the
> repository from which you obtained the object, ie. fast forward heads. 
> This implies that you know the repoid of the repository you pulled the
> object from!
> 
> Otherwise, you still haven't solved the problem of identifying fast
> forward heads as you traverse the history.

Err, 
each parent is a commit, which is identified by its repoid. Why do you
want to add redundant information ?

tglx


