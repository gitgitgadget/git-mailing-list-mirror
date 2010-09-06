From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Mon, 06 Sep 2010 19:57:43 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009061942150.19366@xanadu.home>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
 <7voccezr7m.fsf@alter.siamese.dyndns.org> <20100903183120.GA4887@thunk.org>
 <alpine.LFD.2.00.1009031522590.19366@xanadu.home>
 <AANLkTi=sC3NMNzPRQM5RKwnZQyRq-gq6+7wdiT5LGDrc@mail.gmail.com>
 <AANLkTinoyehduhdHSEm5yGTLvU6C-ViE885yLd63iQU0@mail.gmail.com>
 <4C81A67B.2060400@gmail.com> <alpine.LFD.2.00.1009032304560.19366@xanadu.home>
 <4C81DC34.2090800@gmail.com> <alpine.LFD.2.00.1009040153280.19366@xanadu.home>
 <AANLkTi=7jUSCNiPf+HfEQuxaf16Jt06--bFE7=Of9wp=@mail.gmail.com>
 <AANLkTik9awEd40s3r-O8t9DwZBh34Z0ozsxMm1QNjNoT@mail.gmail.com>
 <alpine.LFD.2.00.1009042132500.19366@xanadu.home>
 <AANLkTi=YLx6MqbWd_N0geXbuXLdqAUOneGoym75dfthL@mail.gmail.com>
 <alpine.LFD.2.00.1009051820100.19366@xanadu.home>
 <AANLkTi=CEOj40Sj+zegvX+ry8-y6p7UwsyqdtoHB1d-T@mail.gmail.com>
 <alpine.LFD.2.00.1009061025210.19366@xanadu.home>
 <7v8w3etpjr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 01:58:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OslZn-0007F9-J3
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 01:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136Ab0IFX6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 19:58:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:59919 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042Ab0IFX6J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 19:58:09 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L8C00MOSNW51S40@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 06 Sep 2010 19:57:41 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v8w3etpjr.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155647>

On Mon, 6 Sep 2010, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> >> * enumerate the list of objects associated with an individual commit by:
> >>     i) creating a CUSTOM pack+idx using git pack-objects {ref}
> >>     ii) *parsing* the idx file using gitdb's FileIndex to get the list
> >> of objects
> >
> > That's where you're going so much out of your way to give you trouble.  
> > A simple rev-list would give you that list:
> >
> > 	git rev-list --objects <this_commit> --not <this_commit''s_parents>
> >
> > That's it.
> 
> I didn't want to get into this discussion, but where in the above picture
> does the usual "want/ack" exchange fit?

Before object enumeration obviously.  But I think that Luke has enough 
to play with already by only assuming the easy case for now.  If Git P2P 
is to be viable, it has to prove itself at least with the easy case 
first.


Nicolas
