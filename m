From: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
Subject: Re: [PATCH] guilt: fix date parsing
Date: Wed, 22 May 2013 09:31:20 -0400
Message-ID: <20130522133120.GA13731@poseidon.cudanet.local>
References: <1369192411-8842-1-git-send-email-tytso@mit.edu>
 <20130522033921.GB101217@meili.valhalla.31bits.net>
 <20130522121010.GA2777@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed May 22 15:31:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf98b-0001cK-Ko
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 15:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956Ab3EVNbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 09:31:25 -0400
Received: from josefsipek.net ([64.9.206.49]:1631 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753042Ab3EVNbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 09:31:25 -0400
Received: from poseidon.cudanet.local (unknown [64.235.151.250])
	by josefsipek.net (Postfix) with ESMTPSA id D3FCF173B;
	Wed, 22 May 2013 09:31:23 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20130522121010.GA2777@thunk.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225156>

On Wed, May 22, 2013 at 08:10:10AM -0400, Theodore Ts'o wrote:
> On Tue, May 21, 2013 at 11:39:21PM -0400, Josef 'Jeff' Sipek wrote:
> > I applied this one and the "guilt: skip empty line after..." patch.
> 
> Thanks!  BTW, it looks like you are not using "git am -s" to apply
> these patches?  The reason why I ask is that whatever you're using
> isn't removing the [XXX] subject prefix (e.g., [PATCH] or [PATCH -v2]
> which is useful for mailing lists, but less useful in the git commit
> descriptions.
> 
> If you're using guilt, do you have some script that preformats a Unix
> mbox into guilt-friendly files?  If so, maybe it would be good to
> modify it to strip out the [PATCH] annotations.  If not, let me know,
> since I've been thinking about writing a script to take a Unix mbox,
> and bursts it into a separate patch-per-file with a series file
> suitable for use by guilt, removing mail headers and doing other
> appropriate pre-parsing --- basically, a "guilt am" which works much
> like "git am".  But if someone else has done this already, no point
> duplicating effort.  :-)

You are correct.  I just `guilt import -P blah /tmp/mdir/cur/X` and then
hand-edit the patch to remove headers.  Last night I was thinking about
making a `guilt import-mbox` that'd import a mbox or maildir.  I don't know
off the top of my head how much `git am` would help in this instance.

Feel free to make the import-mbox or whatever command :)

Jeff.

-- 
Only two things are infinite, the universe and human stupidity, and I'm not
sure about the former.
		- Albert Einstein
