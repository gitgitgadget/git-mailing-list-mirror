From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: How can I download a git commit as a diff patch?
Date: Wed, 30 Sep 2009 17:07:46 -0400
Message-ID: <20090930210745.GC22159@csclub.uwaterloo.ca>
References: <20090930154410.GA31502@thumper2> <m3tyyk9ost.fsf@localhost.localdomain> <20090930202527.GB22159@csclub.uwaterloo.ca> <200909302240.17729.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alejandro Riveira =?utf-8?Q?Fern=C3=A1ndez?= <ariveira@gmail.com>,
	Randy Dunlap <rdunlap@xenotime.net>,
	Andy <genanr@emsphone.com>, linux-kernel@vger.kernel.org,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754093AbZI3VHn@vger.kernel.org Wed Sep 30 23:08:00 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754093AbZI3VHn@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mt6P1-0003E9-TO
	for glk-linux-kernel-3@lo.gmane.org; Wed, 30 Sep 2009 23:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093AbZI3VHn (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 30 Sep 2009 17:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbZI3VHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Sep 2009 17:07:42 -0400
Received: from caffeine.csclub.uwaterloo.ca ([129.97.134.17]:38429 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751899AbZI3VHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Sep 2009 17:07:42 -0400
Received: from caffeine.csclub.uwaterloo.ca (localhost [127.0.0.1])
	by caffeine.csclub.uwaterloo.ca (Postfix) with ESMTP id 3838F73F6B;
	Wed, 30 Sep 2009 17:07:46 -0400 (EDT)
Received: by caffeine.csclub.uwaterloo.ca (Postfix, from userid 20367)
	id 2C6A873F70; Wed, 30 Sep 2009 17:07:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200909302240.17729.jnareb@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129358>

On Wed, Sep 30, 2009 at 10:40:16PM +0200, Jakub Narebski wrote:
> You can specify parent explicitely: "git diff <rev>^1 <rev>" for diff
> to first parent, e.g. "git diff HEAD^ HEAD".
> 
> Just so you know that this single diff is not enough to redo a merge.
> It is only partial information.

Yes certainly in some cases.  Often you can pick specific patches and
a few patches they depend on to try and fix something, but for bigger
changes it doesn't work.  I am actually surprised it has been this long
before I ever saw one of these combined diff's.  I must have been lucky
so far.

> BTW. there is also "git diff-tree -m <rev>") to show diff to *all*
> parents at once:
> 
>     -m    By default, `git-diff-tree --stdin` does not show differences for
>           merge commits. With this flag, it shows differences to that commit
>           from all of its parents. See also `-c`.

I will have to try that one out.

-- 
Len Sorensen
