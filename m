From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFH] GSoC 2015 application
Date: Fri, 20 Feb 2015 11:34:35 +0100
Message-ID: <vpqmw48c1ms.fsf@anie.imag.fr>
References: <20150218191417.GA7767@peff.net> <vpqzj8ary29.fsf@anie.imag.fr>
	<20150220020022.GC16124@peff.net> <vpqwq3cdhhe.fsf@anie.imag.fr>
	<1424427763.30155.28.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Fri Feb 20 11:34:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOkv2-0004xK-8s
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 11:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbbBTKeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 05:34:44 -0500
Received: from mx1.imag.fr ([129.88.30.5]:43739 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753152AbbBTKen (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 05:34:43 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t1KAYY2G025321
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Feb 2015 11:34:34 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t1KAYZUo031778;
	Fri, 20 Feb 2015 11:34:35 +0100
In-Reply-To: <1424427763.30155.28.camel@kaarsemaker.net> (Dennis Kaarsemaker's
	message of "Fri, 20 Feb 2015 11:22:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 20 Feb 2015 11:34:34 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t1KAYY2G025321
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1425033275.57764@YoBbUipEz3rGNLorARWH+w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264156>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> given a config file name tells
> you where it should be, maybe in the resident kitchen-sink that is
> rev-parse:

It's actually a bit harder than this, since when both XDG and ~/.<file>
exist, we read from both but write to one only. So there's not just one
answer to the question.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
