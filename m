From: Dave Watson <dwatson@mimvista.com>
Subject: Re: Java Git (aka jgit) library switching license to BSD/EPL
Date: Thu, 8 May 2008 22:29:37 -0400
Message-ID: <1CC65F01-3F34-4DE9-9AB8-BAB2F1C22723@mimvista.com>
References: <20080509021158.GA29038@spearce.org>
Mime-Version: 1.0 (iPhone Mail 5A274d)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Philippe Ombredanne <philippe@easyeclipse.org>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri May 09 04:50:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuIgZ-0000Jj-Sr
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 04:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbYEICt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 22:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbYEICtZ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 22:49:25 -0400
Received: from net-207-58-228-27.arpa.fidelityaccess.net ([207.58.228.27]:58125
	"EHLO zimbra.mimvista.com" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750808AbYEICtX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 May 2008 22:49:23 -0400
X-Greylist: delayed 1160 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 May 2008 22:49:23 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.mimvista.com (Postfix) with ESMTP id 6FC2439CCD1;
	Thu,  8 May 2008 22:28:13 -0400 (EDT)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -1.705
X-Spam-Level: 
X-Spam-Status: No, score=-1.705 tagged_above=-10 required=6.6
	tests=[AWL=-1.152, BAYES_00=-2.599, RCVD_IN_SORBS_DUL=2.046]
Received: from zimbra.mimvista.com ([127.0.0.1])
	by localhost (zimbra.mimvista.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PKoounK8NH8h; Thu,  8 May 2008 22:28:10 -0400 (EDT)
Received: from [192.168.1.102] (cpe-71-64-107-224.neo.res.rr.com [71.64.107.224])
	by zimbra.mimvista.com (Postfix) with ESMTP id A52E639C076;
	Thu,  8 May 2008 22:28:10 -0400 (EDT)
In-Reply-To: <20080509021158.GA29038@spearce.org>
X-Mailer: iPhone Mail (5A274d)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81594>

I have no objection to the relicense, if it will help things out.

--
Dave Watson
Director of Software Development
MIMvista Corp.

On May 8, 2008, at 10:11 PM, "Shawn O. Pearce" <spearce@spearce.org>  
wrote:

> The Java Git library (also known as "jgit"[*1*]) is a 100% pure Java
> implementation of a data access library for the Git on-disk data
> structures, as well as a re-implementation of some commonly used
> application functions such as history graph traversal/visualization
> and network transport (fetch).
>
> Since its inception on March 6, 2006 jgit has been under the
> GPLv2 license.  To make the library available to a wider audience
> (including but not limited to the Eclipse Git plugin, numerous
> Apache projects such as Ant/Maven, the Netbeans IDE, etc.) we are
> switching to a dual license between a 3-clause BSD (the EDL[*2*])
> and the EPL[*3*].
>
> As of the bleeding edge (40c5c6cb11b8cc6caf3ea6a681caf0a6b8d66f36
> [*4*]) the ownership of all currently surviving lines of code is
> broken down as follows:
>
>   $ sh owner.sh
>    78%   27607 Shawn O. Pearce
>    17%    6061 Robin Rosenberg
>     4%    1518 Dave Watson
>     0%       4 Thad Hughes
>     0%       2 Roger C. Soares
>   ------------------------------
>   100%   35192 total
>
> Robin and Dave:
>
>  With 17% and 4% ownership, can you please reply to verify
>  this license change will be permitted for your contributions?
>  Please note this change is _only_ to jgit, and not to the egit
>  (Eclipse plugin) code.
>
> Nico, Linus, Junio, Daniel, Dscho, et.al.:
>
>  We would appreciate it if you could provide a statement saying
>  you have no current copyright ownership interest in jgit, and that
>  you do not currently own nor invented any patents related to the
>  "Git technology" that this code might need to use to function as
>  a Git implementation.
>
>  Part of the application process for EGit to become a project
>  under the umbrella of the Eclipse Foundation[*5*] requires us
>  to be reasonably certain the source code we are contributing is
>  free of claims that could be brought by a 3rd party.  A statement
>  from major contributors to C Git (those who created much of the
>  C implementation) would show those individuals have no claims
>  to bring against the current version of jgit, and that jgit is
>  therefore likely to be free of any IP claims.
>
>  There are three particular sections of jgit code that I would
>  like to bring to your attention before you respond:
>
>    * BinaryDelta[*6*] bears a striking simiarlity to patch-delta.c.
>    * PackFetchConnection[*7*] does what builtin-fetch-pack.c does.
>    * IndexPack[*8*] does what index-pack.c does.
>
>  Here (and everywhere else in jgit) we have tried to avoid directly
>  translating C->Java, but sometimes things just come out in a
>  similar way once expressed in source form.  Knowing both the jgit
>  and C git code well I think these are the closest sections where
>  someone might suspect jgit copied code from C git.  The attached
>  owner.sh script applied to those three files in C git came up
>  with the following major contributors:
>
>       33%     616 Nicolas Pitre
>       16%     304 Junio C Hamano
>       13%     241 Johannes Schindelin
>       10%     197 Sergey Vlasov
>        5%     107 Linus Torvalds
>        5%     105 Shawn O. Pearce
>        5%      94 Martin Koegler
>        3%      71 Daniel Barkalow
>        2%      40 Johannes Sixt
>        1%      36 Geert Bosch
>
>
> *1*  http://repo.or.cz/w/egit.git
> *2*  http://www.eclipse.org/org/documents/edl-v10.php
> *3*  http://www.eclipse.org/org/documents/epl-v10.php
> *4*  http://repo.or.cz/w/egit/spearce.git
> *5*  http://wiki.eclipse.org/EGit/Proposal
>
> *6*  http://repo.or.cz/w/egit/spearce.git?a=blob;f=org.spearce.jgit/src/org/spearce/jgit/lib/BinaryDelta.java;h=bba6b19a4000923abfe57b844bae17e7a03e0419;hb=40c5c6cb11b8cc6caf3ea6a681caf0a6b8d66f36
> *7*  http://repo.or.cz/w/egit/spearce.git?a=blob;f=org.spearce.jgit/src/org/spearce/jgit/transport/PackFetchConnection.java;h=c7fa66c0654eaf84c143e61ee4d11b74d73db28f;hb=40c5c6cb11b8cc6caf3ea6a681caf0a6b8d66f36
> *8*  http://repo.or.cz/w/egit/spearce.git?a=blob;f=org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java;h=b6e5956f62fa8cb60770c991699ae7b457d8954f;hb=40c5c6cb11b8cc6caf3ea6a681caf0a6b8d66f36
>
> --8< owner.sh --
> #!/bin/sh
>
> for f in $(git ls-files \
>    jgit \
>    org.spearce.jgit \
>    org.spearce.jgit.test \
>    | egrep -v '.(launch|pack|idx)$' \
>    | egrep -v ^org.spearce.jgit/lib/ \
>    )
> do
>    git blame -C -C --whitespace "$f"
> done | perl -e '
>    $total = 0;
>    while (<>) {
>        die "$_\n" unless
>        /^[0-9a-f]+ (?:[^)]+)?\((.*?) \d{4}-\d{2}-\d{2} /;
>        $n = $1;
>        $n =~ s/^\s+//;
>        $n =~ s/\s+$//;
>        $who{$n}++;
>        $total++;
>    }
>    @own = map {[$_, $who{$_}, $who{$_} * 100 / $total]} keys %who;
>    $fnd = 0;
>    foreach (sort {$b->[2] <=> $a->[2]} @own) {
>        $fnd += $_->[1];
>        printf "%3i%% %7i %s\n", $_->[2], $_->[1], $_->[0];
>    }
>    $unk = $total - $fnd;
>    print "-" x 30, "\n";
>    if ($unk > 0) {
>        printf "%3i%% %7i (unknown)\n", $unk * 100 / $total, $unk;
>    }
>    printf "%3i%% %7i total\n", 100, $total;
> '
>
> -- 
> Shawn.
