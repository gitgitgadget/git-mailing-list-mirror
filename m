From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] Documentation/git-blame.txt: --follow is a NO-OP
Date: Wed, 19 Sep 2012 13:31:50 -0700
Message-ID: <C07F05AC-8FBF-4F09-AF13-A291181A06D9@sb.org>
References: <20120906151317.GB7407@sigill.intra.peff.net>
 <1348022905-10048-1-git-send-email-n1xim.email@gmail.com>
 <7v627aiq47.fsf@alter.siamese.dyndns.org>
 <20120919182715.GF11699@sigill.intra.peff.net>
 <7vzk4lg5yf.fsf@alter.siamese.dyndns.org>
 <20120919194213.GB21950@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Drew Northup <n1xim.email@gmail.com>,
	gitList <git@vger.kernel.org>, Matthieu.Moy@imag.fr,
	andy@aeruder.net, chriscool@tuxfamily.org,
	dmellor@whistlingcat.com, dpmcgee@gmail.com, fonseca@diku.dk,
	freku045@student.liu.se, marius@trolltech.com, namhyung@gmail.com,
	rene.scharfe@lsrfire.ath.cx, s-beyer@gmx.net, trast@inf.ethz.ch
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 19 23:38:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TERy7-00010i-3D
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 23:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362Ab2ISVhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 17:37:54 -0400
Received: from mail-out.apple.com ([17.151.62.50]:45593 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352Ab2ISVhw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 17:37:52 -0400
Received: from relay14.apple.com ([17.128.113.52])
 by mail-out.apple.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTPS id <0MAM00FZZ6IJU8I3@mail-out.apple.com> for git@vger.kernel.org;
 Wed, 19 Sep 2012 13:37:37 -0700 (PDT)
X-AuditID: 11807134-b7f726d00000034c-77-505a2bb79d43
Received: from kencur (kencur.apple.com [17.151.62.38])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay14.apple.com (Apple SCV relay)
 with SMTP id 63.C1.00844.7BB2A505; Wed, 19 Sep 2012 13:31:51 -0700 (PDT)
Received: from il0103a-dhcp80.apple.com
 (il0103a-dhcp80.apple.com [17.201.37.208])
 by kencur.apple.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPSA id <0MAM00KGF6D24V70@kencur.apple.com> for git@vger.kernel.org;
 Wed, 19 Sep 2012 13:31:51 -0700 (PDT)
In-reply-to: <20120919194213.GB21950@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1498)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsUiON1OTVdQNyrAYM59JouuK91MDowenzfJ
	BTBGcdmkpOZklqUW6dslcGVM2fmbveA1T8XNn2vYGhhnc3UxcnJICJhInF12jRHCFpO4cG89
	G4gtJNDOJDH1WEgXIxeQvZdJ4siz52BFzAJaEut3HmcCsXkF9CRu/1wGZgsLuEr8fbGbHcRm
	E1CSuDdhCVicU8Ba4vLBk2BxFgFVif1dr1hBhjIL/GCSmL/mOAvEUHmJzWveMkMMtZSYvO0d
	C8Tm9UwSW/bfBisSEZCV+H54I9SpshL3Xvxmm8AoMAvJUbOQHDULydwFjMyrGAWLUnMSKw1N
	9BILCnJS9ZLzczcxgoKvodBkB+PBn/yHGAU4GJV4eI3EogKEWBPLiitzDzFKcDArifD+2BsZ
	IMSbklhZlVqUH19UmpNafIhRmoNFSZxXRACoWiA9sSQ1OzW1ILUIJsvEwSnVwDhr74YDDscP
	/rLeznC9YoHbfpY9QQ7BN24327lzH3g4T/lS3W/v3NythW/EP5/89nlTU+WvYLMwT77rQU5v
	DO24S/fH6a5m3x+xWe3946zFU+8fucnzJ+2R0OdJClb1Sa8Zzs8srP4rrXdmIp+62BrnOZlF
	ExbU/Om31Iy4bWf+8G512ONv+olKLMUZiYZazEXFiQCX4dOSOgIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206004>

On Sep 19, 2012, at 12:42 PM, Jeff King <peff@peff.net> wrote:

>> So I am in general OK with it, but if we are to go that route, we
>> should make sure that the documentation makes it clear that blame
>> follows whole-file renames without any special instruction before
>> doing so.  Otherwise, it again will send the same wrong message to
>> people who try to use the "--follow" from their experience with
>> "log", no?
> 
> I guess it depends on your perspective. I can see the argument that
> blame is already doing what --follow would ask for, and thus it is a
> no-op. I think of it more as --follow is nonsensical for blame. But I
> do not think either is wrong per se, and there is no reason not to help
> people who come to git thinking the former. So yes, I think
> documentation in either case is probably a good thing.
> 
> I am a little lukewarm on my patch if only because of the precedent it
> sets.  There are a trillion options that revision.c parses that are not
> necessarily meaningful or implemented for sub-commands that piggy-back
> on its option parser. I'm not sure we want to get into manually
> detecting and disallowing each one in every caller.

I tend to agree with your final sentiment there. But the point that
users may not realize that blame already follows is also valid. Perhaps
we should catch --follow, as in your patch, but instead of saying that
it's an unknown argument, just print out a helpful message saying blame
already follows renames (and then continue with the blame anyway, so
as to not set a precedent to abort on unknown-but-currently-accepted
flags).

-Kevin
