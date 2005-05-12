From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 07:57:17 +0000
Organization: linutronix
Message-ID: <1115884637.22180.277.camel@tglx>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com>
	 <1115854733.22180.202.camel@tglx> <428297DB.8030905@zytor.com>
	 <1115858022.22180.256.camel@tglx> <7vekcdmd16.fsf@assigned-by-dhcp.cox.net>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 09:49:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW8RJ-0003X5-8a
	for gcvg-git@gmane.org; Thu, 12 May 2005 09:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVELH4g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 03:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVELH4g
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 03:56:36 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:34438
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261267AbVELH4Z
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 03:56:25 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 7CDA565C003;
	Thu, 12 May 2005 09:56:22 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 3AF0B28284;
	Thu, 12 May 2005 09:56:25 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vekcdmd16.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-05-11 at 18:46 -0700, Junio C Hamano wrote:
> >>>>> "TG" == Thomas Gleixner <tglx@linutronix.de> writes:
> So I am having a hard time understanding what problem repo-id
> solves.

Rn   o
     | \
Rn-1 o  |
     |  o Mn
     |  o Mn-1
Rn-2 o /
Rn-3 o

rev-tree shows you 

Rn
Rn-1
Mn
Mn-1
Rn-2
Rn-3

Which is wrong. 

After syncing M to Rn you see the same thing in M

Rn
Rn-1
Mn
Mn-1
Rn-2
Rn-3

which is also wrong. 

The correct display looking at R is

Rn
 Mn
 Mn-1
Rn-1
Rn-2
Rn-3

Looking from M it is

Rn
 Rn-1
 Rn-2
Mn
Mn-2
Rn-3

tglx







