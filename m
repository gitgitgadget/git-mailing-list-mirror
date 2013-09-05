From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] git-gui: Modify push dialog to support Gerrit review
Date: Thu, 5 Sep 2013 08:20:45 +0200
Message-ID: <20130905062045.GA4197@sandbox-ub>
References: <20130904150853.52EC4121B7E@jed-dev-01.labnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org,
	Pat Thoyts <patthoyts@gmail.com>
To: Joergen Edelbo <jed@napatech.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 08:27:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHT2D-00029v-BV
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757164Ab3IEG1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:27:13 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.42]:57600 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756452Ab3IEG1M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:27:12 -0400
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Sep 2013 02:27:12 EDT
Received: from [77.20.34.36] (helo=sandbox-ub)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VHSvz-0007Tq-3u; Thu, 05 Sep 2013 08:20:51 +0200
Content-Disposition: inline
In-Reply-To: <20130904150853.52EC4121B7E@jed-dev-01.labnet>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233933>

Hi,

On Mon, Sep 02, 2013 at 10:54:19AM +0200, Joergen Edelbo wrote:
> Problem: It is not possible to push for Gerrit review
> as you will always try to push to /refs/heads/... on
> the remote. As you should not be forced to work on a
> branch with the same name as some branch on the remote,
> some more flexibility in the selection of destination
> branch is also needed.
> 
> Changes done:
> 
> Remove selection of branches to push - push always HEAD.
> This can be justified by the fact that this far the most
> common thing to do.
> Specify both the remote repository to push to as well as
> the specific branch on that remote. This gives the flexibility.
> 
> Add option to specify "Gerrit review". If selected, replace
> the traditional "heads" with the artificial "for" in the
> destination ref spec. This is what actually solved the trigger
> problem.
> 
> Limit the branches to select from to the known branches
> for currently selected remote. This is motivated in better
> usability. Works only when "usettk" is true - it is left for
> further study how to change the values in tk_optionMenu on the
> fly.
> 
> Signed-off-by: Joergen Edelbo <jed@napatech.com>
> ---
> Hi there,
> 
> We are at Napatech A/S just about to roll out a Git/Gerrit/Jenkins
> solution. It will really help the gui oriented people in pushing
> commits if this can be done directly in git-gui.

I like where this is heading. I myself was thinking about this some time
ago. Lets include Pat in the CC, since he is the current maintainer of
git-gui.

Give me some time to review/testdrive the patch.

Cheers Heiko
