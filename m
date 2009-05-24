From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/18] http-push, http-walker: style fixes
Date: Sun, 24 May 2009 13:43:21 -0700
Message-ID: <7v7i06ut92.fsf@alter.siamese.dyndns.org>
References: <20090524221941.8670c41d.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 22:43:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8KXm-0002L3-M6
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 22:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbZEXUnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 16:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbZEXUnV
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 16:43:21 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:39798 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbZEXUnV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 16:43:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090524204321.KIFP25927.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 24 May 2009 16:43:21 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id vYjM1b0074aMwMQ03YjMv2; Sun, 24 May 2009 16:43:21 -0400
X-Authority-Analysis: v=1.0 c=1 a=jzda2yG1zNcA:10 a=crBg8x4GWd0A:10
 a=pGLkceISAAAA:8 a=jWeDsi2YCO7P3Ine8yYA:9 a=iKgsCWTOuE0-dqhMp-cA:7
 a=pEMbuNFoirzO6H_M_bivTS5IunEA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119853>

Tay Ray Chuan <rctay89@gmail.com> writes:

>  *spaces used as indentation have been replaced by tabs instead.
>
>  *'if' and 'while' conditionals with a single line have had their curly
>   braces removed.
>

We need to apply a style fix to your commit messages first.

Using '*' without any space as the enumeration bullet makes the message
harder to read.  Please don't.  Also we prefer to give orders to the
person who applies the patch (i.e. "do _this_, so that the result becomes
better in _this_ and _that_ way"), instead of saying "I've done this and
that".

	- Use tabs to indent, instead of spaces.

	- Do not use curly-braces around a single statement body in
          if/while statement; 

	- Do not start multi-line comment with description on the first
          line after "/*", i.e.
        
            /*
             * We prefer this over...
             */

            /* comments like
             * this (notice the first line)
             */

I personally do not necessarily agree with the first "clean-up", but as
long as the style is internally consistent within the file that's Ok.
