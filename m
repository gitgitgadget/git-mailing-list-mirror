From: Nicolas Pitre <nico@cam.org>
Subject: Re: Any way to ignore a change to a tracked file when
 committing/merging?
Date: Wed, 13 Jun 2007 13:21:10 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706131318390.21061@xanadu.home>
References: <A30E217A-084E-4019-949F-5918EAA6368E@mimvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: David Watson <dwatson@mimvista.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 19:23:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1HyWYv-00075u-RU
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 19:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759217AbXFMRVh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 13:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759213AbXFMRVh
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 13:21:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50174 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759202AbXFMRVg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 13:21:36 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JJL000W047AKBF0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 13 Jun 2007 13:21:10 -0400 (EDT)
In-reply-to: <A30E217A-084E-4019-949F-5918EAA6368E@mimvista.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50101>

On Wed, 13 Jun 2007, David Watson wrote:

> I've got a problem, or maybe annoyance is more the proper term, that I haven't
> seen solved by any SCM system (at least not to my knowledge). Basically, I may
> make some changes, e.g. to a Makefile or somesuch, that I want to ignore when
> looking at what's changed from the repository. The only problem is, the file
> I've modified is already under version control, so .gitignore doesn't do
> anything.
> 
> Now, I can commit it, so it will stop bugging me, but then when I push out it
> will include that change, unless I back it out. This is a change that I don't
> want propagated anywhere else, because it's specific to my machine or
> development sandbox.
> 
> Is there any way to do this? I'd really love to use git-commit -a in this
> situation, and I could hack up a script to undo my change, run git-commit -a,
> and reapply the change, but makes me a bit squirmy. If I could put something
> in a .git config file to say "commit 237ab should not be propagated under any
> circumstances", that would be fantastic.

Why don't you just use git-commit _without_ -a ?

The whole purpose behind not specifying -a with git-commit is exactly 
for your usage example.


Nicolas
