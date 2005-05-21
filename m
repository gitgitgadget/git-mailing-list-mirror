From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/3] - Convert git-checkout-cache to argp
Date: Sat, 21 May 2005 17:18:59 -0400
Message-ID: <428FA5C3.6010900@pobox.com>
References: <2242.10.10.10.24.1116700408.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 23:18:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZbMG-0001SH-NQ
	for gcvg-git@gmane.org; Sat, 21 May 2005 23:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVEUVTH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 17:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVEUVTH
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 17:19:07 -0400
Received: from mail.dvmed.net ([216.237.124.58]:48575 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261606AbVEUVTF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 May 2005 17:19:05 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DZbN7-0000z0-CO; Sat, 21 May 2005 21:19:01 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <2242.10.10.10.24.1116700408.squirrel@linux1>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sean wrote:
> Use argp to process command line arguments for git-checkout-cache.  Also,
> fix things up so that the order of options on the command line no longer
> matters.  To this end, the "-f" (--force) switch only applies to the
> individual files given on the command line.   A new forcing version of the
> "-a" (--all) switch is added as "-A" (--forceall).

I agree with Junio -- this patch breaks stuff.

	Jeff



