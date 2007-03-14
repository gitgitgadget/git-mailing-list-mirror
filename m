From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH, fixed version] git-fetch, git-branch: Support local --track via a special remote `.'
Date: Wed, 14 Mar 2007 04:20:49 -0700
Message-ID: <7vird4ax66.fsf@assigned-by-dhcp.cox.net>
References: <45F58A84.2000503@lu.unisi.ch>
	<7v4poplceh.fsf@assigned-by-dhcp.cox.net>
	<45F69939.6070909@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Wed Mar 14 12:20:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRRXK-0000zU-QR
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 12:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161133AbXCNLUv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 07:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161140AbXCNLUv
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 07:20:51 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:49894 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161133AbXCNLUv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 07:20:51 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314112049.ORYR1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 07:20:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id abLq1W0081kojtg0000000; Wed, 14 Mar 2007 07:20:50 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42198>

Paolo Bonzini <paolo.bonzini@lu.unisi.ch> writes:

>  t/t9109-git-svn-pull.sh  |   31 +++++++++++++++++++++++++++++++
>  8 files changed, 120 insertions(+), 27 deletions(-)
>
> 	The failure, which I didn't see because I didn't have svn-perl
> 	bindings installed, was caused by my usage of "git-show-ref --heads"
> 	where I should have used plain "git-show-ref".
>
> 	I include a smaller testcase for the same problem, t9109.

I'd prefer dropping the t9109 test, as it seems to be redundant.
Existing t9101 seems to cover pulling from remote tracking
branch maintained by git-svn already.

Also I'll be reverting a couple of patches from 'next', so this
no longer applies.  Would appreciate a re-spin.

Sorry about that.
