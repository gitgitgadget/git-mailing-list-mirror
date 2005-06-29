From: Thomas Arendsen Hein <thomas@intevation.de>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Wed, 29 Jun 2005 08:32:33 +0200
Message-ID: <20050629063233.GE16872@intevation.de>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz> <20050624123819.GD9519@64m.dyndns.org> <20050628150027.GB1275@pasky.ji.cz> <20050628180157.GI12006@waste.org> <62CF578B-B9DF-4DEA-8BAD-041F357771FD@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 29 08:26:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnW1G-0004tP-VJ
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 08:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVF2GdG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 02:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVF2GdG
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 02:33:06 -0400
Received: from aktaia.intevation.org ([212.95.126.10]:12777 "EHLO
	mail.intevation.de") by vger.kernel.org with ESMTP id S261668AbVF2GdB
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 02:33:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.intevation.de (Postfix) with ESMTP
	id 2602A36E43; Wed, 29 Jun 2005 08:33:00 +0200 (CEST)
Received: from thetis.hq (thetis.hq [192.168.11.13])
	by mail.intevation.de (Postfix) with SMTP
	id AFE9D36DDD; Wed, 29 Jun 2005 08:32:58 +0200 (CEST)
Received: (nullmailer pid 19045 invoked by uid 10004);
	Wed, 29 Jun 2005 06:32:33 -0000
To: mercurial@selenic.com
Mail-Followup-To: mercurial@selenic.com,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <62CF578B-B9DF-4DEA-8BAD-041F357771FD@mac.com>
User-Agent: Mutt/1.3.28i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

(repost to all lists who received the original mail)

* Kyle Moffett <mrmacman_g4@mac.com> [20050628 22:28]:
> On Jun 28, 2005, at 14:01:57, Matt Mackall wrote:
> >Everything in Mercurial is an append-only log. A transaction journal
> >records the original length of each log so that it can be restored on
> >failure.
> 
> Does this mean that (excepting the "undo" feature) one could set the
> ext3 "append-only" attribute on the repository files to avoid losing
> data due to user account compromise?

This will break Mercurial's journaling. If 'hg pull' fails it
truncates the already appended-to files to the last known state.

Thomas

-- 
Email: thomas@intevation.de
http://intevation.de/~thomas/
