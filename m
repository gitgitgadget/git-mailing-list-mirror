From: Dragos Foianu <dragos.foianu@gmail.com>
Subject: Re: [BUG] Segfault on git describe
Date: Sat, 22 Mar 2014 10:18:44 +0000 (UTC)
Message-ID: <loom.20140322T111539-312@post.gmane.org>
References: <532975FB.9030803@mozilla.com> <loom.20140319T224201-156@post.gmane.org> <20140320233307.GB7774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 11:19:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRJ1P-0006z4-Id
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 11:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbaCVKTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 06:19:13 -0400
Received: from plane.gmane.org ([80.91.229.3]:53240 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbaCVKTK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 06:19:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WRJ1B-0006s1-39
	for git@vger.kernel.org; Sat, 22 Mar 2014 11:19:09 +0100
Received: from mcdonalds-reginaelisabeta43-fo.b.astral.ro ([mcdonalds-reginaelisabeta43-fo.b.astral.ro])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 22 Mar 2014 11:19:09 +0100
Received: from dragos.foianu by mcdonalds-reginaelisabeta43-fo.b.astral.ro with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 22 Mar 2014 11:19:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 95.76.156.248 (Mozilla/5.0 (Windows NT 6.2; WOW64; rv:28.0) Gecko/20100101 Firefox/28.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244767>

Jeff King <peff <at> peff.net> writes:

> 
> So I think we'd be happy to see it converted to an iterative process
> (probably with a stack on the heap). In addition to name-rev, I believe
> that "tag --contains" will recurse down the longest history path, too (I
> think there may have been experimental patches for the latter, but you'd
> have to search the list archive).
> 
> -Peff
> 

Alright. I'll look into it and hopefully have a patch by the end of the weekend.

-Dragos
