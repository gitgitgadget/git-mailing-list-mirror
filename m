From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: cogito - how do I ???
Date: Tue, 24 May 2005 12:26:28 +1000
Organization: Core
Message-ID: <E1DaP7k-0007ar-00@gondolin.me.apana.org.au>
References: <Pine.LNX.4.58.0505230731430.2307@ppc970.osdl.org>
Cc: sithglan@stud.uni-erlangen.de, seanlkml@sympatico.ca,
	sam@ravnborg.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 04:27:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaP8D-0002z6-0f
	for gcvg-git@gmane.org; Tue, 24 May 2005 04:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVEXC2U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 22:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVEXC2U
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 22:28:20 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:53002 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261332AbVEXC2Q
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 22:28:16 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] ident=mail)
	by arnor.apana.org.au with esmtp (Exim 3.35 #1 (Debian))
	id 1DaP7x-0002jN-00; Tue, 24 May 2005 12:26:41 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1DaP7k-0007ar-00; Tue, 24 May 2005 12:26:28 +1000
To: torvalds@osdl.org (Linus Torvalds)
In-Reply-To: <Pine.LNX.4.58.0505230731430.2307@ppc970.osdl.org>
X-Newsgroups: apana.lists.os.linux.git
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> 
> I actually suspect that whole time thing was a mistake, it seemed sensible 
> back when we didn't have any other way of ordering the changesets well, 
> but it's really a bad ordering anyway to do it by time (ie add a "sort 
> -rn" in there), and we can (and probably should) order rev-tree output 
> with some topological sort based on the commit tree.

Yes please.  Can we also have a rev-* command that outputs parent
relations instead of a simple list? That is,

<tree-1> <parent-1>
<tree-1> <parent-2>
<tree-2> <parent-3>
...

Then you could just run tsort for rev-tree, plus you could use this
for other things like finding merges.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
