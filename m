From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: wishlist: make it possible to amend commit messages after push to
 remote
Date: Fri, 07 Aug 2015 21:38:27 +0200
Organization: gmx
Message-ID: <a0b9f82a46f2887d3ff3fb392e2e4c2c@www.dscho.org>
References: <55C3FA66.90805@iki.fi>
 <xmqqd1yzyqzq.fsf@gitster.dls.corp.google.com> <55C4E67F.7050109@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: jhi@iki.fi
X-From: git-owner@vger.kernel.org Fri Aug 07 21:38:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNnTT-0007kF-IJ
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 21:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946028AbbHGTif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 15:38:35 -0400
Received: from mout.gmx.net ([212.227.15.15]:65034 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753198AbbHGTie (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 15:38:34 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MId0S-1ZPzKg3NeK-002Hjo; Fri, 07 Aug 2015 21:38:30
 +0200
In-Reply-To: <55C4E67F.7050109@iki.fi>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:b/2Zu1vjBYGYLqhZbwSubUrshYy23ONaIm/60NodI7nNxI3thBw
 sqECn7RmisWAY0ztBeKHE+9vuoTe1lo61BE177b5qaRK7qT1CRwTqhTo74w4QEH8CR/xz6O
 2h0Ec/iq8oe8pq3nFFxOWQhk7zU0ZBidfoAUAzOUPmflwASuiHkHXIfECR+NlaTOBJEFBLT
 3AcMpceyhmA6Rm4Yi4iqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0ofe5GFhFaA=:8mQHoknWXpgvkTutYwmIt2
 m5sWW1SWheucsEjltXz89j6i2isK+AqjjBF2QbpZL8yAK5UrwbzxC5iiqHGV5UTFfLbdgY+ry
 S1MySsXBsirKbRWI/DZtXyb9Wbf1EfSbeFknoXb2b1MKPgC+ngixYf4wHjzLYfRnq7YAivePj
 Un0PeY7gh1ZOoRyC0XSD6MRdumRfFQ7CC1ytuoG6uv5ruTuS++BpdBmEMNcGYjo3oRot1Po3Y
 z9E2uxNkoVjCT3pWmucTN4VwqfpXt/4zH9UVcuvCUap65Md5+7eCYqdxqeFxamJRCAmsVy5Zz
 ZEuDHDDX8dKz1cDBABnabGNQDwJIi7GQZFSH3LoRPpRJWKA1LiADk+aSDeTREb/I7IMqwWOUx
 Xyx5lslvOJcpD+i942BXt0ag0eHmlGOlKHX35Q5iorIqVPF2s1xXVdLZsdH90D/kNdHZfZ+Ef
 0mHlEiSmkdWsPL999HiqyFyOCkQi/LP6kRm2a6BKGuaQ9VBLQ3S6TAxww7HZLL7PqeZsgu1jm
 wlJrHN18yTCCtqyiJNnZhWBARsX/Rg5s2PqoUJgenUE8JaNnbVQHvuYPjdVci+rNICee8Fqdf
 LfsnYn2vVN7vUXvwR5DdGaOTm+v/nbIfF1K1VeVXBdTkJXs36RXie6sniBn6pbOM47Lp5m3Fr
 erSN1ayhNWOjExr3dXq5bxvtsCUZhDIg7aPRGKey44+v20XgqwdNYhX17WKtpCR5J+ULVdZO5
 RpzQsjSBTAyb3l2kM+RRf5LyNYJZi2Umk9ybOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275481>

Hi,

On 2015-08-07 19:10, Jarkko Hietaniemi wrote:

> But to be honest, I wasn't expecting a miracle cure.  I guess the core
> of my gripe is just that: how the commit message is part of the SHA.

The commit message is not "part of the SHA" but it is part of the content that defines the SHA-1.

I guess in your case, you would rather have an empty commit message and attach the real message as a commit note.

Speaking for myself, I actually like it that the entire metadata is part of the commit object, even the commit message. It makes the whole thing more reliable: one cannot claim that the commit does one thing on one day, and the next day all of a sudden claim that the commit does something completely different. Git's just really consistent the way it is.

Ciao,
Johannes
