From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: jgit and ignore
Date: Sun, 01 Mar 2009 18:43:53 +0100
Message-ID: <49AAC959.70406@pelagic.nl>
References: <9e4733910902280831j70448ce9h7239f14e13b92b76@mail.gmail.com> <20090228172622.GC26689@spearce.org> <49AA5F64.6070207@pelagic.nl> <9e4733910903010454u662eb5afob45f608321660500@mail.gmail.com> <49AA884D.1050806@pelagic.nl> <49AA8ECD.4090302@gmail.com> <49AA91F0.7050008@pelagic.nl> <49AAA2B3.40808@gmail.com> <20090301171648.GB14365@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Mar 01 18:45:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdpjC-0000eq-Na
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 18:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051AbZCARn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 12:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756034AbZCARn4
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 12:43:56 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:57294 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755986AbZCARnz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Mar 2009 12:43:55 -0500
Received: from [192.168.0.101] (unknown [192.168.0.101])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 5F05C58BDBA;
	Sun,  1 Mar 2009 18:43:53 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <20090301171648.GB14365@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111860>

> IMHO, we should honor ignores in EGit as:
> 
>   per-directory .gitignore
>   per-repostiory GIT_DIR/info/exclude
> 
>   per-repository core.excludesfile (yes, really, it can be per
>   repository, which overrides ~/.gitconfig setting of same)

wow. override? really?

> 
>   Eclipse global team ignore patterns
> 

so, should these then override, supplement, or something else?
the per-repo files (.gitignore's and info/exclude supplement eachother.


> Skipping the core.excludesfile in favor of only the Eclipse global
> team ignores feels wrong to me, as we may be missing something
> the user has configured.  FWIW, I think core.excludesfile is a
> lot less frequently used then .gitignore and GIT_DIR/info/exclude.
> If there is a core.excludesfile, the user is a pretty advanced user
> and they really want that behavior to be honored by Git poreclain.
> EGit should honor it.

I could also argue that an advanced user would expect Egit and git to
behave the same. especially for advanced features. and even more so
because EGit now is very basic and to be able to use the advanced
features you have to switch to the commandline from Eclipse. making this
a very very real use-case for EGit usage.

Once we have more advanced features implemented this use-case will
become less prevalent and only then I'd (personally) be more inclined to
allow more behaviour differences
