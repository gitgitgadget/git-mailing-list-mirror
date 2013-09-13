From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Re-Transmission of blobs?
Date: Fri, 13 Sep 2013 07:51:58 -0400
Organization: PD Inc
Message-ID: <43FBD2453ED7483F9EEB5B0D43C02C54@porsche>
References: <20130910130837.GA14259@raven.wolf.lan> <xmqqsixcy395.fsf@gitster.dls.corp.google.com> <20130911112758.GB14259@raven.wolf.lan> <xmqqsixbth4h.fsf@gitster.dls.corp.google.com> <20130912074241.GC14259@raven.wolf.lan> <20130912092339.GA30702@sigill.intra.peff.net> <871B6C10EBEFE342A772D1159D132085571A7A1B@umechphj.easf.csd.disa.mil> <20130912195654.GE32069@sigill.intra.peff.net> <871B6C10EBEFE342A772D1159D132085571A7E5C@umechphj.easf.csd.disa.mil> <20130913102316.GF14259@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Josef Wolf'" <jw@raven.inka.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 13 13:52:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKRuy-00088I-Km
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 13:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491Ab3IMLwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 07:52:05 -0400
Received: from projects.pdinc.us ([67.90.184.26]:44944 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752346Ab3IMLwD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 07:52:03 -0400
Received: from porsche (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id r8DBpwTg004958;
	Fri, 13 Sep 2013 07:51:58 -0400
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Ac6wbEFeK1fpUUH0QKOSwAHOi5fxFwACo4pA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
In-Reply-To: <20130913102316.GF14259@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234747>

> -----Original Message-----
> From: Josef Wolf
> Sent: Friday, September 13, 2013 6:23
> 
> On Thu, Sep 12, 2013 at 08:06:35PM +0000, Pyeron, Jason J CTR 
> (US) wrote:
> 
> > Yes, but it is those awfully slow connections (slower that 
> the looping
> > issue) which happen to always drop while cloning from our 
> office. And 
> > the round trip should be mitigated by http-keep-alives.
> [ ... ]
> > But, again if the connection drops, we have already lost the delta 
> > advantage. I would think the scenario would go like this:
> > 
> > git clone url://blah/blah
> > [fail]
> > cd blah
> > git clone --resume #uses normal methods....

I am using the mythical --resume, where it would fetch packs and indexes.

> > [fail]
> > while ! git clone --resume --HitItWithAStick
> > 
> > replace clone with fetch for that use case too
> 
> Last time I checked, cloning could not be resumed:
> 
> http://git.661346.n2.nabble.com/git-clone-and-unreliable-links-td7570652.html
> 
> If you're on a slow/unreliable link, you've lost.


That is kind of the point. It should be possible.


--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.

 
