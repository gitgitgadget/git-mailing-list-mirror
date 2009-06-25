From: Tom Lambda <tom.lambda@gmail.com>
Subject: Re: git pull merges current branch even when <dst> is specified
Date: Thu, 25 Jun 2009 06:28:38 -0700 (PDT)
Message-ID: <1245936518805-3155010.post@n2.nabble.com>
References: <1245862052581-3149948.post@n2.nabble.com> <4A433AC8.4040702@drmicha.warpmail.net> <alpine.DEB.1.00.0906251142550.5365@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 15:30:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJp2K-00089e-J0
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 15:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879AbZFYN2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 09:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755010AbZFYN2h
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 09:28:37 -0400
Received: from kuber.nabble.com ([216.139.236.158]:35814 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755896AbZFYN2g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 09:28:36 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1MJp0I-0003uU-VR
	for git@vger.kernel.org; Thu, 25 Jun 2009 06:28:38 -0700
In-Reply-To: <alpine.DEB.1.00.0906251142550.5365@intel-tinevez-2-302>
X-Nabble-From: tom.lambda@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122210>


Thank you for the explanation.

So specifying :<dst> in git-pull does not seem that useful now to me, since
one has to checkout the <dst> branch anyway to keep other branches
unaltered.

Thanks again,
Tom


Johannes Schindelin wrote:
> 
> 
> To explain why this is so: Merging is an operation that requires a working 
> directory, as merge conflicts can happen.  That is why merging is only 
> possible locally, and only into the current branch.
> 
> 

-- 
View this message in context: http://n2.nabble.com/git-pull-merges-current-branch-even-when-%3Cdst%3E-is-specified-tp3149948p3155010.html
Sent from the git mailing list archive at Nabble.com.
