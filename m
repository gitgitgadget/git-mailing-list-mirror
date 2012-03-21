From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Summary of discussion on "git push" default change
Date: Wed, 21 Mar 2012 19:05:02 +0100
Message-ID: <vpqlimtj0dt.fsf@bauges.imag.fr>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
	<7vty1ndcoi.fsf@alter.siamese.dyndns.org>
	<7vr4wl262q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 19:05:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAPuQ-00076o-LG
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 19:05:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759445Ab2CUSFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 14:05:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49072 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753754Ab2CUSFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 14:05:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q2LI0X4c000484
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 21 Mar 2012 19:00:34 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SAPuA-0004O5-SL; Wed, 21 Mar 2012 19:05:03 +0100
In-Reply-To: <7vr4wl262q.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 21 Mar 2012 10:54:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 21 Mar 2012 19:00:34 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2LI0X4c000484
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332957636.06836@e9mn4RF72wKE6kVIUzIL+g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193594>

Junio C Hamano <gitster@pobox.com> writes:

> In order to show how the world after phase #2 of the transition [*1*]
> would look like to developers, testers and early adopters, I am planning
> merge Matthieu's patch mm/push-default-switch-warning topic [*2*]

Great. There was a few nitpick about my version (s/1.8/2.0/, static
variable), but I can see that you have already fixed them.

It may make sense to create a branch like v2.0 in git.git to start
collecting "switch default" kind of patches, to be merged before 2.0 is
released. There were other points in the "1.8.0" discussion that may
still be valid (I'm not sure what the status of "make add -u full tree"
is for example):

  http://permalink.gmane.org/gmane.comp.version-control.git/167149

(BTW, does your cristal ball say anything about the release date of
2.0?)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
