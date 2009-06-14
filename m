From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] teach am and rebase -q/--quiet
Date: Sun, 14 Jun 2009 01:24:53 -0700
Message-ID: <7vocsrql2i.fsf@alter.siamese.dyndns.org>
References: <1244924500-27391-1-git-send-email-bebarino@gmail.com>
	<7vfxe3vil9.fsf@alter.siamese.dyndns.org> <4A34A3D0.9020407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 10:25:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFl1j-0006do-7L
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 10:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504AbZFNIY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 04:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753321AbZFNIY4
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 04:24:56 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:62701 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbZFNIYw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 04:24:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090614082453.XOXF18948.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sun, 14 Jun 2009 04:24:53 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 3kQt1c0034aMwMQ03kQt40; Sun, 14 Jun 2009 04:24:53 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=uoIjCrTgn_IA:10 a=KdErG-BSOSEA:10
 a=pGLkceISAAAA:8 a=XAE6lX-OOPTvs8azM3wA:9 a=d6MTol4HGbWjjjPX20uagekq9HUA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <4A34A3D0.9020407@gmail.com> (Stephen Boyd's message of "Sun\, 14 Jun 2009 00\:16\:32 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121542>

Stephen Boyd <bebarino@gmail.com> writes:

> Junio C Hamano wrote:
>> Perhaps you would want to do the same for "stash apply/pop" that runs "git
>> status", listing untracked files and whatnot?
>
> This sounds fine for a follow up, or even a v2.

Yeah, I should have been clearer that I was suggesting a follow-up, and
not even necessarily by you.

> I'm curious though,
> would adding say() to git-sh-setup be a good idea?

We have die(); I'd say why not say() ;-)
