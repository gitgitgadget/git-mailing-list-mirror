X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Collection of stgit issues and wishes
Date: Wed, 13 Dec 2006 12:03:14 +0100
Message-ID: <20061213110314.GA22670@diana.vm.bytemark.co.uk>
References: <20061208221744.GA3288@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0612120143j7d0c1026rab046c8f44ec43ca@mail.gmail.com> <87y7pc2rc7.fsf@morpheus.local> <457FD3E4.3090104@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 13 Dec 2006 11:31:40 +0000 (UTC)
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 1693 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 06:31:34 EST
Content-Disposition: inline
In-Reply-To: <457FD3E4.3090104@op5.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34211>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuSKn-00053U-U9 for gcvg-git@gmane.org; Wed, 13 Dec
 2006 12:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964851AbWLMLbf convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006 06:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWLMLbf
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 06:31:35 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2149 "EHLO
 diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S964851AbWLMLbe (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec
 2006 06:31:34 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GuRtK-0006Ow-00; Wed, 13 Dec 2006 11:03:14 +0000
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

On 2006-12-13 11:20:20 +0100, Andreas Ericsson wrote:

> David K=E5gedal wrote:
>
> > "Catalin Marinas" <catalin.marinas@gmail.com> writes:
> >
> > > On 08/12/06, Yann Dirson <ydirson@altern.org> wrote:
> > >
> > > > - shortcuts (st -> status, etc.), possibly making use of the
> > > >   git alias system ?
> > >
> > > Did this last night as it was pretty easy and without the GIT
> > > alias system (which I am not familiar with). The idea is that if
> > > it cannot find an exact match, it tries to look for all the
> > > commands starting with the passed argument. If more than one
> > > command is found, it reports an "ambiguous command".
> >
> > That approach can cause problems later on. If "stgit st" is
> > currently a unique prefix of "stgit status", people might use it
> > in scripts. Then, one day, you add the "stgit store" command, or
> > whatever, and their scripts start breaking for no good reason.
>
> People who use abbreviations of commands in scripts ought to be
> shot, not catered to, especially if they know this abbreviation is
> automagically calculated.

Well, yes, but there's no reason to not shoot them _politely_ ...

I'd prefer hand-picked command abbreviations to reduce namespace
clutter. That way, it's even possible to have "ambiguous" shortcuts --
for example, "stg st" -> "stg status" even if "stg store" exists. And
shortcuts that aren't prefixes, like "stg ua" -> "stg unapplied". And
the user doesn't need to retrain her fingers just because a prefix
gets ambiguous.

=46or prefixes, tab completion is a much better answer.

--=20
Karl Hasselstr=F6m, kha@treskal.com
