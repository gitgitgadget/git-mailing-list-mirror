From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: UI tweak suggestion for kernel.org git web gui.
Date: Mon, 21 Nov 2005 17:55:22 +0100
Message-ID: <20051121165522.GA3217@vrfy.org>
References: <200511211019.51110.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 18:04:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeEx7-0002Jc-QD
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 17:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbVKUQze (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 11:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVKUQze
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 11:55:34 -0500
Received: from soundwarez.org ([217.160.171.123]:62667 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S932345AbVKUQze (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2005 11:55:34 -0500
Received: by soundwarez.org (Postfix, from userid 2702)
	id 912E859217; Mon, 21 Nov 2005 17:55:22 +0100 (CET)
To: Rob Landley <rob@landley.net>
Content-Disposition: inline
In-Reply-To: <200511211019.51110.rob@landley.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12458>

On Mon, Nov 21, 2005 at 10:19:50AM -0600, Rob Landley wrote:
> When I view the changelog at:
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=shortlog
> 
> It mixes in tags, which is cool, but they're the same color as regular 
> commits.

They are all commits. There is nothing "mixed". Tags usually just point
to a commit.

> Is there any way that tags could stand out visually?  (Bold them, 
> give them a different color background, etc.)

You mean, you want to see in the list of commits, the ones marked, which
a tag is pointing to? Similar to what gitk is doing?

> I'd try to ask this in the right place, but the above page doesn't even say 
> which git web display package kernel.org is using.  (A small discreet link at 
> the bottom would be nice...)

There is no package for gitweb. Just the single gitweb.cgi file, which is
copied there. You can get the gitweb version in the html source. Just do
"view source" in your browser.

Kay
