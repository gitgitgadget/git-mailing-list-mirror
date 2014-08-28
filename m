From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: make install fails because GNU tar needed
Date: Thu, 28 Aug 2014 17:26:31 +0200
Message-ID: <vpqwq9sy6s8.fsf@anie.imag.fr>
References: <267282067.24350.1409235408562.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
	<20140828145056.GA26855@peff.net>
	<502287515.26012.1409238536022.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: dev <dev@cor0.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 17:26:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN1bA-0007DH-EG
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 17:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbaH1P0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 11:26:48 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37407 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbaH1P0r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 11:26:47 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s7SFQTxb016172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Aug 2014 17:26:30 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s7SFQVXe010880;
	Thu, 28 Aug 2014 17:26:31 +0200
In-Reply-To: <502287515.26012.1409238536022.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
	(dev@cor0.com's message of "Thu, 28 Aug 2014 11:08:56 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 28 Aug 2014 17:26:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s7SFQTxb016172
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1409844392.24322@IFvIXDCvlRQSewpKGKbIew
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256097>

dev <dev@cor0.com> writes:

> Actually I found a file called GIT-BUILD-OPTIONS :

That's a generated file (not included by the Makefile, but by some shell
scripts later), don't edit it. Use config.mak for your build
configuration.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
