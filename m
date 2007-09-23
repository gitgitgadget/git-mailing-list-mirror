From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] git-merge: add support for --commit
Date: Sat, 22 Sep 2007 17:51:29 -0700
Message-ID: <7vir62dx0u.fsf@gitster.siamese.dyndns.org>
References: <1190421186-21784-1-git-send-email-hjemli@gmail.com>
	<1190421186-21784-2-git-send-email-hjemli@gmail.com>
	<1190421186-21784-3-git-send-email-hjemli@gmail.com>
	<1190421186-21784-4-git-send-email-hjemli@gmail.com>
	<1190421186-21784-5-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 02:51:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZFh9-0003Ep-OA
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 02:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbXIWAvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 20:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbXIWAvb
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 20:51:31 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:49150 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbXIWAva (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 20:51:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070923005130.LKSG24061.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 22 Sep 2007 20:51:30 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id rcrV1X00A1gtr5g0000000; Sat, 22 Sep 2007 20:51:30 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58948>

Lars Hjemli <hjemli@gmail.com> writes:

> This option can be used to override --no-commit and --squash. The change
> also introduces slightly different behavior for --no-commit: when specified,
> it explicitly overrides --squash.

Makes me wonder if --no-squash also make sense to override a --squash.
Is this really needed?  IOW, does it ever make sense to have --no-commit
in the configuration?
