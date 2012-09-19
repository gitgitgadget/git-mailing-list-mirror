From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] Documentation/git-blame.txt: --follow is a NO-OP
Date: Wed, 19 Sep 2012 14:09:25 -0700
Message-ID: <819C66A4-390B-4C29-86BD-D4CB4DB43385@sb.org>
References: <20120906151317.GB7407@sigill.intra.peff.net>
 <1348022905-10048-1-git-send-email-n1xim.email@gmail.com>
 <7v627aiq47.fsf@alter.siamese.dyndns.org>
 <20120919182715.GF11699@sigill.intra.peff.net>
 <7vzk4lg5yf.fsf@alter.siamese.dyndns.org>
 <20120919194213.GB21950@sigill.intra.peff.net>
 <C07F05AC-8FBF-4F09-AF13-A291181A06D9@sb.org>
 <20120919203738.GA24383@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Drew Northup <n1xim.email@gmail.com>,
	gitList list <git@vger.kernel.org>, Matthieu.Moy@imag.fr,
	andy@aeruder.net, chriscool@tuxfamily.org,
	dmellor@whistlingcat.com, dpmcgee@gmail.com, fonseca@diku.dk,
	marius@trolltech.com, namhyung@gmail.com,
	rene.scharfe@lsrfire.ath.cx, s-beyer@gmx.net, trast@inf.ethz.ch
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 19 23:10:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TERXs-0000qb-Ve
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 23:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947Ab2ISVKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 17:10:46 -0400
Received: from mail-out.apple.com ([17.151.62.50]:45434 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab2ISVKp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 17:10:45 -0400
X-Greylist: delayed 1975 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Sep 2012 17:10:45 EDT
Received: from relay14.apple.com ([17.128.113.52])
 by mail-out.apple.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTPS id <0MAM00K19847Q400@mail-out.apple.com> for git@vger.kernel.org;
 Wed, 19 Sep 2012 14:10:45 -0700 (PDT)
X-AuditID: 11807134-b7f8e6d000003fa4-c8-505a34873373
Received: from kencur (kencur.apple.com [17.151.62.38])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay14.apple.com (Apple SCV relay)
 with SMTP id A2.E7.16292.7843A505; Wed, 19 Sep 2012 14:09:27 -0700 (PDT)
Received: from il0103a-dhcp80.apple.com
 (il0103a-dhcp80.apple.com [17.201.37.208])
 by kencur.apple.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPSA id <0MAM00H7683PKG90@kencur.apple.com> for git@vger.kernel.org;
 Wed, 19 Sep 2012 14:09:27 -0700 (PDT)
In-reply-to: <20120919203738.GA24383@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1498)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsUiON1OTfeqSVSAweZ+XouuK91MDowenzfJ
	BTBGcdmkpOZklqUW6dslcGVsed/AWvCCs+LczNmMDYyv2bsYOTkkBEwkTq3bAWWLSVy4t56t
	i5GLQ0ignUmi99QaFpCEkMBeJomDk8CKmAW0JNbvPM4EYvMK6Enc/rkMzBYWcJX4+2I3WA2b
	gJLEvQlLwOKcAtYSf/oWM4PYLAKqEqeW9LCDLGAWeMQksenxIaih8hKb17xlhhhqKXFj8j5m
	iCsmMEs83QyxWURAVuL74Y2MEKfKStx78ZttAqPALCRHzUJy1CwkcxcwMq9iFCxKzUmsNDTR
	SywoyEnVS87P3cQICr6GQpMdjAd/8h9iFOBgVOLhNRKLChBiTSwrrsw9xCjBwawkwvtjb2SA
	EG9KYmVValF+fFFpTmrxIUZpDhYlcV4RAaBqgfTEktTs1NSC1CKYLBMHp1QDo9PRXS05i25N
	KfGe8/LhlScxH2+dcVLynrMuLv7jhQOK+UX+Gybda36rwajac1rRLsyy2mbVPZUfMb+zdnEL
	XStOm9jLN3XjsSweQYbYqOpppbWPNcx9uu4/eb4myYK90+luReem30de8E87a50QftVRgXu2
	3rzcaauUF78PWMPAfm4yG59GnRJLcUaioRZzUXEiAC1PMdw6AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206001>

On Sep 19, 2012, at 1:37 PM, Jeff King <peff@peff.net> wrote:

> On Wed, Sep 19, 2012 at 01:31:50PM -0700, Kevin Ballard wrote:
> 
>>> I am a little lukewarm on my patch if only because of the precedent it
>>> sets.  There are a trillion options that revision.c parses that are not
>>> necessarily meaningful or implemented for sub-commands that piggy-back
>>> on its option parser. I'm not sure we want to get into manually
>>> detecting and disallowing each one in every caller.
>> 
>> I tend to agree with your final sentiment there. But the point that
>> users may not realize that blame already follows is also valid. Perhaps
>> we should catch --follow, as in your patch, but instead of saying that
>> it's an unknown argument, just print out a helpful message saying blame
>> already follows renames (and then continue with the blame anyway, so
>> as to not set a precedent to abort on unknown-but-currently-accepted
>> flags).
> 
> Sure, that would probably make sense. Care to roll a patch with
> suggested wording?

Sadly, no. I'm not in a position to contribute to GPL code anymore, based
on my current job (I'd have to jump through some hoops to get the ok
to expose myself to that potential legal liability).

-Kevin
