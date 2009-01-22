From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] mergetool merge/skip/abort
Date: Thu, 22 Jan 2009 14:22:58 +0000
Message-ID: <20090122142258.GA2316@hashpling.org>
References: <81bfc67a0901210637j52fa7a55q51b599e9ff16f6dc@mail.gmail.com> <20090121170434.GA21727@hashpling.org> <81bfc67a0901220617l22b5a8e4ma48bb069d67cae91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 15:34:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ0dc-00066H-W2
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 15:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755259AbZAVOdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 09:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755218AbZAVOdH
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 09:33:07 -0500
Received: from relay.ptn-ipout01.plus.net ([212.159.7.35]:38151 "EHLO
	relay.ptn-ipout01.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754919AbZAVOdG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2009 09:33:06 -0500
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Jan 2009 09:33:05 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAFgQeEnUnw4S/2dsb2JhbADLDoVz
Received: from pih-relay05.plus.net ([212.159.14.18])
  by relay.ptn-ipout01.plus.net with ESMTP; 22 Jan 2009 14:22:59 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay05.plus.net with esmtp (Exim) id 1LQ0SR-0006Pe-Ab; Thu, 22 Jan 2009 14:22:59 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n0MEMwrg002928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 22 Jan 2009 14:22:59 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n0MEMwPs002927;
	Thu, 22 Jan 2009 14:22:58 GMT
Content-Disposition: inline
In-Reply-To: <81bfc67a0901220617l22b5a8e4ma48bb069d67cae91@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: a9e23d9c78d22b9b4cb96ba6e87cd315
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106754>

On Thu, Jan 22, 2009 at 09:17:39AM -0500, Caleb Cushing wrote:
> >  Also, I think you've lost some tabs. Mergetool does have some
> >  inconsistent tabbing but they way I've been aiming towards (which
> >  matches most, but not all of git-mergetool.sh) is to use tabs == 8
> >  spaces for indents but to indent each level by 4 spaces. e.g. three
> >  levels of indent is one tab plus four spaces.
> 
> mixing tabs and spaces == bad, I just realized I can't see half your
> indents because I had tabstop=4 in my vimrc because I like indents at
> 4 spaces which is what you are doing through emulation. this is why I
> generally just use tabs or spaces. files like fstab and .sql are my
> few exceptions, both of which I do more on columns than indents.

There are two conventions at work in git-mergetool.sh but the most
prevalent one (it was like that when I got here!) can be easily
maintained in vim with:

:set tabstop=8
:set softtabstop=4
:set shiftwidth=4

You'll never (well, almost never) know that tabs aren't 4 spaces.

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
