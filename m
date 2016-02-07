From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git show doesn't work on file names with square brackets
Date: Sun, 7 Feb 2016 18:10:55 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602071809440.2964@virtualbox>
References: <6A7D4447-AC25-4591-9DA7-CD153198EC64@jetbrains.com> <alpine.DEB.2.20.1602061518220.2964@virtualbox> <25D155FA-6F05-425C-AB2D-7F0B44E0D1C5@jetbrains.com> <alpine.DEB.2.20.1602061708220.2964@virtualbox>
 <CABCFD40-C1B8-412C-90E3-24147AA6AFA5@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git <git@vger.kernel.org>
To: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 18:11:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSSra-0007VO-69
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 18:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754461AbcBGRLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2016 12:11:01 -0500
Received: from mout.gmx.net ([212.227.17.21]:51199 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754449AbcBGRK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2016 12:10:59 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LoJDJ-1Zqu7t2pab-00gIzO; Sun, 07 Feb 2016 18:10:56
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CABCFD40-C1B8-412C-90E3-24147AA6AFA5@jetbrains.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:+/i6F1H6yuKbQ1WguWc2Ykjy5LfPi65uNptauozr29Jl+nfeqae
 7zaUIll06O8BFhcuohTxRSjWN3v4tFsElH9Ku3KQ5ZfAYVUAABpeQlL8WpIKY1TwXVutnYS
 T+Z8D7XFzVPMyV6p1ItY2hM1GCREo0QARAnIOxQ37uTZnKhpO7NI3bPGEEJArj0Lh9GQvE8
 g+I7qjsCFVtGsBYj14hVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TgxjqR80Gqs=:TxahfoxdfzL1xbqOcZ7JbR
 mls810SQkwm8YHeB4ly2PuFCKy8BC8DPey5awfHuBQYHvWAxqz1ynVsf3Nlsl8I1ss6HSEoAG
 IxMFQINPGta5RcUNP4A4SP1jrXcLyyDQbwm9ajfSvZ8yozzrNjfTuJ3VEoquzgb+UMPO0rw03
 JbyQXt3q+0DW2Os6cEdQ06+yYgd9IxTcuyh6E49+XovPFblodP62mPRWoGjRZMQQ7Iu/n2w+I
 JGFag56TtmwA7rgA7yj75QXAucrNTve9NGUGzH+kIGYnGMsTgLAyzI/9+u6ivYHGB5628FjjK
 tYxuMyVwa8XP6BltgK8YnFqdUREnf5yP7BhXcjf8HLkaFnN07AY+Ar28W41w55o+se5jXaKQj
 H/YzlDpAc02RrJeV2lyXRIdvC51IvPPgr3WqYZwZnxTW2lxSTghXMMH5hLWhkeSCdBGW4iIUo
 UCDLGrahGk35Lr1zIaKtApAJJIUAHK92yOoKmT5/Dop+TqGvSeqF7JgIZyeMCKxEWO770CqZD
 1Y3eY6e5+FvEc9+36XQsTXDon+QUd1d5/3ekbat7R7cFrxOxa9tj/2RYmzIXKrZ79SxmlI4Jz
 wdgogr7wQbwy0G1yd/ZyhotRtB7x24cyLjfv0Ctpj4J5pVsn/eW+NjHG0Xlrcg34OPNXeq4oG
 KTpVwdy3lVyg6Whaa1M86dIC34hVHm2Bky8++UnJZp90YeeEEYuvX3OPVNbRjSlQtRmOkOrpz
 8tgQicjqA7Q3ySov8SBtu9XlR4w2v3i9l++GwAKkOt8Zo1iPZq2Y5nDVgaXnG0Zo7mOobbiE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285734>

Hi Kirill,

On Sun, 7 Feb 2016, Kirill Likhodedov wrote:

> > On 06 Feb 2016, at 19:10 , Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > 	git show 'HEAD:bra[ckets].txt' --
> > 
> 
> Nice catch! It works for me even without quotes.

Only by chance. Once you have a HEAD:brat.txt file in the current working
directory, it will break.

> Anyway, thanks a lot for finding the workaround.

I would not exactly call this a work-around, but a precise way to specify
that you are *not* talking about a file.

Ciao,
Johannes
