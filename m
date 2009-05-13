From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push origin error (1.6.3 new default functionality)
Date: Wed, 13 May 2009 11:37:52 -0700
Message-ID: <7vprec4znj.fsf@alter.siamese.dyndns.org>
References: <81bfc67a0905111826y779555cer6679da11db787ab1@mail.gmail.com>
	<4A09594F.4040603@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed May 13 20:38:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4JL7-0007A0-89
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 20:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757028AbZEMShw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 14:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756803AbZEMShw
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 14:37:52 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:60838 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023AbZEMShv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 14:37:51 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090513183752.MWN17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Wed, 13 May 2009 14:37:52 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id r6ds1b0014aMwMQ036dsAD; Wed, 13 May 2009 14:37:52 -0400
X-Authority-Analysis: v=1.0 c=1 a=FUvhmXxEDlAA:10 a=J7j2KiR9MRMA:10
 a=cCri8_SAAAAA:8 a=AJkQG-JLF1dwlLELVVQA:9 a=gXUwH3CZMIjkYhMgGXsA:7
 a=DCThCaGeB5njSXYnZF6bH_sZisAA:4
X-CM-Score: 0.00
In-Reply-To: <4A09594F.4040603@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue\, 12 May 2009 13\:11\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119085>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Seriously, we had that discussion when the feature (change of default
> behaviour) and warning were introduced, so it's too late for a change.
> But it's never too late to do
>
> git config --global push.default matching
>
> and be done with it.

Thanks for saying this concisely, and saving me from repeating this.

> The weird thing is that the default is "matching" already. But it makes
> a difference whether you have set the variable to its default value
> explicitly or not. No man page says so (neither git-push nor
> git-config), and I can't think of other variables with such a behaviour.

It is not weird at all.  Although I am still not convinced (and I suspect
some old timers are not either), the default could change in the future
and by setting it to 'matching', you will protect yourself from such a
change.  Consider it a vaccination ;-)
