From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Reinstate the old behaviour when GIT_DIR is set and GIT_WORK_TREE is unset
Date: Fri, 10 Aug 2007 12:26:56 -0700
Message-ID: <7vk5s3ry0v.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0708042319470.14781@racer.site>
	<20070809223530.GA29680@cassiopeia>
	<Pine.LNX.4.64.0708100129200.21857@racer.site>
	<7vd4xww6mr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0708100210280.21857@racer.site>
	<7vr6mbu8iv.fsf_-_@assigned-by-dhcp.cox.net>
	<20070810112821.GA11026@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Fri Aug 10 21:27:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJa8V-0000Ba-OB
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 21:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763566AbXHJT07 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 10 Aug 2007 15:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757138AbXHJT07
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 15:26:59 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:57771 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758479AbXHJT06 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Aug 2007 15:26:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070810192658.JBVB7956.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 10 Aug 2007 15:26:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aKSx1X0081kojtg0000000; Fri, 10 Aug 2007 15:26:57 -0400
In-Reply-To: <20070810112821.GA11026@informatik.uni-freiburg.de> (Uwe
	=?utf-8?Q?Kleine-K=C3=B6nig's?= message of "Fri, 10 Aug 2007 13:28:21
 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55566>

Uwe Kleine-K=C3=B6nig  <ukleinek@informatik.uni-freiburg.de> writes:

> I don't know if you planed to make=20
>
> 	git checkout-index --prefix=3D/tmp/tra -a
>
> work (again) in a bare repo.  Probably not, so it's no surprise that =
it
> still doesn't work.

I think it is now safe to revert that NEED_WORK_TREE change
in git.c for checkout-index.
