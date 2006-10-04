From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-rebase: Add a -v option to show a diffstat of the changes upstream at the start of a rebase.
Date: Wed, 04 Oct 2006 00:13:57 -0700
Message-ID: <7v8xjwlfii.fsf@assigned-by-dhcp.cox.net>
References: <45228FEB.10602@codeweavers.com>
	<7v4pulm3j6.fsf@assigned-by-dhcp.cox.net>
	<20061004065943.GT2871@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robert Shearman <rob@codeweavers.com>
X-From: git-owner@vger.kernel.org Wed Oct 04 09:14:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GV0x7-0006f6-Op
	for gcvg-git@gmane.org; Wed, 04 Oct 2006 09:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161099AbWJDHN7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 03:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbWJDHN7
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 03:13:59 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:20128 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1030461AbWJDHN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Oct 2006 03:13:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061004071357.CKZL6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Wed, 4 Oct 2006 03:13:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id W7E01V0031kojtg0000000
	Wed, 04 Oct 2006 03:14:00 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20061004065943.GT2871@admingilde.org> (Martin Waitz's message of
	"Wed, 4 Oct 2006 08:59:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28319>

Martin Waitz <tali@admingilde.org> writes:

> but perhaps we should use the same command line options as pull:
> default to show the diffstat and use -n to suppress it?

I suspect that if your workflow is based on rebase, you usually
fetch and rebase often enough to know what you are rebasing onto
(the fact that this patch did not appear for a long time in
rebase's existence is what makes me think so).  So I think not
showing diffstat is probably a sane default.

Opinions?
