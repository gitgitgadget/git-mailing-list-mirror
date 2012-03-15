From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Thu, 15 Mar 2012 09:02:30 +0100
Message-ID: <vpqehsumgvd.fsf@bauges.imag.fr>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
	<1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
	<1331288715.21444.38.camel@beez.lab.cmartin.tk>
	<4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu>
	<4F5E12A5.6030701@xiplink.com> <vpqzkblixmb.fsf@bauges.imag.fr>
	<20120312183725.GA2187@sigill.intra.peff.net>
	<vpqy5r44zg7.fsf@bauges.imag.fr>
	<7vehswljxi.fsf@alter.siamese.dyndns.org>
	<4F5F60C5.6020900@ira.uka.de>
	<7v7gyoxuth.fsf@alter.siamese.dyndns.org>
	<4F60EE4B.9020803@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Mar 15 09:03:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S85eZ-0003Vv-Ef
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 09:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759532Ab2COIDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 04:03:14 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60528 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759218Ab2COIDG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 04:03:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q2F7wODu014259
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 15 Mar 2012 08:58:24 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S85dn-0008Dk-Sj; Thu, 15 Mar 2012 09:02:31 +0100
In-Reply-To: <4F60EE4B.9020803@ira.uka.de> (Holger Hellmuth's message of "Wed,
	14 Mar 2012 20:15:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 15 Mar 2012 08:58:25 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2F7wODu014259
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332403107.0657@F9mgdnvukryWw8kBwPbpDw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193194>

Holger Hellmuth <hellmuth@ira.uka.de> writes:

> So today I tried to create a
> bidirectional link between a local and a remote branch using only
> porcelain commands (i.e. without using git config directly). Somehow I
> didn't succeed. I can either use git checkout --track or git push -u
> to make a pull connection between the two, but to automatically push I
> would have to create a branch of the same name (and know that this is
> the magical ingredient that makes it work!)

In this particular case, having 'push.default=upstream' would have done
it for you: your "push -u" would have set up the upstream, and the next
"push" would have followed it.

(or you could "git push remote local-branch:remote-branch")

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
