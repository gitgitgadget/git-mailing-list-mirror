From: Andi Kleen <andi@firstfloor.org>
Subject: Re: nicer frontend to get rebased tree?
Date: Fri, 22 Aug 2008 20:31:29 +0200
Message-ID: <20080822183129.GR23334@one.firstfloor.org>
References: <20080822174655.GP23334@one.firstfloor.org> <32541b130808221056l75a3fd6bsa6c7933a1c3da60f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 20:30:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWbP4-0005Rs-02
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 20:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754255AbYHVS3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 14:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754205AbYHVS3Y
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 14:29:24 -0400
Received: from one.firstfloor.org ([213.235.205.2]:60615 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754255AbYHVS3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 14:29:24 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
	id 78B0D18900B8; Fri, 22 Aug 2008 20:31:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <32541b130808221056l75a3fd6bsa6c7933a1c3da60f@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93340>

On Fri, Aug 22, 2008 at 01:56:39PM -0400, Avery Pennarun wrote:
> On Fri, Aug 22, 2008 at 1:46 PM, Andi Kleen <andi@firstfloor.org> wrote:
> > But I presume that's a reasonable common usage. Would it
> > make sense to have some standard git sub command that does that?
> > ("get latest state of remote branch, doing what it takes to get it")
> > Or is there already one that I missed?
> 
> Isn't that just
> 
>     git fetch somewhere branchname
>     git reset --hard FETCH_HEAD
> 
> ?

My script right now does.

git fetch origin
git fetch --tags origin
git remote update
git checkout master
git reset --hard origin/master

Sure I can continue using the script (until some change breaks it %),
but I was just asking if that was a common enough operation to deserve
some better support in standard git. It personally (as a relatively
inexperienced git user) took me some time to come up with
this script and I found the original behaviour of git pull on rebased
trees double-plus unintuitive.

Just an idea for improvement.

-Andi

-- 
ak@linux.intel.com
