From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [GSOC] Git Configuration API improvements
Date: Tue, 11 Mar 2014 15:51:05 +0100
Message-ID: <vpqsiqovleu.fsf@anie.imag.fr>
References: <CAOLa=ZSKDg9DKxTRMy4yWW7=ZHcudGmK4guYmaP2okxH8Q044Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	mhagger@alum.mit.edu
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 15:51:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNO1d-0001s2-Dd
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 15:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616AbaCKOvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 10:51:21 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41038 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750852AbaCKOvU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 10:51:20 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s2BEp4rI030719
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Mar 2014 15:51:04 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2BEp5bC008341;
	Tue, 11 Mar 2014 15:51:05 +0100
In-Reply-To: <CAOLa=ZSKDg9DKxTRMy4yWW7=ZHcudGmK4guYmaP2okxH8Q044Q@mail.gmail.com>
	(karthik nayak's message of "Tue, 11 Mar 2014 18:42:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 11 Mar 2014 15:51:04 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2BEp4rI030719
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1395154265.65566@UN1dIXFNMsk+m6HIEURpew
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243867>

karthik nayak <karthik.188@gmail.com> writes:

> Currently we have multiple invocation of git_config() in an
> individual invocation of git() which is not efficient. Also, it is
> hard to implement new features,

I think efficiency is not a real concern here. Config files are small
and easy to parse, so parsing them multiple times isn't really
noticeable from the performance point of view.

OTOH, the extensibility is a real concern, and that should be the main
motivation for the project.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
