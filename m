From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing objects'
Date: Fri, 19 Oct 2007 13:44:56 +0200
Message-ID: <B51EC920-D767-4192-AB25-685201B93CC9@wincent.com>
References: <20071019004527.GA12930@spearce.org> <20071019021255.GD3290@coredump.intra.peff.net> <20071019022154.GY14735@spearce.org> <alpine.LFD.0.9999.0710182247130.19446@xanadu.home> <20071019031737.GD14735@spearce.org> <alpine.LFD.0.9999.0710182328580.19446@xanadu.home> <20071019034501.GG14735@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 13:46:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiqJA-0003V9-0F
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 13:46:28 +0200
Received: from mail-mx6.uio.no ([129.240.10.47])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IiqJ0-0002qh-Ux
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 13:46:19 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx6.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IiqIs-0007KJ-BN
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 13:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277AbXJSLpy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Oct 2007 07:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755872AbXJSLpy
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 07:45:54 -0400
Received: from wincent.com ([72.3.236.74]:59120 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755277AbXJSLpx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Oct 2007 07:45:53 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l9JBjZbW018504;
	Fri, 19 Oct 2007 06:45:36 -0500
In-Reply-To: <20071019034501.GG14735@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.5, required=12.0, autolearn=disabled, AWL=3.500,RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: F8985B0CB22F753260E0CD54D6DC0A2661FD7FE1
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -34 maxlevel 200 minaction 2 bait 0 mail/h: 118 total 622653 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61692>

El 19/10/2007, a las 5:45, Shawn O. Pearce escribi=F3:

> Nicolas Pitre <nico@cam.org> wrote:
>>
>> And imagine that you see the progress moving slowly because the =20
>> remote
>> server is a NSLU2, but it says 80%.  Then you go for a coffee and th=
e
>> progress says 20% when you return because it now has moved to a
>> different phase.  Rather counter intuitive.
>
> Yea, I didn't consider that.  That's where you need to show the
> number of steps and which one you are on, so the meter looks
> more like:
>
> 	Step 1/3: Counting objects: .... \r
> 	Step 2/4: Compressing objects: ... \r
> 	Step 3/3: Writing objects: .... \r
>
> only all smashed into one line of course, so only the most recent
> one is being displayed.

Looks good, although as Nicholas pointed out you might not know in =20
advanced how many steps there are.

So I still think that Nicholas' original point is valid is here, and =20
if you overwrite old progress bars with new ones then you may falsely =20
give the impression of "going backwards".

Cheers,
Wincent
