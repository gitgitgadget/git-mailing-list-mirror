From: Yaroslav Halchenko <debian@onerussian.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 14 Dec 2010 09:21:55 -0500
Message-ID: <20101214142155.GM13447@onerussian.com>
References: <7vr69r8sqk.fsf@gitster.siamese.dyndns.org>
 <7vlk01hqzz.fsf@gitster.siamese.dyndns.org>
 <20080718175040.6117@nanako3.lavabit.com>
 <20080718182010.6117@nanako3.lavabit.com>
 <20080718094404.GB32184@machine.or.cz>
 <7vtzen7bul.fsf@gitster.siamese.dyndns.org>
 <loom.20101213T194818-377@post.gmane.org>
 <7vbp4pz9hf.fsf@alter.siamese.dyndns.org>
 <20101213214628.GA13447@onerussian.com>
 <4D071B60.2040906@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 14 15:22:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSVla-0002Ex-P5
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 15:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219Ab0LNOWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 09:22:04 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:54253 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106Ab0LNOWD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 09:22:03 -0500
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1PSVlL-0004ax-R0; Tue, 14 Dec 2010 09:21:55 -0500
Received: from yoh by washoe.onerussian.com with local (Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1PSVlL-0004au-L2; Tue, 14 Dec 2010 09:21:55 -0500
Content-Disposition: inline
In-Reply-To: <4D071B60.2040906@viscovery.net>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: j.sixt@viscovery.net, gitster@pobox.com, git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163647>


On Tue, 14 Dec 2010, Johannes Sixt wrote:
> > hm -- read-tree sounded like yet another unknown to me feature of GIT I
> > was trying desperately to discover ;)  unfortunately it doesn't produce a merge
> > for me :-/ -- just a simple commit with the state taken from the other tree:
> How about:
>   git merge --no-commit -s ours 0.2
>   git read-tree -m -u 0.2
>   git commit -m "Reset to 0.2"

Thank you Johannes for chewing it up to ease the digestion by my
brainless stomach -- works just fine ;)

I guess this could be the alias for my needs:

    mtheirs = !sh -c 'git merge -s ours --no-commit $1 && git read-tree -m -u "$1"' -

but since it might be a generic pattern for the use case(s) I have
stated I still see no objective reason why simple '-s theirs' should not
be there.

-- 
=------------------------------------------------------------------=
Keep in touch                                     www.onerussian.com
Yaroslav Halchenko                 www.ohloh.net/accounts/yarikoptic
