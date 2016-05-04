From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] bisect--helper: use OPT_CMDMODE instead of
 OPT_BOOL
Date: Wed, 4 May 2016 13:05:37 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605041304050.9313@virtualbox>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com> <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com> <1462338472-3581-2-git-send-email-pranit.bauva@gmail.com> <CAPig+cQxpZXKqykFoa2kzCZSC2YqpPXnGocs2YttcJ+rCxmzgQ@mail.gmail.com>
 <CAP8UFD1+kEwFhAoveOTYt8NEOK=98W-00nNF+Yoe6kQAYJa6SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	christian.couder@gmail.com,
	Lars Schneider <larsxschneider@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 13:06:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axucy-000439-KJ
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 13:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757752AbcEDLFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 07:05:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:50042 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757708AbcEDLFq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 07:05:46 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MYwQh-1bBKeP3lS7-00Vj4A; Wed, 04 May 2016 13:05:39
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAP8UFD1+kEwFhAoveOTYt8NEOK=98W-00nNF+Yoe6kQAYJa6SQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:GMUx89y26ZlIPIy2VrvA8guG836Y93q83kludkBSUmVJKrv74zd
 wb4iDgPLEEfarOT5xahl38uWXknulM2/+wOdiUq2Behh92/x4VqvHpTrhyx+0Yl9UdyA/3X
 UgXURC6S3TjNhng+WLB5lXf0m8KymQdWgzYEyD+RAAc4Aaexs0wA8jkaIbXDsES1+D2VTMC
 KmjtW427Pw0EBdHDl2hnA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Mfi+lj6P7ZA=:y7PZfUtm1X0sxpKV97rXCq
 RQZCJ8Rfrb9DKsRiWz7/smvx5Q1RNNtnBb4kN7SdphQ/fpxbX+SFATcUAre/IYfwh2ttHWAIS
 /FOkENdy8nAAyBDj+8A9mMMLoLjREjKYpYO+1i3cur7Oyl5PPOKb3l6MMGlvdzeO9GK0toVfw
 xFn1lmkc10aK1jPhMEXOivFwKF6w2V8Qv0msD35UO9YijjFIBNS+JTXO559coJdg+e5lm4GY5
 QRwN7DJiyPRLmmu+TufNaNxWjqg8YArvDxLx7gEX85qZ6Y29V1NsvQCnRxa+Wy0jxMYCxlCh6
 Upg1cqET4xsO7BlXMS83ZgwXS6BkICTA1h73RVyGvBewtN64n3qA8c6mJCwYFmWxNr/YMnyVy
 xfS4QicihmO6UjRukHcCf0pDGXQQTHUVX47y7pFxYYa+zeho9MO1/CgQ/HEljTXMycOUTzIjs
 Lp9V/KX6QakEpvVsnFXKjr65oc2Mx736cDhsPrLZRudRn/yHoq/xSsNlbQsKcMHOO9Gu/ZvU2
 5LbXlcq7w5IS8k6vrmnPvuT5AWOE5ZO4WmvXRdSUL88aOda8FeLZnqNBwtYBzSJLq/HWdRcpr
 ysWs9C3KdT+RWxPi7h33TKuGYN9A/N6QQyvnIGaXtx5tyNMSEMxQk5lwHKLCeMYBGtWyWTQrV
 K1odqxykzv44QoHvUwV7wcMMadVeGg0fRtEUfZyhND4emqjmID+PnQzmQv30JfUBs+LAaAIfj
 kH2pB8R1dg0xN+fOY7vx5kWmDmXuykj0G6/eX6R4HUy3dri14AlCkNR08GyuqgwiUYJ7rO7M 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293532>

Hi Christian,

On Wed, 4 May 2016, Christian Couder wrote:

> On Wed, May 4, 2016 at 8:07 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Wed, May 4, 2016 at 1:07 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> >> bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
> >
> > This subject is too low-level, talking about implementation details,
> > whereas it should be giving a high-level summary of the change.
> 
> When a patch is all about a low level detail, I think it is good to
> talk about the detail in the subject.

Well, this is not the case here. The intent of this commit is to prepare
for other command modes.

So... why not just say "bisect--helper: prepare for modes other than
'next-all'"?

Ciao,
Dscho
