From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Tue, 13 Mar 2012 10:36:51 +0100
Message-ID: <vpqsjhc4zbg.fsf@bauges.imag.fr>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
	<1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
	<1331288715.21444.38.camel@beez.lab.cmartin.tk>
	<4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu>
	<4F5E12A5.6030701@xiplink.com> <vpqzkblixmb.fsf@bauges.imag.fr>
	<20120312183725.GA2187@sigill.intra.peff.net>
	<7vfwddskon.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 10:37:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7OAk-00063s-NF
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 10:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760216Ab2CMJh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 05:37:29 -0400
Received: from mx2.imag.fr ([129.88.30.17]:32794 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760159Ab2CMJh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 05:37:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q2D9WpQU019893
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 13 Mar 2012 10:32:51 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S7OA0-0003yz-F3; Tue, 13 Mar 2012 10:36:52 +0100
In-Reply-To: <7vfwddskon.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 12 Mar 2012 12:06:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 13 Mar 2012 10:32:51 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2D9WpQU019893
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332235973.34869@KH52t+Q7mvjaONsBne9BWA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192992>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> ... This is not a push.default issue,
>> but I think it is somewhat related, and maybe worth discussing along
>> with the topic of asymmetry. ...
>> I've mostly trained my fingers to type "git push
>> <my-publish-repo>", but I do occasionally forget.
>
> In an assymmetric set-up, you would typically push into one place
> but update from one or more places, so it might make sense to make
> it easier to say "git push" and "git pull $there".  But that does
> not solve the fundamental issue, I would think.

It does not solve it completely, but it makes it sensible to have
'upstream' point to the place you are publishing to, and tell "git pull"
explicitely where you want to pull from. This is the way I work when I
have an asymmetrical setup (not the most common in my case).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
