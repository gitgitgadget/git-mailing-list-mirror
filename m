From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-ls-files --added?
Date: Sun, 24 May 2009 23:33:16 -0700
Message-ID: <7vws85y9n7.fsf@alter.siamese.dyndns.org>
References: <2cfc40320905240054j2c08da8bt4df95c6f1bc9e254@mail.gmail.com>
	<m3fxeudhho.fsf@localhost.localdomain>
	<2cfc40320905240212jc111b1xfeb39b1851c606d3@mail.gmail.com>
	<7vmy921i3j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 08:33:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Tku-0007PP-SH
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 08:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbZEYGdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 02:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbZEYGdP
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 02:33:15 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:33978 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbZEYGdP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 02:33:15 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090525063316.KNSP17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 25 May 2009 02:33:16 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id viZG1b0034aMwMQ04iZGTG; Mon, 25 May 2009 02:33:16 -0400
X-Authority-Analysis: v=1.0 c=1 a=ybZZDoGAAAAA:8 a=pGLkceISAAAA:8
 a=TSbVqHtbAAAA:8 a=op4spekO2173fXfkF18A:9 a=IHbvsPn-IqZhz7IgmjKkJ2jBbakA:4
 a=qIVjreYYsbEA:10 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <7vmy921i3j.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sun\, 24 May 2009 11\:17\:04 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119886>

Junio C Hamano <gitster@pobox.com> writes:

> Jon Seymour <jon.seymour@gmail.com> writes:
> ...
>> I am still interested in the rationale for git-ls-files not supporting
>> such an option directly, since git-diff still seems a little indirect.
> 
> Partly historical, but more fundamental reason is because ls-files
> plumbing is about the index.
> ...
> Added is _not_ about comparision between the index and the work tree.  It
> is between the HEAD commit and the index, and it does not belong to
> ls-files plumbing.

Having said all that, I think you might be interested in pursuing

  http://thread.gmane.org/gmane.comp.version-control.git/97830/focus=99134

Also, the following thread may serve as a food for thought; it shows that
there is real need for some concise, easy to parse output for people who
want their own Porcelain.

  http://thread.gmane.org/gmane.comp.version-control.git/106122/focus=108110

In short, ls-files and diff-index _can_ give you what you want, but often
people would want information from both, consolidated.
