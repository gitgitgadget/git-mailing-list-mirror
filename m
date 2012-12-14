From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: Re: possible Improving diff algoritm
Date: Fri, 14 Dec 2012 23:29:38 +0100
Message-ID: <20121214222938.GB19410@client.brlink.eu>
References: <CAO54GHC4AXQO1MbU2qXMdcDO5mtUFhrXfXND5evc93kQhNfCrw@mail.gmail.com>
 <CAO54GHD3C2RKUvE5jK_XOCVbbDuE_c5xfe28rOL+DaE5anL-Wg@mail.gmail.com>
 <7vvcc73yzh.fsf@alter.siamese.dyndns.org>
 <CANv4PNm45xGBn2veKi1o0wB4K9NgsbtCsiymHNO4xbCDpJ5tDg@mail.gmail.com>
 <7vpq2f2az4.fsf@alter.siamese.dyndns.org>
 <CANv4PNnC1J54TSpHuBOpY=rbuU_naysYkmoyi=utNF0vWK1CnA@mail.gmail.com>
 <B1564B28-9BB9-48A2-B59E-7D7C0B0DDECF@adacore.com>
 <7vzk1izcv6.fsf@alter.siamese.dyndns.org>
 <CALZVap=r0toqWT7aJxiKtezmR8s4QDd0x92JX-eBLWhKaJsmOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Geert Bosch <bosch@adacore.com>,
	Morten Welinder <mwelinder@gmail.com>, Kevin <ikke@ikke.info>,
	git <git@vger.kernel.org>
To: Javier Domingo <javierdo1@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 23:53:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tje7o-0007EO-Hj
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 23:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591Ab2LNWwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 17:52:43 -0500
Received: from server.brlink.eu ([78.46.187.186]:47611 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932173Ab2LNWwm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 17:52:42 -0500
X-Greylist: delayed 1374 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Dec 2012 17:52:42 EST
Received: from client.brlink.eu 
	by server.brlink.eu with esmtpsa (tls-peer-hash KfHJgA)
	id 1TjdlG-0002L4-Eq; Fri, 14 Dec 2012 23:29:42 +0100
Received: with local; Fri, 14 Dec 2012 23:29:41 +0100
Content-Disposition: inline
In-Reply-To: <CALZVap=r0toqWT7aJxiKtezmR8s4QDd0x92JX-eBLWhKaJsmOw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211510>

* Javier Domingo <javierdo1@gmail.com> [121214 13:20]:
> I think the idea of being preferable to have a blank line at the end
> of the added/deleted block is key in this case.

For symmetry I'd suggest to make it preferable to have blank lines
at the end or the beginning.

  {
  old
+ }
+
+ {
+ new
  }

vs

  {
  old
  }
+
+ {
+ new
+ }

is just the same case in blue.
(Although empty lines alone feels not quite optimal, it is at least a
good start).

        Bernhard R. Link
