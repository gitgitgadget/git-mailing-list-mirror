From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [RFC] Idea for Git Bugtracking Tool
Date: Sun, 9 Mar 2008 09:26:40 +0100
Message-ID: <20080309082640.GA22732@efreet.light.src>
References: <20080306142246.5d9460b7@gmail.com> <vpqskz3pqdo.fsf@bauges.imag.fr> <m3zltaf7vs.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Harning <harningt@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 09:27:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYGsQ-0000GK-Ka
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 09:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbYCII0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 04:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbYCII0t
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 04:26:49 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:58868 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907AbYCII0s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 04:26:48 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 7C32F5724A;
	Sun,  9 Mar 2008 09:26:46 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id xA81MXZUOkgK; Sun,  9 Mar 2008 09:26:43 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 174A5576A1;
	Sun,  9 Mar 2008 09:26:43 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1JYGrg-0000kK-56; Sun, 09 Mar 2008 09:26:40 +0100
Content-Disposition: inline
In-Reply-To: <m3zltaf7vs.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76638>

On Fri, Mar 07, 2008 at 15:10:18 -0800, Jakub Narebski wrote:
> [...]
> There exists few implementations of distributed bug tracker idea. They
> include:
> 
>  * Bugs Everywhere (http://bugseverywhere.org), written in Python,
>    developed in Bazaar, has Git backend support. Formerly written by
>    Panoramic Feedback (note that there is stale version of this tool),
>    picked up by one of developers

I recall Pierre mentioning that he didn't like some things on this back then
when he talked about Grit. Particularly, I believe, the way it suggested to
have the bugs in the same branch as source to keep them in sync. It might be
possible to use it in different way though.

>  * DisTract (http://www.distract.wellquite.org), written in Haskell,
>    uses Monotone as backend. Has good reviews on blogs, e.g. by
>    Masukomi.

Sounds a little overcomplicated with the monotone storage and firefox UI.

>  * DITrack (http://www.ditrack.org), written in Python, currently
>    uses Subversion as backend, has plans to be backend-agnostic.
>    Inspired by Subissue.

I wish them good luck. The problem is, that this is /not/ distributed,
because they use sequential bug numbers, which they'd have to change if they
wanted to use Git.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
