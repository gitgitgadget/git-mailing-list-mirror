X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Add branch.*.localmerge and documentation update
Date: Fri, 8 Dec 2006 23:01:56 +0100
Message-ID: <200612082301.57037.Josef.Weidendorfer@gmx.de>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com> <8aa486160612081252t1e245104x58c8a6654d887af5@mail.gmail.com> <7vr6vagja6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 8 Dec 2006 22:02:12 +0000 (UTC)
Cc: Santi =?iso-8859-1?q?B=E9jar?= <sbejar@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <7vr6vagja6.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33756>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsnnE-0003gL-1x for gcvg-git@gmane.org; Fri, 08 Dec
 2006 23:02:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947418AbWLHWCE convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006 17:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947419AbWLHWCE
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 17:02:04 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:35598 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S1947418AbWLHWCC convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 17:02:02 -0500
Received: from dhcp-3s-46.lrr.in.tum.de (dhcp-3s-46.lrr.in.tum.de
 [131.159.35.46]) by mail.in.tum.de (Postfix) with ESMTP id 9DAC7282A; Fri,  8
 Dec 2006 23:02:00 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Friday 08 December 2006 22:38, Junio C Hamano wrote:
> "Santi B=E9jar" <sbejar@gmail.com> writes:
>=20
> > On 12/8/06, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> >> Clarify the meaning of branch.*.merge option and add a similar
> >> branch.*.localmerge option, which can be used to specify a local
> >> tracking branch to be merged by default.
>=20
> I am not so sure about the "localmerge" stuff anymore.
>=20
> What convenience would it buy us (including but not limited to
> new people), and if there is any, would that outweigh the
> potential confusion factor to have two different configuration
> variables that do exactly the same thing whose sole difference
> is which side of the fetched branch namespace it uses to specify
> the merge source?

I just came up with a concrete patch.
I am not saying that this is the only true solution.

Actually, Jakubs one with allowing arbitrary refspecs is nice.
The only problem is that it is not consistent which refspec
shortcuts otherwise, or?

However, you should take the documentation part and the warning
when there is no match .

