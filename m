From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] t0300-credentials: Word around a solaris /bin/sh bug
Date: Thu, 02 Feb 2012 21:43:18 +0100
Message-ID: <vpq62fp3r15.fsf@bauges.imag.fr>
References: <1328211135-25217-1-git-send-email-bwalton@artsci.utoronto.ca>
	<20120202201629.GA20200@burratino>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, git@vger.kernel.org,
	gitster@pobox.com, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 21:44:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt3Vy-0005rK-FM
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 21:44:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573Ab2BBUoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 15:44:13 -0500
Received: from mx1.imag.fr ([129.88.30.5]:41878 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756224Ab2BBUoM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 15:44:12 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q12KesAm020918
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 2 Feb 2012 21:40:54 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Rt3V1-0007V9-70; Thu, 02 Feb 2012 21:43:19 +0100
In-Reply-To: <20120202201629.GA20200@burratino> (Jonathan Nieder's message of
	"Thu, 2 Feb 2012 14:16:29 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 02 Feb 2012 21:40:55 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q12KesAm020918
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1328820057.48491@rhG3Jo5RYC3FQS8DlBr6Og
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189703>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Would something like
>
> 	(
> 		IFS==
> 		while read key value
> 		do
> 			...
> 		done
> 	)
>
> make sense?

I don't think so since the "..." contains

    eval "$key=$value"

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
