From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb wishlist
Date: Sat, 21 May 2005 19:14:09 +0200
Message-ID: <1116695650.19541.12.camel@dhcp-188.off.vrfy.org>
References: <20050511012626.GL26384@pasky.ji.cz>
	 <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>
	 <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>
	 <1116611932.12975.22.camel@dhcp-188>
	 <pan.2005.05.21.07.29.14.58375@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 19:14:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZXXf-0007CF-Ci
	for gcvg-git@gmane.org; Sat, 21 May 2005 19:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVEUROr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 13:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVEUROr
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 13:14:47 -0400
Received: from soundwarez.org ([217.160.171.123]:51868 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261748AbVEUROa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 May 2005 13:14:30 -0400
Received: from dhcp-188.off.vrfy.org (c225177.adsl.hansenet.de [213.39.225.177])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id 39B25866D;
	Sat, 21 May 2005 19:14:27 +0200 (CEST)
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.05.21.07.29.14.58375@smurf.noris.de>
X-Mailer: Evolution 2.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-05-21 at 09:29 +0200, Matthias Urlichs wrote:
> Hi, Kay Sievers wrote:
> 
> > Something like that: :)
> 
> Cool.
> 
> More feature requests:  ;-)
> - Alternate white and almost-white backgrounds in the lists (all of them ;-)
>   so that wide-screened people like me don't lose context when their eyes
>   travel the long road from left to right edge of the screen. ;-)

Done!

> - Merges currently don't have diff links. It'd be nice to have one for
>   each parent.

Done! But I'm not sure if that is really useful. It may create a very
very big diff. :)

> - File diffs have the "diff" link on the *parent*, not on the child.
>   That's counter-intuitive -- if I want to see what the Foo patch changes,
>   I should be able to click on the "diff" link on _that_ line, not the one
>   below it. Example:
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=history;h=9636273dae265b9354b861b373cd43cd76a6d0fe;f=MAINTAINERS

No, the "diff" link is a diff against the current commit not an
incremental one from revision to revision. Me may change that, I'm not
sure what's the best here.

Kay

