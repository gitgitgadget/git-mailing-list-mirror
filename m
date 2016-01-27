From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 1/2] merge-file: let conflict markers match end-of-line
 style of the context
Date: Wed, 27 Jan 2016 20:12:38 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601272011570.2964@virtualbox>
References: <cover.1453709205.git.johannes.schindelin@gmx.de> <cover.1453819314.git.johannes.schindelin@gmx.de> <13379804ad901b53d78d741156677664924fc50d.1453819314.git.johannes.schindelin@gmx.de> <xmqqoac8ci8o.fsf@gitster.mtv.corp.google.com>
 <xmqqsi1kavr2.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1601270856150.2964@virtualbox> <xmqqio2e996c.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 20:12:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOVWS-0000DT-Q6
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 20:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965507AbcA0TMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 14:12:52 -0500
Received: from mout.gmx.net ([212.227.15.18]:65146 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965443AbcA0TMt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 14:12:49 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MF5FT-1aICv42utP-00GGWM; Wed, 27 Jan 2016 20:12:41
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqio2e996c.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:AB39TlCT1DyfmJhCypMXMVi/iFxRjGd937AyDz0z42RqTfiZFzf
 jC8xZdu3ORQ0fpGTTsGfqtmjk82BLe+3gzBnTVsxW46FcHa0Ea8k3iFHBVTFc2S5Ysw4owK
 GO0jH2tlERr4nhQUKKr51ObKN4ID/yK+07AtG2dvUn3PriAICprtc8ypnR6jeqAHitbaAn4
 GhF69DUgoQFPDs0yDAkBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eqL2AOrhBXI=:c/ydzlA+5noOR2fqfcvBxm
 c8CRHhCAy3s3Zkb+zKUrVVCJQz8eOPx5ODr3CbgmvOyVoqxdr5Ijwvvt/LA3dCG7nFClmC4Sh
 eOFPVCHuhOp3T2HI3KbpelKSF0XQxtQJBVl39LsjPEhl4laqAWmfPuCJQOwDx+41BuJ1KTaLQ
 s73mTJct/w4N4A5U74IPniyBmXupX4m7i39AgKdwuCRWpWZ2B3Uc7OIFoHNjUtYrsuqFWBvhJ
 H1S5nvLnTWhRhmgTiXb/6JO5Rd1cbxIIwLQqRJUcNmNRTYAuZS1zncwzNJaYr9FAoBTQexbck
 VZA639nukmS5SfvccOAYVjOOzVwilhcMliJoFmNzo00+FcgVJPaPwTBtCEyVUdgB5n8RcceQf
 6tuXtjrM7JVgogFZhWmamycxEy9IHv7m41RD0ou+TdziGZudelwlZulytFMkuqnbC73MDDZg3
 dgMVNUOmKSxbH3WipPn4rSNDdeUXYGYA8WviCakoaHG7arsuCoam+Wymrma2DsFTbzNFi1SzD
 Kmk5RCeREhhMezfQpb8SQXWz3mpmj/MHO8oBQ0dM4FqPIfCoH+BSggxMbTNOwcm0e2fOu5nVs
 K+1AeBkgMbLQu5iE28cFEh9dX4mtdZ6YFxrwkClwozZ2G1Gz5SfHVQzDjrjGj/HP4FiLxjW9c
 3qD+JJ/IR6sn37bGL7qSb6fnEya2nrxpF9T65Q7/rHvmEGBAV1vi+gIXAitJskVxFqFx72i63
 G9bxQQgx65OISnlerPpMHW0yt1D1APaX/BQ5N0zJvMWon2VhETz/mqLvHUqsGAWQ+7/8rqLi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284948>

Hi Junio,

On Wed, 27 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Just in case it was unclear, none of the comment above means I want
> >> any part of the patch redone--I am happy with this patch as-is.
> >
> > Thanks for saying that... I was about to try to make things clearer, but I
> > could not think of a better term than "needs_cr".
> 
> I don't, either ;-).
> 
> The primary reason I respond with the "I find this a bit confusing
> but it probably is just me" (not just to this patch) is to give an
> example of a review comment that demonstrates to the others that the
> reviewer understood what is in the patch and the issues around the
> change better than a mere unsubstantiated "These look OK to me.",
> which does not tell us how carefully the proposed change was
> reviewed by the reviewer--such a review does not allow me to "trust
> the review that is already done by others" and apply the patches
> with minimum cursory scanning and I end up having to carefully read
> them myself.

Your response is also an indicator to me that future myself will find the
same code just as confusing as you did, though.

Maybe need_cr -> eol_is_crlf?

Ciao,
Dscho
