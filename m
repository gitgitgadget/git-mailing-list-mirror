From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] parse-options: add PARSE_OPT_LITERAL_ARGHELP for complicated argh's
Date: Thu, 21 May 2009 09:26:47 -0700
Message-ID: <7v3aaybewo.fsf@alter.siamese.dyndns.org>
References: <1242557224-8411-1-git-send-email-bebarino@gmail.com>
	<fbaa26d941f496efefc30e298f5534f8194ee716.1242891030.git.bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 18:27:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7B7J-0006io-Pz
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 18:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754470AbZEUQ0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 12:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754444AbZEUQ0r
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 12:26:47 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:54060 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754330AbZEUQ0r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 12:26:47 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090521162648.DCMZ18948.fed1rmmtao107.cox.net@fed1rmimpo03.cox.net>;
          Thu, 21 May 2009 12:26:48 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id uGSn1b00B4aMwMQ04GSntX; Thu, 21 May 2009 12:26:48 -0400
X-Authority-Analysis: v=1.0 c=1 a=8iQOWhK3efMA:10 a=9tctSHRPvscA:10
 a=pGLkceISAAAA:8 a=gn3GkqqyaaWcKwmkL9AA:9 a=NoSsYfi356zI3FccRepL7YSeK60A:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <fbaa26d941f496efefc30e298f5534f8194ee716.1242891030.git.bebarino@gmail.com> (Stephen Boyd's message of "Thu\, 21 May 2009 00\:33\:17 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119697>

Stephen Boyd <bebarino@gmail.com> writes:

> I've decided to appease the pirate haters :-)

Hmmm, why does this break t0040 (I am queuing this on top of 5acb3e5)?
