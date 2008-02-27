From: Seth Falcon <seth@userprimary.net>
Subject: Re: git-svn messing with timezones
Date: Wed, 27 Feb 2008 08:21:09 -0800
Message-ID: <m2zltmnzey.fsf@userprimary.net>
References: <20080226124748.GH31792@mail.stoakes.net>
	<20080227073244.GB24316@soma>
	<20080227102631.GJ30300@mail.stoakes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Tim Stoakes <tim@stoakes.net>
X-From: git-owner@vger.kernel.org Wed Feb 27 17:23:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUP3J-0002GF-L8
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 17:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843AbYB0QWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 11:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754272AbYB0QWD
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 11:22:03 -0500
Received: from qmta03.emeryville.ca.mail.comcast.net ([76.96.30.32]:45505 "EHLO
	QMTA03.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753726AbYB0QWC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Feb 2008 11:22:02 -0500
Received: from OMTA05.emeryville.ca.mail.comcast.net ([76.96.30.43])
	by QMTA03.emeryville.ca.mail.comcast.net with comcast
	id ucNr1Y0020vp7WLA30Kw00; Wed, 27 Feb 2008 16:21:07 +0000
Received: from ziti ([71.197.245.84])
	by OMTA05.emeryville.ca.mail.comcast.net with comcast
	id ugMz1Y0021pz2VT8R00000; Wed, 27 Feb 2008 16:22:00 +0000
X-Authority-Analysis: v=1.0 c=1 a=Z4mJgif-AAAA:8 a=jIxqbozPlobd0DJxpHEA:9
 a=dIgcHrIxYoROYXuyHWAN8irbpeIA:4 a=pzGREQu3uXMA:10 a=F-J2dRE9H3gA:10
 a=9hlq2oIkD8gA:10
In-Reply-To: <20080227102631.GJ30300@mail.stoakes.net> (Tim Stoakes's message of "Wed\, 27 Feb 2008 20\:56\:31 +1030")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.91 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75231>

Tim Stoakes <tim@stoakes.net> writes:
> Ah indeed, `git-svn log` does show the correct TZ. How annoying!
>
> My workflow is to work with native git as much as possible, and interact
> with svn as little as is required. This means I have to remember to run
> one command to see sane logs of git commits that happen to also be svn
> commits, and another one for the normal git commits. There is no
> transparency here.

You might find it convenient to set an alias in ~/gitconfig like:

    [alias]
            llog = log --date=local

The you can review commits in your TZ via 'git llog'.

+ seth

-- 
Seth Falcon | seth@userprimary.net | blog: http://userprimary.net/user/
