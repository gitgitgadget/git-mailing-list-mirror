From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] standardize usage info string format
Date: Thu, 08 Jan 2015 14:21:22 +0100
Message-ID: <vpqvbkh9zn1.fsf@anie.imag.fr>
References: <1420698501-15393-1-git-send-email-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
	krh@redhat.com, vmiklos@frugalware.org, madcoder@debian.org,
	barra_cuda@katamail.com, dpotapov@gmail.com, git@adamspiers.org,
	sunshine@sunshineco.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	barkalow@iabervon.org, stefanbeller@gmail.com,
	shawn.bohrer@gmail.com, felipe.contreras@gmail.com,
	rhansen@bbn.com, pasky@ucw.cz, s-beyer@gmx.net,
	c.shoemaker@cox.net, grnch@gmx.net, jbowes@dangerouslyinc.com,
	l.s.r@web.de, philipoakley@iee.org, michal.kiedrowicz@gmail.com,
	cmn@elego.de, artagnon@gmail.com, rctay89@gmail.com,
	stefan.naewe@gmail.com, pbonzini@redhat.com, aspotashev@gmail.com,
	johan@herland.net, luksan@gmail.com, bebarino@gmail.com,
	Johannes.Schindelin@gmx.de, kevin@bracey.fi, jasampler@gmail.com,
	brad.king@kitware.com, git@drmicha.warpmail.net, peff@peff.net,
	chriscool@tuxfamily.org, ayiehere@gmail.com, jos
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 14:35:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9DDy-0007RS-E0
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 14:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756503AbbAHNeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 08:34:00 -0500
Received: from mx2.imag.fr ([129.88.30.17]:37935 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754937AbbAHNd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 08:33:59 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t08DMWb3003552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 8 Jan 2015 14:22:32 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t08DLMPe009112;
	Thu, 8 Jan 2015 14:21:22 +0100
In-Reply-To: <1420698501-15393-1-git-send-email-alexhenrie24@gmail.com> (Alex
	Henrie's message of "Wed, 7 Jan 2015 23:28:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 08 Jan 2015 14:22:35 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t08DMWb3003552
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1421328157.93585@+4gDFmf7vUhs/fTBnXYp9A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262196>

Alex Henrie <alexhenrie24@gmail.com> writes:

> - Placing angle brackets around fill-in-the-blank parameters
> - Putting dashes in multiword parameter names
> - Adding spaces to [-f|--foobar] to make [-f | --foobar]
> - Replacing <foobar>* with [<foobar>...]

The review would be easier with a patch series having one patch per item
in this list (not sure splitting the series now is worth the trouble
though).

I went quickly through the patch and didn't find any issue. I do support
the style standardization effort.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
