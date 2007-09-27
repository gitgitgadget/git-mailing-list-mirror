From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Create .dotest-merge after validating options.
Date: Thu, 27 Sep 2007 00:29:09 -0700
Message-ID: <7vfy10woqi.fsf@gitster.siamese.dyndns.org>
References: <1190770213-8651-1-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Thu Sep 27 09:29:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IanoG-0005Qu-9G
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 09:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbXI0H3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 03:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbXI0H3L
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 03:29:11 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:57137 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbXI0H3K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 03:29:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070927072910.QUBN5131.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 27 Sep 2007 03:29:10 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo02.cox.net with bizsmtp
	id tKV91X00C1gtr5g0000000; Thu, 27 Sep 2007 03:29:09 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59275>

Matt Kraai <kraai@ftbfs.org> writes:

> Creating .dotest-merge before validating the options prevents both
> --continue and --interactive from working if the options are invalid,
> so only create it after validating the options.

Thanks.  Will apply with a minor fixup.  Next time, please make
sure the testsuite passes before submitting.
