From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git push (mis ?)behavior
Date: Wed, 3 Oct 2007 13:22:15 +0200
Message-ID: <3F8729D3-CC5E-478A-80E0-C199C7A1770C@wincent.com>
References: <20070927130447.GH10289@artemis.corp> <7v3awzvrpr.fsf@gitster.siamese.dyndns.org> <buoprzwn5qm.fsf@dhapc248.dev.necel.com> <20071003073554.GA8110@artemis.corp> <buobqbgmv6z.fsf@dhapc248.dev.necel.com> <83C5420A-528A-43F0-AF8C-699B85B7AD95@wincent.com> <20071003104943.GA3017@diana.vm.bytemark.co.uk> <7v8x6kfobq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	Miles Bader <miles@gnu.org>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 13:23:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id2Jm-0001Je-Cp
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 13:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755778AbXJCLWd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2007 07:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755599AbXJCLWc
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 07:22:32 -0400
Received: from wincent.com ([72.3.236.74]:47056 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755605AbXJCLWb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Oct 2007 07:22:31 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l93BMIgR016369;
	Wed, 3 Oct 2007 06:22:19 -0500
In-Reply-To: <7v8x6kfobq.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59825>

El 3/10/2007, a las 13:08, Junio C Hamano escribi=F3:

> Also mistakes can cut both ways.  Pushing out what you did not
> intend to is what you seem to be worried about more.  But not
> pushing out enough and not noticing is an equally bad mistake.

I don't think they're of the same order. If you mistakenly push out =20
too little you can easily correct it by pushing again. But what do =20
you do if you push out too much? How do you fix that?

> You, an expert, will get asked for help by somebody, walk up to
> his shell prompt, and try to help and teach him by showing you
> type, and then you suddenly notice the command does not work as
> you expect because he set the default differently (because he
> read that configuration option on some web parge).  And we will
> be in such a cumbersome to diagnose situation _very_ often if we
> have per-user default on many things.

True, true.

Cheers,
Wincent
