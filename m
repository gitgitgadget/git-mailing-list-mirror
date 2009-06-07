From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP/RFC] Allow push and fetch urls to be different
Date: Sat, 06 Jun 2009 21:19:34 -0700
Message-ID: <7vtz2sbrqh.fsf@alter.siamese.dyndns.org>
References: <7v1vpztsci.fsf@alter.siamese.dyndns.org>
	<1244299395-6605-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nikos Chantziaras <realnc@arcor.de>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Jun 07 06:19:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD9rJ-0006B8-AN
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 06:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbZFGETd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 00:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbZFGETd
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 00:19:33 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:41396 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbZFGETc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 00:19:32 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090607041934.DHFD17135.fed1rmmtao104.cox.net@fed1rmimpo03.cox.net>;
          Sun, 7 Jun 2009 00:19:34 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 0sKa1c0044aMwMQ04sKaxx; Sun, 07 Jun 2009 00:19:34 -0400
X-VR-Score: 0.00
X-Authority-Analysis: v=1.0 c=1 a=UKPG_okjeu0A:10 a=VWv6Vc0wgp8A:10
 a=cCri8_SAAAAA:8 a=LP5qKHGBwGA1bLpMitAA:9 a=RlnaoN0gN6YpYTIzjBsBKhM0rsMA:4
X-CM-Score: 0.00
In-Reply-To: <1244299395-6605-1-git-send-email-git@drmicha.warpmail.net> (Michael J. Gruber's message of "Sat\,  6 Jun 2009 16\:43\:15 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120953>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> This introduces a config setting remote.$remotename.pushurl which is
> used for pushes only. If absent remote.$remotename.url is used for
> pushes and fetches as before.
> This is useful, for example, in order to to do passwordless fetches
> (remote update) over git: but pushes over ssh.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> This is a working prototype, but I'd like to rfc about the approach before
> coding further.

As I am guilty for suggesting this, obviously I do not have a problem with
what the patch wants to achieve.

And the change looks simple, straightforward and correct.

> Things that would go in a full series:
> * documentation (man pages, maybe manual)
> * tests

Surely.

> * teach builtin-remote about pushurl

Hmm,...  my impression was that "git remote" does not have much support
for the push side.  What kind of things are you going to teach?
