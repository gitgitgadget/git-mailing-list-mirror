From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow shell scripts to run with non-Bash /bin/sh
Date: Sun, 23 Sep 2007 12:20:43 -0700
Message-ID: <7vy7excho4.fsf@gitster.siamese.dyndns.org>
References: <20070921214346.GF97288@void.codelabs.ru>
	<7vlkazh1ji.fsf@gitster.siamese.dyndns.org>
	<20070921214346.GF97288@void.codelabs.ru>
	<7v8x6zinjf.fsf@gitster.siamese.dyndns.org>
	<20070922035434.GA99140@void.codelabs.ru>
	<7vtzpnf6c9.fsf@gitster.siamese.dyndns.org>
	<85ir61rc3r.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eygene Ryabinkin <rea-git@codelabs.ru>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Sep 23 21:20:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZX0f-0003JZ-9x
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 21:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbXIWTUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 15:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbXIWTUp
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 15:20:45 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:46157 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbXIWTUo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 15:20:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070923192044.ZKCE5014.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 23 Sep 2007 15:20:44 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo02.cox.net with bizsmtp
	id rvLk1X0021gtr5g0000000; Sun, 23 Sep 2007 15:20:44 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58978>

David Kastrup <dak@gnu.org> writes:

> Independent of that: would you mind a patch replacing that idiom with
>
> while : do case xxx) break; esac
>
> instead?  I find breaking out of the condition rather than the body
> awkward,...

I do not have any problem with your approach at all.

While I personally do not think it improves readability much, I
do not think it hurts either.  And it is a valid workaround for
FBSD issue, so why not.

But on one condition, however.  If it is done correctly with
double semi-colons before "esac" ;-)

Thanks.
