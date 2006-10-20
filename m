From: Sean <seanlkml@sympatico.ca>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 11:37:12 -0400
Message-ID: <BAYC1-PASMTP03623861D4BBE8BD868117AE0D0@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610172351.17377.jnareb@gmail.com>
	<4535590C.4000004@utoronto.ca>
	<200610180057.25411.jnareb@gmail.com>
	<Pine.LNX.4.64.0610171610270.3962@g5.osdl.org>
	<20061018053647.GA3507@coredump.intra.peff.net>
	<Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
	<20061018185225.GU20017@pasky.or.cz>
	<eh76np$trg$1@sea.gmane.org>
	<BAYC1-PASMTP061F10D0B5AF9F6608134CAE0C0@CEZ.ICE>
	<4538D724.5040508@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Alexander Belchenko <bialix@ukr.net>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 17:37:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GawR0-0004An-Eo
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 17:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946423AbWJTPhR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 11:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946420AbWJTPhQ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 11:37:16 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:19607 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1946423AbWJTPhO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 11:37:14 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 20 Oct 2006 08:37:13 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GavUm-000811-AG; Fri, 20 Oct 2006 10:37:12 -0400
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Message-Id: <20061020113712.d192580a.seanlkml@sympatico.ca>
In-Reply-To: <4538D724.5040508@utoronto.ca>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 20 Oct 2006 15:37:13.0879 (UTC) FILETIME=[9D893A70:01C6F45D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 20 Oct 2006 10:03:16 -0400
Aaron Bentley <aaron.bentley@utoronto.ca> wrote:

> In Bazaar bundles, the text of the diff is an integral part of the data.
> It is used to generate the text of all the files in the revision.
> 
> Bazaar bundles were designed to be used on mailing lists.  So you can
> review the changes from the diff, comment on them, and if it seems
> suitable, merge them.

Perhaps I missed something in the earlier mails about this feature.
As I understood it, the email sent has a combined diff that shows
the net effect of all the commits included in the bundle.  (Whereas
the current Cogito version only shows a diffstat)

If the recipient of such a bundle is unable to extract the diff of
each separate commit included in the bundle then I can't see any
value in the feature at all.  But showing a combined diff in the
email may have marginal value, so long as when the bundle is 
imported into the recipient repository the individual commits
are available.

> It's my understanding that most changes discussed on lkml are provided
> as a series of patches.  Bazaar bundles are intended as a direct
> replacement for patches in that use case.

A combined diff of a bunch of changes would usually be most _unwelcome_
for review on lkml.  The constant refrain is to ask people to split their
changes up into smallish individual patches for review.

Sean
