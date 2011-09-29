From: Joseph Parmelee <jparmele@wildbear.com>
Subject: Re: Lack of detached signatures
Date: Thu, 29 Sep 2011 10:47:30 -0600 (CST)
Message-ID: <alpine.LNX.2.00.1109291013220.29373@bruno>
References: <CAMOZ1Bs2HW6e3V6sayVSm0NhC=0e5129ZR8YSGuZPnJw9H9TEA@mail.gmail.com> <4B2793BF110AAB47AB0EE7B90897038516F63A7C@ORSMSX101.amr.corp.intel.com> <1317195719.30267.4.camel@bee.lab.cmartin.tk> <alpine.LNX.2.00.1109280555460.25187@bruno>
 <7v1uv01uqm.fsf@alter.siamese.dyndns.org> <20110928222542.GA18120@sigill.intra.peff.net> <20110928230958.GJ19250@thunk.org> <7vd3ekxkca.fsf@alter.siamese.dyndns.org> <20110929015919.GL19250@thunk.org> <7vbou4uhuu.fsf@alter.siamese.dyndns.org>
 <20110929131845.GQ19250@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	"Olsen, Alan R" <alan.r.olsen@intel.com>,
	Michael Witten <mfwitten@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Sep 29 18:47:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Jlq-0008EY-CC
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 18:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861Ab1I2Qrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 12:47:33 -0400
Received: from ip205-30-10-190.ct.co.cr ([190.10.30.205]:51543 "EHLO
	bruno.wildbear.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754201Ab1I2Qrc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 12:47:32 -0400
Received: by bruno.wildbear.com (Postfix, from userid 503)
	id 38DED1BE02A4; Thu, 29 Sep 2011 10:47:31 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by bruno.wildbear.com (Postfix) with ESMTP id 1CC291BE029D;
	Thu, 29 Sep 2011 10:47:31 -0600 (CST)
X-X-Sender: jparmele@bruno
In-Reply-To: <20110929131845.GQ19250@thunk.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182412>




On Thu, 29 Sep 2011, Ted Ts'o wrote:

> On Wed, Sep 28, 2011 at 08:50:49PM -0700, Junio C Hamano wrote:
>>
>> I was actually more worried about helping consumers convince themselves
>> that thusly signed keys indeed belong to producers like Linus, Peter,
>> etc. There are those who worry that DNS record to code.google.com/ for
>> them may point at an evil place to give them rogue download material.
>> "Here are the keys you can verify our trees with" message on the mailing
>> list, even with the message is signed with GPG, would not be satisfactory
>> to them.
>
> What do you mean by "consumers" in this context?  Most end users don't
> actually download tarballs from www.kernel.org or code.google.com!  :-)
>
> If you mean developers at Linux distributions Red Hat, SuSE, or
> Handset manufacturers such as Samsung, HTC, Motorola, etc., there will
> be many of those reprsenatives at LinuxCon Europe and CELF (Consumer
> Electronics Linux Forum) Europe conferences, which will be colocated
> with the Kernel Summit in Prague.
>
> If you are thinking of random developers located in far-flung places
> of the world who don't have any contact with other Linux developers,
> this is a previously unsolved problem.  There are links into the
> developing Kernel GPG tree that are signed by the GPG web trust used
> by Debian, OpenSuSE, and (soon) Fedora.  Given that people generally
> have to trust one or more of those web of trusts, that's the best we
> can do, at least as far as I know.  If you can suggest something
> better, please let me know!
>
>
> 						- Ted
>

Also included is distro developers that gen custom distros for limited
corporate use on specific hardware, and anyone else that is sufficiently
concerned about security and/or survivability that they prefer/need to build
from the upstream source.

As far as accepting public keys, a key obtained from the key servers and
signed by others, while not perfect, is vastly superior to nothing at all. 
I am located in the mountains of Costa Rica.  Over the years I have
collected a fair number of public keys making it very difficult for bad guys
to fake both a public key and all the signatures too, even though I can't
travel to a "key signing party" which would of course be better.

Even if we have to change all the keys now its going to be risky but still
vastly better than nothing.  I would hope that a new key would be signed by
an existing valid private key as well as newly issued keys.  This would
reassure people like me who have a substantial stash of old but valid public
keys, while at the same time thwarting bad guys who can fake only those old
signatures for which they have stolen valid private keys.

Joseph
