From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] Triangular Workflow: user friendly full implementation
Date: Thu, 26 May 2016 13:04:10 +0200
Message-ID: <vpqeg8pgjx1.fsf@anie.imag.fr>
References: <E83A9439-54C8-4925-8EE3-6AEEDD9416F3@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	Samuel Groot <samuel.groot@grenoble-inp.org>
To: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Thu May 26 13:05:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5t6Q-0000js-P6
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 13:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbcEZLFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 07:05:17 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49863 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627AbcEZLFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 07:05:16 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u4QB55Mw021091
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 26 May 2016 13:05:05 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4QB4Aeo011320;
	Thu, 26 May 2016 13:04:10 +0200
In-Reply-To: <E83A9439-54C8-4925-8EE3-6AEEDD9416F3@grenoble-inp.org> (Jordan
	DE's message of "Thu, 26 May 2016 12:06:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Thu, 26 May 2016 13:05:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4QB55Mw021091
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1464865507.74263@niPsH0b1uzITdCapNV+bLQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295643>

Jordan DE GEA <jordan.de-gea@grenoble-inp.org> writes:

> Here is what we want to implement: 

Your message contains the word "implement" too many times. Before
thinking about implementation, think, and discuss, about the design.

If your message is intended to be a discussion on the design, then avoid
using "implementation" in the subject.

> 1. 
> 	a. add the config var: remote.fetchDefault
> 	b. add the config var: branch.<name>.fetchRemote
> 	c. add `git fetch --set-default` in order to set remote.fetchDefault
> 	d. add `git fetch --set-remote` in order to set branch.<name>.fetchRemote
> 	e. add `git pull --set-default` in order to set remote.fetchDefault
> 	f. add `git pull --set-remote` in order to set branch.<name>.fetchRemote
>
> 2. 
> 	a. add `git push --set-default` in order to set remote.pushDefault
> 	b. add `git push --set-remote` in order to set branch.<name>.pushRemote

This tells a lot about the "what?", but lacks the most important "why?"
(or "what for?") question.

The user doesn't want to "set configuration variables". He wants to work
with git, have commands do the right thing, avoid typing useless
keystrokes and avoid surprising behavior. Please explain how your
proposal would improve the situation. For example, show a typical
use-case with commands to type before and after your proposal is
implemented.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
