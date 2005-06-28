From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Tue, 28 Jun 2005 16:27:53 -0400
Message-ID: <62CF578B-B9DF-4DEA-8BAD-041F357771FD@mac.com>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>
	<20050624064101.GB14292@pasky.ji.cz>
	<20050624123819.GD9519@64m.dyndns.org>
	<20050628150027.GB1275@pasky.ji.cz>
	<20050628180157.GI12006@waste.org>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: mercurial@selenic.com, Petr Baudis <pasky@ucw.cz>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
X-From: mercurial-bounces@selenic.com Tue Jun 28 22:21:55 2005
Return-path: <mercurial-bounces@selenic.com>
Received: from waste.org ([216.27.176.166])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnMaF-0002EN-9Y
	for gcvmd-mercurial@gmane.org; Tue, 28 Jun 2005 22:21:27 +0200
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5SKS4sD002704;
	Tue, 28 Jun 2005 15:28:09 -0500
Received: from smtpout.mac.com (smtpout.mac.com [17.250.248.46])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5SKRxap002691
	for <mercurial@selenic.com>; Tue, 28 Jun 2005 15:27:59 -0500
Received: from mac.com (smtpin08-en2 [10.13.10.153])
	by smtpout.mac.com (Xserve/8.12.11/smtpout10/MantshX 4.0) with ESMTP id
	j5SKRwKa007738; Tue, 28 Jun 2005 13:27:58 -0700 (PDT)
Received: from [10.0.0.2] (ip70-187-212-71.dc.dc.cox.net [70.187.212.71])
	(authenticated bits=0)
	by mac.com (Xserve/smtpin08/MantshX 4.0) with ESMTP id j5SKRshG022232
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Tue, 28 Jun 2005 13:27:56 -0700 (PDT)
In-Reply-To: <20050628180157.GI12006@waste.org>
To: Matt Mackall <mpm@selenic.com>
X-Mailer: Apple Mail (2.730)
X-Virus-Scanned: by amavisd-new
X-BeenThere: mercurial@selenic.com
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: mercurial.selenic.com
List-Unsubscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=unsubscribe>
List-Archive: <http://www.selenic.com/pipermail/mercurial>
List-Post: <mailto:mercurial@selenic.com>
List-Help: <mailto:mercurial-request@selenic.com?subject=help>
List-Subscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=subscribe>
Sender: mercurial-bounces@selenic.com
Errors-To: mercurial-bounces@selenic.com

On Jun 28, 2005, at 14:01:57, Matt Mackall wrote:
> Everything in Mercurial is an append-only log. A transaction journal
> records the original length of each log so that it can be restored on
> failure.

Does this mean that (excepting the "undo" feature) one could set the
ext3 "append-only" attribute on the repository files to avoid losing
data due to user account compromise?

Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at people who weren't supposed to be in your machine room.
   -- Anthony de Boer
