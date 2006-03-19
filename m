From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH] Added Packing Heursitics IRC writeup.
Date: Sun, 19 Mar 2006 01:32:56 +0100
Message-ID: <20060319003255.GA17124@c165.ib.student.liu.se>
References: <E1FEyx7-0007vo-Je@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jon Loeliger <jdl@jdl.com>
X-From: git-owner@vger.kernel.org Sun Mar 19 01:33:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKlrB-0006Iu-8y
	for gcvg-git@gmane.org; Sun, 19 Mar 2006 01:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWCSAdE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Mar 2006 19:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWCSAdE
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Mar 2006 19:33:04 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:15511 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1750849AbWCSAdC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Mar 2006 19:33:02 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 27EA54114; Sun, 19 Mar 2006 01:49:04 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FKlqq-0004YN-00; Sun, 19 Mar 2006 01:32:56 +0100
To: junkio@cox.net
Content-Disposition: inline
In-Reply-To: <E1FEyx7-0007vo-Je@jdl.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17706>

On Thu, Mar 02, 2006 at 07:19:29PM -0600, Jon Loeliger wrote:
> 
> Signed-off-by: Jon Loeliger <jdl@jdl.com>
> 
> ---
> 
>  Documentation/technical/pack-heuristics.txt |  466 +++++++++++++++++++++++++++
>  1 files changed, 466 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/technical/pack-heuristics.txt
> 
> 0cbbcac437be6f8a0249f6cf83b90a6fe9d2362e
> diff --git a/Documentation/technical/pack-heuristics.txt b/Documentation/technical/pack-heuristics.txt
> new file mode 100644
> index 0000000..eaab3ee
> --- /dev/null
> +++ b/Documentation/technical/pack-heuristics.txt
> @@ -0,0 +1,466 @@
> +        Concerning Git's Packing Heuristics
> +        ===================================
> +

[nice description of Git's packing heuristics]

Junio, are there any specific reasons why this hasn't been applied
yet?

- Fredrik
