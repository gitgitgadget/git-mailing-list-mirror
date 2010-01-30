From: Ron Garret <ron1@flownet.com>
Subject: Re: My use case
Date: Sat, 30 Jan 2010 10:29:54 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-A58BC7.10295430012010@news.gmane.org>
References: <ron1-09825C.00261930012010@news.gmane.org> <1264840729-sup-5264@ezyang> <ron1-CC0A6E.00541330012010@news.gmane.org> <20100130174844.GD788@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 19:30:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbI5M-00057z-W0
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 19:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472Ab0A3SaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 13:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753398Ab0A3SaM
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 13:30:12 -0500
Received: from lo.gmane.org ([80.91.229.12]:52595 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793Ab0A3SaL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 13:30:11 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NbI5B-000513-3D
	for git@vger.kernel.org; Sat, 30 Jan 2010 19:30:09 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 19:30:09 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 19:30:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138491>

In article <20100130174844.GD788@thunk.org>, tytso@mit.edu wrote:

> On Sat, Jan 30, 2010 at 12:54:13AM -0800, Ron Garret wrote:
> > Don't forget, I'm integrating this *into* the IDE, not just using it 
> > *for* the IDE.  So I want to just have a context menu on each code 
> > window with "SNAPSHOT" and "ROLLBACK" items that Just Work.  The casual 
> > user won't even know that there's git behind the scenes.
> 
> This is a workflow question, I suppose, but I find things work much
> better if you can get the user to give you explicit commit boundaries
> so that (a) bisect works, and (b) they can describe what each commit
> does, and (c) so they can more easily move specific bug fixes or
> features between different release branches.  The free-form hacking
> more may be nice, and very "LISP-like", but there are some real
> advantages to having explicitly describable and documented commits.

You are absolutely right.  That is another reason why having the 
individual files tracked separately from the main project would be a 
good thing if I can get it to work.  (It would be kind of like having a 
git-stash on a per-file basis.)

rg
