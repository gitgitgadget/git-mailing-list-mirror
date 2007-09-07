From: Paul Wankadia <junyer@gmail.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 7 Sep 2007 04:06:35 +0000 (UTC)
Message-ID: <loom.20070907T055946-637@post.gmane.org>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 06:11:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITVBJ-0004Py-2n
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 06:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbXIGEKS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 00:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbXIGEKQ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 00:10:16 -0400
Received: from main.gmane.org ([80.91.229.2]:33427 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189AbXIGEKO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 00:10:14 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1ITVAQ-0007sk-PG
	for git@vger.kernel.org; Fri, 07 Sep 2007 06:10:03 +0200
Received: from 210.9.11.194 ([210.9.11.194])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 06:10:02 +0200
Received: from junyer by 210.9.11.194 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 06:10:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 210.9.11.194 (Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.7.13) Gecko/20060426)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57971>

Wincent Colaiuta <win <at> wincent.com> writes:

> > I just wanted to get a sense of how many people share this "Git should
> > be in pure C" doctrine.
> 
> Count me as one of them. Git is all about speed, and C is the best  
> choice for speed, especially in context of Git's workload.

I concur, but I also feel that D, Clean and OCaml are viable alternatives.
