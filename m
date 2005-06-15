From: Pavel Roskin <proski@gnu.org>
Subject: Re: [COGITO PATCH] Fixing "cg-help typo" again
Date: Tue, 14 Jun 2005 20:17:45 -0400
Message-ID: <1118794665.3890.16.camel@dv>
References: <1118791967.3890.11.camel@dv>  <20050614234333.GA17152@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 15 02:13:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiLXL-0008RJ-51
	for gcvg-git@gmane.org; Wed, 15 Jun 2005 02:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVFOASJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Jun 2005 20:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVFOASI
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jun 2005 20:18:08 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:42966
	"EHLO dv.roinet.com") by vger.kernel.org with ESMTP id S261438AbVFOARt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2005 20:17:49 -0400
Received: from dv.roinet.com (localhost.localdomain [127.0.0.1])
	by dv.roinet.com (8.13.4/8.13.4) with ESMTP id j5F0Hjx6012699;
	Tue, 14 Jun 2005 20:17:45 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j5F0HjhQ012696;
	Tue, 14 Jun 2005 20:17:45 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20050614234333.GA17152@diku.dk>
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Jonas!

On Wed, 2005-06-15 at 01:43 +0200, Jonas Fonseca wrote:
> Pavel Roskin <proski@gnu.org> wrote Tue, Jun 14, 2005:
> > I don't know any way to get return status of the first command in a
> > pipeline, so I changed to code to put print_help() output in a variable,
> > check status and then pipe the variable contents through colorize().
> 
> Use the PIPESTATUS aray as in the patch I sent:

OK, your patch is better.

Acked-by: Pavel Roskin <proski@gnu.org>

-- 
Regards,
Pavel Roskin

