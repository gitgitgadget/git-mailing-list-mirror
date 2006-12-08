X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Add branch.*.localmerge and documentation update
Date: Fri, 8 Dec 2006 22:39:38 +0100
Message-ID: <200612082239.38423.Josef.Weidendorfer@gmx.de>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com> <200612082012.19167.Josef.Weidendorfer@gmx.de> <8aa486160612081252t1e245104x58c8a6654d887af5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 8 Dec 2006 21:39:51 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Aneesh Kumar K.V" <aneesh.kumar@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <8aa486160612081252t1e245104x58c8a6654d887af5@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33751>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsnRb-0000zQ-K5 for gcvg-git@gmane.org; Fri, 08 Dec
 2006 22:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947317AbWLHVjo convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006 16:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947319AbWLHVjo
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 16:39:44 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:35503 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S1947317AbWLHVjn convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 16:39:43 -0500
Received: from dhcp-3s-46.lrr.in.tum.de (dhcp-3s-46.lrr.in.tum.de
 [131.159.35.46]) by mail.in.tum.de (Postfix) with ESMTP id D19A679C; Fri,  8
 Dec 2006 22:39:41 +0100 (MET)
To: "Santi =?iso-8859-1?q?B=E9jar?=" <sbejar@gmail.com>
Sender: git-owner@vger.kernel.org

On Friday 08 December 2006 21:52, Santi B=E9jar wrote:
> On 12/8/06, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> > Clarify the meaning of branch.*.merge option and add a similar
> > branch.*.localmerge option, which can be used to specify a local
> > tracking branch to be merged by default.
> >
> > Previously, if branch.*.merge was specified but did not match any
> > ref, the message "No changes." was not really helpful regarding
> > the misconfiguration. This now gives a warning.
> >
> > The value of branch.*.merge can be a list to get an octopus
> > merge. I chose the same way for branch.*.localmerge, and if
> > you specify both options, the octopus merge will have even
> > more parents ;-)
> >
> > Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
>=20
> Ack for the documentation part. But the localmerge part is almost
> equivalent to my patch to allow the branch.<name>.remote equal to "."=
=2E

Interesting. I did not have a look at your patch.
The support for the "branch.*.localmerge" option is one step to be
able to support a remote ".". So of course, it probably is similar.
I even would say that "." as remote now actually makes sense as
logical extension.

However, what would you change in the implementation part of my patch?

