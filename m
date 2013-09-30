From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Local tag killer
Date: Mon, 30 Sep 2013 18:44:09 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309301839080.6331@syhkavp.arg>
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
 <alpine.LFD.2.03.1309301527270.6331@syhkavp.arg> <5249E9C8.1070700@xiplink.com>
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
X-From: git-owner@vger.kernel.org Tue Oct 01 00:44:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQmCN-0005PZ-MD
	for gcvg-git-2@plane.gmane.org; Tue, 01 Oct 2013 00:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559Ab3I3WoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Sep 2013 18:44:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24097 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754789Ab3I3WoK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Sep 2013 18:44:10 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MTY00EHON5L7C90@VL-VM-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 30 Sep 2013 18:44:10 -0400 (EDT)
In-reply-to: <5249E9C8.1070700@xiplink.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235633>

On Mon, 30 Sep 2013, Marc Branchaud wrote:

> On 13-09-30 04:08 PM, Nicolas Pitre wrote:
> > Again, in the cases where there is actually a SHA1 conflict between all 
> > possible tags that match a tag short-end then listing them and asking the 
> > user to be more explicit is the right thing to do.  But that should be a 
> > very rare case in practice, and designing for making this case easy is 
> > the wrong approach.
> > 
> > Instead, the common case of multiple remotes with duplicated tag names 
> > referring to the same thing _and/or_ multiple remotes with distinct tags 
> > names is what should be made easy to use with no extra steps.
> 
> Again, I don't think that's the common case.  I think it's just as likely for
> there to be multiple remotes with duplicate tag names that refer to different
> objects.

Why do you say so?  I'm curious to know what kind of work flow would do 
that in practice.

At least for typical Linux kernel workflows what I said above is true.


Nicolas
