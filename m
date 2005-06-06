From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: Last mile for 1.0
Date: Mon, 6 Jun 2005 09:01:31 +0200
Message-ID: <20050606070131.GD3669@cip.informatik.uni-erlangen.de>
References: <7voeak1o0q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506051509490.1876@ppc970.osdl.org> <7vk6l8xue5.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506051658100.1876@ppc970.osdl.org> <20050606054356.GB3669@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0506052300350.1876@ppc970.osdl.org> <20050606064456.GC3669@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0506052351470.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 09:00:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfBZg-0008FK-CM
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 08:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVFFHCF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 03:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVFFHCF
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 03:02:05 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:34457 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261179AbVFFHBs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2005 03:01:48 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j5671VS8014816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 6 Jun 2005 07:01:31 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j5671Vk5014815;
	Mon, 6 Jun 2005 09:01:31 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506052351470.1876@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> The thing is, I historically _often_ have uncommitted data, and it's been 
> one of the biggest bummers for me that a merge of a totally unrelated 
> thing will crap all over my debugging patch..

got the point. I useally work like that, too. But I never did it with a
distributed SCM just with CVS.

> If he uses the same index file, he'll be protected by the index lock. 

I see.

> Not exactly. It updates the index directly, without necessarily updating 
> the working directory. For example:

> 	"$1.." | "$1.$1" | "$1$1.")
> 	        echo "Removing $4"
> 	        exec git-update-cache --force-remove "$4" ;;

> it _says_ "removing $4", but it never actually does so, so the working 
> directory still has the file ;)

> Same goes with added files or even updated files, where it uses
> "--cacheinfo" to update the cache without even touching the working
> directory.

Now I see your point.

> Anyway, git-resovle-script needs to be made to use "git-merge-cache
> -o" too, methinks. And it needs a test-case or two.

Yes, it does. In my merge script in perl it already does that. :-)

	Thomas
