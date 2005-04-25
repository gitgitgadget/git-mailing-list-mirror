From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Subject: Re: A darcs that can pull from git
Date: Mon, 25 Apr 2005 17:12:59 +0200
Message-ID: <7i4qdusxdw.fsf@lanthane.pps.jussieu.fr>
References: <7ipswjbybx.fsf@lanthane.pps.jussieu.fr>
	<20050425133116.GG11667@abridgegame.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Apr 25 17:09:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ5C4-0003JP-K6
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 17:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbVDYPNN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 11:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVDYPNN
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 11:13:13 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:58594 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id S262662AbVDYPNF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 11:13:05 -0400
Received: from hydrogene.pps.jussieu.fr (hydrogene.pps.jussieu.fr [134.157.168.1])
          by shiva.jussieu.fr (8.12.11/jtpda-5.4) with ESMTP id j3PFD1Xa089749
          ; Mon, 25 Apr 2005 17:13:01 +0200 (CEST)
X-Ids: 168
Received: from lanthane.pps.jussieu.fr (lanthane.pps.jussieu.fr [134.157.168.57])
          by hydrogene.pps.jussieu.fr (8.13.3/jtpda-5.4) with ESMTP id j3PFCxd8015340
          ; Mon, 25 Apr 2005 17:12:59 +0200
Received: from jch by lanthane.pps.jussieu.fr with local (Exim 4.34)
	id 1DQ5Gd-0003pl-28; Mon, 25 Apr 2005 17:12:59 +0200
To: darcs-devel@darcs.net, Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20050425133116.GG11667@abridgegame.org> (David Roundy's
 message of "Mon, 25 Apr 2005 09:31:20 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.2 (shiva.jussieu.fr [134.157.0.168]); Mon, 25 Apr 2005 17:13:01 +0200 (CEST)
X-Antivirus: scanned by sophie at shiva.jussieu.fr
X-Miltered: at shiva.jussieu.fr with ID 426D08FD.001 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>   http://www.pps.jussieu.fr/~jch/software/files/darcs-git-20050424.darcs

> First off, you need to include a license header in the git files indicating
> that unlike the rest of darcs, they may only be distributed under GPL v2.

Linus, could you please suggest a suitable license statement to
include in whichever files of yours we choose to include in Darcs?  Is
David's suggestion (stock GPL boilerplate with ``or any later
version'' removed) okay with you?

> Any chance you can host a gettable repository?

The last tag in darcs-unstable is 1.0.0rc2, which prevents me from
publishing a partial repository in my web space.  Perhaps you could
pull a recent tag into darcs-unstable?

> If not, I'd be happy to give you an account on darcs.net on which
> you could host darcs-git.

That would be great (let me know if you need an ssh public key).

> Do you have any plans/ideas for allowing pulls directly from a
> remote git repository?

I haven't thought about it yet.  Does anyone have any ideas about how
to efficiently pull from git without a complete local copy?

I'll reply to the more technical points below on darcs-devel -- no
point in spamming the kind folks on git@ any further, especially as
they probably know about

  http://www.abridgegame.org/pipermail/darcs-devel/

                                        Juliusz

