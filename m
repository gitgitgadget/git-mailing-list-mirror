From: Sam Vilain <sam@vilain.net>
Subject: Re: [spf:guess] Re: [spf:guess] Re: [PATCH 1/2] git-svn: ignore
 changeless commits when checking for a cherry-pick
Date: Thu, 07 Jan 2010 22:05:07 +1300
Message-ID: <1262855107.4867.3.camel@denix>
References: <1262808529-1575-1-git-send-email-amyrick@apple.com>
	 <20100106214338.GA5115@dcvr.yhbt.net> <4B4510EE.4090504@vilain.net>
	 <20100107064916.GA8557@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Andrew Myrick <amyrick@apple.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jan 07 10:05:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSoJP-0002SE-GA
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 10:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468Ab0AGJFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 04:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502Ab0AGJFU
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 04:05:20 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:42952 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932558Ab0AGJFO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 04:05:14 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 3F8C521C4D1; Thu,  7 Jan 2010 22:05:08 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
Received: from [192.168.69.234] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id D06C721C386;
	Thu,  7 Jan 2010 22:05:03 +1300 (NZDT)
In-Reply-To: <20100107064916.GA8557@dcvr.yhbt.net>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136334>

On Wed, 2010-01-06 at 22:49 -0800, Eric Wong wrote:
> Sam Vilain <sam@vilain.net> wrote:
> > Eric Wong wrote:
> > > Andrew Myrick <amyrick@apple.com> wrote:
> > >   
> > >> diff --git a/git-svn.perl b/git-svn.perl
> > >
> > > Hi Andrew,
> > >
> > > I'll again defer to Sam for Acks on these.  Test cases would be nice to
> > > have, too.
> > >   
> > 
> > They look fine to me, agreed a test case would be nice and make sure the
> > features aren't lost later inadvertently.
> 
> Thanks Sam,
> 
> Shall I consider this an Ack and push Andrew's new changes
> up while waiting for test cases?

Sure, the intent looks fine and given that Andrew has likely been using
it a lot it's probably right.  So yes, that's an ack.  Hopefully I'll
find time to push along some tests soon.

Cheers,
Sam
