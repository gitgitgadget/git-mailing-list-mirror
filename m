From: Bernd Jendrissek <bernd.jendrissek@gmail.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Thu, 17 Sep 2009 16:23:44 +0000 (UTC)
Message-ID: <loom.20090917T180857-851@post.gmane.org>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com> <fbr2iv$ugg$1@sea.gmane.org> <46E11CE1.4030209@op5.se> <fbs8es$1cd$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 18:35:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoJwv-0000a2-Nu
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 18:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758531AbZIQQfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 12:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754305AbZIQQfD
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 12:35:03 -0400
Received: from lo.gmane.org ([80.91.229.12]:37610 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753420AbZIQQfB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 12:35:01 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MoJwm-0000XY-B3
	for git@vger.kernel.org; Thu, 17 Sep 2009 18:35:04 +0200
Received: from 196.7.137.175 ([196.7.137.175])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 18:35:04 +0200
Received: from bernd.jendrissek by 196.7.137.175 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 18:35:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 196.7.137.175 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.13) Gecko/2009080316 Ubuntu/8.04 (hardy) Firefox/3.0.13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128764>

Walter Bright <boost <at> digitalmars.com> writes:
> Sure, but I suggest that few projects reach this maxima. Case in point: 
> ld, the gnu linker. It's terribly slow. To see how slow it is, compare 
> it to optlink (the 15 years old one that comes with D for Windows). So I 
> don't believe there is anything inherent about linking that should make 
> ld so slow. There's some huge leverage possible in speeding up ld 
> (spreading out that saved time among all the gnu developers).

http://en.wikipedia.org/wiki/Gold_(linker)

Note that gold is written in C++; the wikipedia quasi-stub article doesn't make
this clear.  Normally that wouldn't be relevant, but in this branch of the
thread it is.  Its C++-ness seems to be making an argument, but I don't know on
which side!
