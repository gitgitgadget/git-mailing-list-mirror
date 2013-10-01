From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Local tag killer
Date: Mon, 30 Sep 2013 23:28:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309302323190.6331@syhkavp.arg>
References: <52327E62.2040301@alum.mit.edu>
 <CAPc5daXvCf90WYoUWC+DxRyZEQhXGL7Bd_ZJKwfoqxeKt8TADQ@mail.gmail.com>
 <xmqqd2o3p0nk.fsf@gitster.dls.corp.google.com> <523D3FD2.4090002@alum.mit.edu>
 <20130924075119.GD7257@sigill.intra.peff.net>
 <alpine.LFD.2.03.1309251834210.312@syhkavp.arg>
 <5246C975.1050504@alum.mit.edu>
 <CALKQrgeJn1J4ntE_2Lr7Et+Oao=vB1FE6nLfaFJOvLHJLzG9tA@mail.gmail.com>
 <5247ACB9.40208@alum.mit.edu> <52499797.9030100@xiplink.com>
 <alpine.LFD.2.03.1309301138200.6331@syhkavp.arg>
 <5249CDF7.4050904@xiplink.com>
 <alpine.LFD.2.03.1309301527270.6331@syhkavp.arg>
 <5249E9C8.1070700@xiplink.com>
 <alpine.LFD.2.03.1309301839080.6331@syhkavp.arg> <524A3BB6.9060808@xiplink.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	=?ISO-8859-15?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Oct 01 05:28:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQqdJ-00037U-Eb
	for gcvg-git-2@plane.gmane.org; Tue, 01 Oct 2013 05:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755828Ab3JAD2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Sep 2013 23:28:17 -0400
Received: from relais.videotron.ca ([24.201.245.36]:51782 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755489Ab3JAD2R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Sep 2013 23:28:17 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MTZ00GCJ0B4ZW50@VL-VM-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 30 Sep 2013 23:28:16 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 6108E2DA00F0; Mon, 30 Sep 2013 23:28:16 -0400 (EDT)
In-reply-to: <524A3BB6.9060808@xiplink.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235639>

On Mon, 30 Sep 2013, Marc Branchaud wrote:

> On 13-09-30 06:44 PM, Nicolas Pitre wrote:
> > On Mon, 30 Sep 2013, Marc Branchaud wrote:
> > 
> > > On 13-09-30 04:08 PM, Nicolas Pitre wrote:
> > > > Again, in the cases where there is actually a SHA1 conflict between all
> > > > possible tags that match a tag short-end then listing them and asking
> > > > the
> > > > user to be more explicit is the right thing to do.  But that should be a
> > > > very rare case in practice, and designing for making this case easy is
> > > > the wrong approach.
> > > > 
> > > > Instead, the common case of multiple remotes with duplicated tag names
> > > > referring to the same thing _and/or_ multiple remotes with distinct tags
> > > > names is what should be made easy to use with no extra steps.
> > > 
> > > Again, I don't think that's the common case.  I think it's just as likely
> > > for
> > > there to be multiple remotes with duplicate tag names that refer to
> > > different
> > > objects.
> > 
> > Why do you say so?  I'm curious to know what kind of work flow would do
> > that in practice.
> 
> The use case I have in mind is where a project makes use of other projects,
> for example an application that uses some libraries.  The application's
> repository could contain the full histories of the libraries, each
> subtree-merged into a different directory.
> 
> So maybe that's not so common these days, but the current flat tag namespace
> makes it pretty much impractical.

But with my proposal, you'd get a message saying that the tag "baz" is 
ambigous, and that you'd have to use either "libfoo/baz" or 
"libbar/baz".

The current flat namespace makes many things virtually impractical 
indeed, even with the kernel workflow I described.


Nicolas
