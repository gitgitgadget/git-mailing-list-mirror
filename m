From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 0/8] gitweb: gravatar support
Date: Thu, 25 Jun 2009 10:07:55 -0700
Message-ID: <7v8wjggs2c.fsf@alter.siamese.dyndns.org>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
	<200906251455.32953.jnareb@gmail.com>
	<cb7bb73a0906250615i2ed880eci2d3716aa1ca43e4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 19:08:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJsQf-0004Uv-Jr
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 19:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429AbZFYRHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 13:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752234AbZFYRHy
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 13:07:54 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:42820 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbZFYRHx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 13:07:53 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090625170755.QJWC17670.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 25 Jun 2009 13:07:55 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8H7w1c0074aMwMQ03H7w5D; Thu, 25 Jun 2009 13:07:56 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=hQqndbpKY2IA:10 a=pGLkceISAAAA:8
 a=3PLF-ZeIi6HRg2UFCCwA:9 a=5ELVcO04V0c5OknEEsPf8azq8YkA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <cb7bb73a0906250615i2ed880eci2d3716aa1ca43e4d@mail.gmail.com> (Giuseppe Bilotta's message of "Thu\, 25 Jun 2009 15\:15\:00 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122223>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> I was thinking about some form of fallback like that too, but I
> haven't the slightest idea how picons work, so I'm afraid I'll leave
> that enhancement to some later time.

Yeah, let's not go overboard with the initial series.

In order to lay a sound groundwork so that later patches can build on more
cleanly, it is good to talk about possibilities of adding support for
other services _later_ and assess how easy/hard it would be with the
proposed code structure.  Once it's done, and everybody is happy with the
result that it will be easy to work with, then we should leave later later
and move forward.
