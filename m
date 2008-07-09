From: Eric Raible <raible@gmail.com>
Subject: Re: Merging a foreign tree into a bare repository.
Date: Wed, 9 Jul 2008 21:04:22 +0000 (UTC)
Message-ID: <loom.20080709T205908-869@post.gmane.org>
References: <1215562468.4199.26.camel@moss-terrapins.epoch.ncsc.mil> <alpine.DEB.1.00.0807090238561.5277@eeepc-johanness> <m3lk0bdkyl.fsf@localhost.localdomain> <alpine.DEB.1.00.0807092040360.4010@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 23:05:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGgrG-0002R7-8h
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 23:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754604AbYGIVEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 17:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752960AbYGIVEc
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 17:04:32 -0400
Received: from main.gmane.org ([80.91.229.2]:59025 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754985AbYGIVEb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 17:04:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KGgpx-0001lu-Ih
	for git@vger.kernel.org; Wed, 09 Jul 2008 21:04:29 +0000
Received: from adsl-75-24-110-134.dsl.pltn13.sbcglobal.net ([75.24.110.134])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 21:04:29 +0000
Received: from raible by adsl-75-24-110-134.dsl.pltn13.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 21:04:29 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 75.24.110.134 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9) Gecko/2008052906 Firefox/3.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87912>

Johannes Schindelin <Johannes.Schindelin <at> gmx.de> writes:
> 
> Hi,
> 
> On Wed, 9 Jul 2008, Jakub Narebski wrote:
> > 
> > Or, alternatively, you can tell git where you want to have working
> > directory with '--work-tree' parameter to git wrapper,
> 
> ... which runs the risk of you forgetting to specify the same working 
> directory all the time.
> 
> Which is the reason I did not suggest it.

How about:

GIT_WORK_TREE=<some-dir>; export GIT_WORK_TREE

Combined with a PS1 which include an indication that GIT_WORK_TREE is set?

- Eric
