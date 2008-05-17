From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] "not uptodate" changed to "has local changes"
Date: Sat, 17 May 2008 11:04:09 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805171102480.30431@racer>
References: <1209833972-12256-1-git-send-email-timcharper@gmail.com>  <e2b179460805060631l506e2a6leaafc9c0acf3b05b@mail.gmail.com>  <b8bf37780805151914j65ce5406xc5e6b3d29e3bfb9b@mail.gmail.com>  <alpine.DEB.1.00.0805161125320.30431@racer> 
 <1ED37CF1-EABD-4881-BA29-ED2CB1CE73FC@sb.org> <b8bf37780805162030m4c961505nabd72e8f5bd08404@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-883175977-1211018651=:30431"
Cc: Kevin Ballard <kevin@sb.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 17 12:05:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxJI4-0005Tv-MO
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 12:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbYEQKEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 06:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbYEQKEH
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 06:04:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:49393 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752634AbYEQKEG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 06:04:06 -0400
Received: (qmail invoked by alias); 17 May 2008 10:04:02 -0000
Received: from R06ea.r.pppool.de (EHLO racer.local) [89.54.6.234]
  by mail.gmx.net (mp014) with SMTP; 17 May 2008 12:04:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/GP+daGRjGt85tAc/QchLnet3MCT0P5aKDsN2R5S
	oc5xY65FFhyWZO
X-X-Sender: gene099@racer
In-Reply-To: <b8bf37780805162030m4c961505nabd72e8f5bd08404@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82339>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-883175977-1211018651=:30431
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 17 May 2008, André Goddard Rosa wrote:

> On Fri, May 16, 2008 at 2:12 PM, Kevin Ballard <kevin@sb.org> wrote:
> > On May 16, 2008, at 6:25 AM, Johannes Schindelin wrote:
> >
> >> On Thu, 15 May 2008, André Goddard Rosa wrote:
> >>
> >>>>> This patch will make git a little more human friendly, reporting
> >>>>> "file.txt: has local changes".
> >>>>
> >>>> Documentation/git-checkout.txt should also change in this case,
> >>>> otherwise users will see different output to that described and
> >>>> possibly get confused if following along with the examples.
> >>>>
> >>>
> >>> I like the idea too.
> >>
> >> No comment on the concern that it might break people's scripts?  None?
> >
> >
> > How about an ugly hack? Look to see if stdout is a tty, if so spit out the
> > more human-readable version, otherwise spit out the old version >:-)
> 
> Is this user interface set on stone? I think we should reserve the right 
> to improve always.

Umm.

As has been mentioned, this is not a "user interface".  The message you 
are seeing comes from a _plumbing_ program, i.e. something _not_ meant for 
human consumption.

I still think that it might be better to add a command line option with a 
custom message, because that would _not_ break backwards-compatibility.

Thankyouverymuch,
Dscho

--8323329-883175977-1211018651=:30431--
