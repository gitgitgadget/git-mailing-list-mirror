From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git checkout -b -t
Date: Tue, 02 Jun 2009 08:04:10 -0700
Message-ID: <7vd49mhe39.fsf@alter.siamese.dyndns.org>
References: <43d8ce650906020749r36a0cceao20dc54d1446a6ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 17:04:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBVXH-0002Vu-7J
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 17:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbZFBPEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 11:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752824AbZFBPEK
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 11:04:10 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:51119 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747AbZFBPEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 11:04:09 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090602150411.YNWP18948.fed1rmmtao107.cox.net@fed1rmimpo03.cox.net>;
          Tue, 2 Jun 2009 11:04:11 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id z34A1b00A4aMwMQ0434ANV; Tue, 02 Jun 2009 11:04:11 -0400
X-Authority-Analysis: v=1.0 c=1 a=pGLkceISAAAA:8 a=LAdPfHvT6NoUXUAX5N4A:9
 a=jBjEvYLMgDPm8-x5W5EA:7 a=rEJ8W4D-TFZJt2PID5Ojhrm-BMUA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <43d8ce650906020749r36a0cceao20dc54d1446a6ea@mail.gmail.com> (John Tapsell's message of "Tue\, 2 Jun 2009 15\:49\:53 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120515>

John Tapsell <johnflux@gmail.com> writes:

> $ git checkout -t origin/mybranch
> fatal: git checkout: --track and --no-track require -b
>
> So they do exactly what it tells them:
> $ git checkout -b -t origin/mybranch
> Switched to a new branch "-t"
>
> doh
>
> How can we make this less easy for people to shoot themselves in the
> foot?

 (1) Explain things in terms of semantics, not in terms of "brainless
     cut&paste" operations.

 (2) Avoid telling them what to do in the error messages, instead why what
     they did is an error.

E.g. "--track/--no-track does not make sense if you are not creating a new
branch" would be far less confusing in this particular case.
