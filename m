From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: git format-patch shell quoting bug
Date: Sat, 7 Jan 2006 14:16:40 -0500
Message-ID: <20060107191640.GD15084@quicksilver.road.mcmartin.ca>
References: <20060104045519.GB29515@quicksilver.road.mcmartin.ca> <7vhd8gpxt3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 20:17:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvJZG-00036n-P0
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 20:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030555AbWAGTRS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 14:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030569AbWAGTRS
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 14:17:18 -0500
Received: from cabal.ca ([134.117.69.58]:5761 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1030555AbWAGTRQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 14:17:16 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by fattire.cabal.ca (Postfix) with ESMTP id 5271223E86;
	Sat,  7 Jan 2006 14:17:13 -0500 (EST)
Received: from fattire.cabal.ca ([127.0.0.1])
	by localhost (fattire [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 03160-08; Sat, 7 Jan 2006 14:17:13 -0500 (EST)
Received: from quicksilver.road.mcmartin.ca (CPE0004ace53177-CM0012c9a9a56e.cpe.net.cable.rogers.com [70.25.68.204])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "quicksilver.road.mcmartin.ca", Issuer "There Is No Cabal Certificate Authority" (verified OK))
	by fattire.cabal.ca (Postfix) with ESMTP id F062123E83;
	Sat,  7 Jan 2006 14:17:12 -0500 (EST)
Received: by quicksilver.road.mcmartin.ca (Postfix, from userid 1000)
	id C2ACC3B05D; Sat,  7 Jan 2006 14:16:40 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhd8gpxt3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at cabal.ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14270>

On Fri, Jan 06, 2006 at 06:38:16PM -0800, Junio C Hamano wrote:
>     commit aa66c7ec77d474b737da607d6cb2d07f56628def
>     Author: Junio C Hamano <junkio@cox.net>
>     Date:   Thu Jan 5 19:50:37 2006 -0800
> 
>         format-patch/commit: Quote single quote in the author name properly.
> 
>         Noticed by Kyle McMartin.
> 
>         Signed-off-by: Junio C Hamano <junkio@cox.net>
> 
> The bug was present ever since format-patch started picking up
> the original authorship information from the commits, done on
> July 22nd last year, between v0.99.1 and v0.99.2.
>

Awesome. Thanks very much for fixing this!

Cheers,
	Kyle 
