From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv8 5/7] gitweb: gravatar url cache
Date: Tue, 30 Jun 2009 13:38:21 -0700
Message-ID: <7vprcl78zm.fsf@alter.siamese.dyndns.org>
References: <1246312854-3365-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1246312854-3365-2-git-send-email-giuseppe.bilotta@gmail.com>
	<1246312854-3365-3-git-send-email-giuseppe.bilotta@gmail.com>
	<1246312854-3365-4-git-send-email-giuseppe.bilotta@gmail.com>
	<1246312854-3365-5-git-send-email-giuseppe.bilotta@gmail.com>
	<1246312854-3365-6-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 22:38:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLk63-00028V-63
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 22:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026AbZF3UiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 16:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753932AbZF3UiT
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 16:38:19 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:44433 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738AbZF3UiT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 16:38:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090630203822.ZFBL17670.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 30 Jun 2009 16:38:22 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id ALeN1c0044aMwMQ03LeNGc; Tue, 30 Jun 2009 16:38:22 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=_TkqXmF9kRUA:10 a=pGLkceISAAAA:8
 a=enfaLyAKmDm3P2tZdJAA:9 a=nk4MVOaANgz_tFAcz8PuBkzq3akA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <1246312854-3365-6-git-send-email-giuseppe.bilotta@gmail.com> (Giuseppe Bilotta's message of "Tue\, 30 Jun 2009 00\:00\:52 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122541>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> +# Rather than recomputing the url for an email multiple times, we cache it
> +# after the first hit. This gives a visible benefit in views where the avatar
> +# for the same email is used repeatedly (e.g. shortlog).
> +# The cache is shared by all avatar engines (currently gravatar only), which
> +# are free to use it as preferred. Since only one avatar engine is used for any
> +# given page, there's no risk for cache conflicts.

Is it "any given page", or "any given e-mail"?
