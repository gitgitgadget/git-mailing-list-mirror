X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Add branch.*.localmerge and documentation update
Date: Sat, 9 Dec 2006 00:17:43 +0100
Message-ID: <200612090017.44105.Josef.Weidendorfer@gmx.de>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com> <200612082301.57037.Josef.Weidendorfer@gmx.de> <7v1wnaggp7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 23:18:02 +0000 (UTC)
Cc: Santi =?iso-8859-1?q?B=E9jar?= <sbejar@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <7v1wnaggp7.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33765>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsoye-0004Wu-P1 for gcvg-git@gmane.org; Sat, 09 Dec
 2006 00:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761266AbWLHXRv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 18:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761267AbWLHXRv
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 18:17:51 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:36115 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S1761266AbWLHXRu (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 18:17:50 -0500
Received: from dhcp-3s-46.lrr.in.tum.de (dhcp-3s-46.lrr.in.tum.de
 [131.159.35.46]) by mail.in.tum.de (Postfix) with ESMTP id 701B72163; Sat,  9
 Dec 2006 00:17:48 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Friday 08 December 2006 23:34, Junio C Hamano wrote:
> >> What convenience would it buy us (including but not limited to
> >> new people), and if there is any, would that outweigh the
> >> potential confusion factor to have two different configuration
> >> variables that do exactly the same thing whose sole difference
> >> is which side of the fetched branch namespace it uses to specify
> >> the merge source?
> >
> > I just came up with a concrete patch.
> > I am not saying that this is the only true solution.
> 
> I admit that I do not use branch.*.merge and I do not know what
> people find lacking in what Santi did in late September with
> commit 5372806.  What problem are we trying to solve (not a
> rhetorical question -- I am truly lost here)?  Is it only a
> confusion between remote and local, or is there something that
> cannot be expressed with the current scheme?

More or less, yes.

When this thread started, I remembered being bitten exactly by
this issue. And I only understood my problem after looking and
trying to understand the code.
Therefore, it was quite easy to come up with this patch.

IMHO, a problem really is the people do not want to read documentation.
They see the branch.*.merge option in .git/config, and try to build
their own mental model how it works.

Perhaps the warning I added now would have been enough for me to see
my error; it points at the misconfigured option. For sure, I would
have looked up the manual for the meaning of this option after seeing
the warning.
But the previous documentation simply was way to short.

Should I send a "simplified" patch?

