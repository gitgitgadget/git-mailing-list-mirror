From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Where'd my GIT tree go?
Date: Thu, 07 Jul 2005 22:48:01 +0200
Organization: linutronix
Message-ID: <1120769281.26713.153.camel@tglx.tec.linutronix.de>
References: <12c511ca0507062023291a098e@mail.gmail.com>
	 <2cfc40320507062059233bb98c@mail.gmail.com>
	 <12c511ca0507062148679af4da@mail.gmail.com>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: jon@blackcubes.dyndns.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 22:51:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqdKj-0001zh-4E
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 22:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVGGUsA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 16:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVGGUpM
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 16:45:12 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:58026
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261386AbVGGUo7
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Jul 2005 16:44:59 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 0F55365C065;
	Thu,  7 Jul 2005 22:42:10 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id BF5C728376;
	Thu,  7 Jul 2005 22:44:59 +0200 (CEST)
To: Tony Luck <tony.luck@gmail.com>
In-Reply-To: <12c511ca0507062148679af4da@mail.gmail.com>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-07-06 at 21:48 -0700, Tony Luck wrote:
> Groan ... as well you should.
> 
> My tree has re-appeared now.  Thanks to whoever fixed it.

I noticed similar effects recently. Its related to the mirroring of
master.kernel.org to the public server. At some point you have only the
half of updates at the public site and obviously the git webscript
refuses to show your tree when HEAD is updated, but the referenced
commit blob is missing.

I guess that the mirroring is not aware of the update order (objects
first, HEAD last) which would prevent such oddities.

tglx
