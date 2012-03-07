From: Joern Huxhorn <jhuxhorn@googlemail.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of Pull Requests
Date: Wed, 7 Mar 2012 15:47:08 +0100
Message-ID: <0CBE7FE5-8803-4ECA-A161-6D810D6C128A@googlemail.com>
References: <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino> <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com> <8762eoimp0.fsf@thomas.inf.ethz.ch> <7vmx80nt68.fsf@alter.siamese.dyndns.org> <4F504699.3070406@gmail.com> <20120302041924.GG5248@burratino> <4F505F8C.70802@gmail.com> <7vsjhrfprz.fsf@alter.siamese.dyndns.org> <66B417CA-5F2C-4F6C-BF69-9383CB171C15@googlemail.com> <20120307135314.GB2008@burratino>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Neal Kreitzinger <nkreitzinger@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 15:47:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5I9A-000698-70
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 15:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759032Ab2CGOrP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 09:47:15 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:55824 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758937Ab2CGOrN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 09:47:13 -0500
Received: by wibhm2 with SMTP id hm2so3421980wib.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 06:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=dykD9Oi2/NLmsWpMG2CzulGnzcZg9IYpFat79Ucqcu0=;
        b=ADv2T+R3mZt9ij8ODMz8/ZiHkxGvuWykrs9ko8C9UJUM7OhADUpbCkN2iVP0H4piNS
         xXRT0TnvIhBUCy1JK7U82D4qY79jC5Cg0AJsfmGhDE34vn0/A5Ez+8czOHwjwJQ9XbAc
         2y8Jah06gGDPsKtKGTc0ESTvjD/v9UVgMD4mq0eK02O2F7rNLI4RDLDLiqoMDV07gCLm
         b2BPjRI3Fq4Y65w7OhUMuYhVhK8PPW8nvlfyOssmbI8BilKwN62QQQ6fu0nfCuLo2LYp
         mXbNKr/+8fsKpZeOqDbbIrJQLEz4StNlkwo9jEWAcqyZZE755D8f0HxkbEFERTMlyZ1m
         75Ag==
Received: by 10.216.136.138 with SMTP id w10mr1125634wei.75.1331131631940;
        Wed, 07 Mar 2012 06:47:11 -0800 (PST)
Received: from [192.168.2.113] (p4FF0DC9F.dip.t-dialin.net. [79.240.220.159])
        by mx.google.com with ESMTPS id bg3sm36326599wib.10.2012.03.07.06.47.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Mar 2012 06:47:10 -0800 (PST)
In-Reply-To: <20120307135314.GB2008@burratino>
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192458>


On 07.03.2012, at 14:53, Jonathan Nieder wrote:

> Joern Huxhorn wrote:
>=20
>> To get accepted in this community, an issue tracker would need to be
>> decentralized
>=20
> No, I don't think that's a requirement.
>=20

I didn't mean to imply that this would be a matter of principle. A dece=
ntralized tracker would just offer the same advantages that a decentral=
ized VCS has to offer. One could work on issues while not connected to =
the internet, for example. So this would be a VeryGoodThing=99.

I don't think that it would be a good idea to "teach" git issue tracker=
 functionality. I simply wanted to voice my opinion that something like=
 the ideas Neal suggested down the thread, a cli issue tracker with git=
 in the backend, are very worthwhile to evaluate. But it should have an=
 additional layer so it's really easy to use. It has to be so it *is* a=
ctually used. It needs to reduce workload instead of increasing it.

Cheers,
Joern.