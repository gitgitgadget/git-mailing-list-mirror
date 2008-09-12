From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGit question
Date: Fri, 12 Sep 2008 17:40:36 +0200
Message-ID: <20080912154036.GC31240@diana.vm.bytemark.co.uk>
References: <48C94F86.6080707@gmail.com> <20080912075116.GA26685@diana.vm.bytemark.co.uk> <48CA6367.9020300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: Clark Williams <clark.williams@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 17:20:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeAQs-0006GL-4O
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 17:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbYILPSa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Sep 2008 11:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753212AbYILPSa
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 11:18:30 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1812 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbYILPSa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 11:18:30 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KeAlB-0000Hk-00; Fri, 12 Sep 2008 16:40:37 +0100
Content-Disposition: inline
In-Reply-To: <48CA6367.9020300@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95735>

On 2008-09-12 07:41:11 -0500, Clark Williams wrote:

> Ahhhh, no I hadn't found this. Cool! I wonder if I could save the
> series in the branch, so that someone could just checkout the branch
> and do:
>
>   $ stg uncommit $(cat stg-series)

The patch stack log contains all the required info, so this should be
doable (given that you share your <branchname>.stgit branch, which is
the patch stack log).

> Or, maybe I'll look at adding a --series or --file option to
> uncommit?

Sure, that sounds like a good idea. I believe there are existing
commands that take a series file argument; check what they call their
flag.

> I suspect some chicken-and-egg problems here, but this is workable.
> And when you're talking >500 patches, anything you can do to
> automate is a wonderful thing :).

Nice to know StGit is being used with series of that size. I usually
never go beyond about 30 myself, so there are certain types of
scalability problems that I won't see.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
