From: Ted Ts'o <tytso@mit.edu>
Subject: Re: Lack of detached signatures
Date: Thu, 29 Sep 2011 09:18:45 -0400
Message-ID: <20110929131845.GQ19250@thunk.org>
References: <CAMOZ1Bs2HW6e3V6sayVSm0NhC=0e5129ZR8YSGuZPnJw9H9TEA@mail.gmail.com>
 <4B2793BF110AAB47AB0EE7B90897038516F63A7C@ORSMSX101.amr.corp.intel.com>
 <1317195719.30267.4.camel@bee.lab.cmartin.tk>
 <alpine.LNX.2.00.1109280555460.25187@bruno>
 <7v1uv01uqm.fsf@alter.siamese.dyndns.org>
 <20110928222542.GA18120@sigill.intra.peff.net>
 <20110928230958.GJ19250@thunk.org>
 <7vd3ekxkca.fsf@alter.siamese.dyndns.org>
 <20110929015919.GL19250@thunk.org>
 <7vbou4uhuu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Joseph Parmelee <jparmele@wildbear.com>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	"Olsen, Alan R" <alan.r.olsen@intel.com>,
	Michael Witten <mfwitten@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 29 15:19:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9GW6-0001JH-TQ
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 15:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834Ab1I2NTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 09:19:05 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:39961 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408Ab1I2NTD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 09:19:03 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1R9GVi-0002qE-7L; Thu, 29 Sep 2011 13:18:46 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1R9GVh-0003SF-2y; Thu, 29 Sep 2011 09:18:45 -0400
Content-Disposition: inline
In-Reply-To: <7vbou4uhuu.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182396>

On Wed, Sep 28, 2011 at 08:50:49PM -0700, Junio C Hamano wrote:
> 
> I was actually more worried about helping consumers convince themselves
> that thusly signed keys indeed belong to producers like Linus, Peter,
> etc. There are those who worry that DNS record to code.google.com/ for
> them may point at an evil place to give them rogue download material.
> "Here are the keys you can verify our trees with" message on the mailing
> list, even with the message is signed with GPG, would not be satisfactory
> to them.

What do you mean by "consumers" in this context?  Most end users don't
actually download tarballs from www.kernel.org or code.google.com!  :-)

If you mean developers at Linux distributions Red Hat, SuSE, or
Handset manufacturers such as Samsung, HTC, Motorola, etc., there will
be many of those reprsenatives at LinuxCon Europe and CELF (Consumer
Electronics Linux Forum) Europe conferences, which will be colocated
with the Kernel Summit in Prague.

If you are thinking of random developers located in far-flung places
of the world who don't have any contact with other Linux developers,
this is a previously unsolved problem.  There are links into the
developing Kernel GPG tree that are signed by the GPG web trust used
by Debian, OpenSuSE, and (soon) Fedora.  Given that people generally
have to trust one or more of those web of trusts, that's the best we
can do, at least as far as I know.  If you can suggest something
better, please let me know!


						- Ted
