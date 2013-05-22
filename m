From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] guilt: fix date parsing
Date: Wed, 22 May 2013 08:10:10 -0400
Message-ID: <20130522121010.GA2777@thunk.org>
References: <1369192411-8842-1-git-send-email-tytso@mit.edu>
 <20130522033921.GB101217@meili.valhalla.31bits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Wed May 22 14:10:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf7s8-0006OT-Tv
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 14:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756139Ab3EVMKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 08:10:16 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:50696 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755748Ab3EVMKN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 08:10:13 -0400
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1Uf7uY-0004xq-Qo; Wed, 22 May 2013 12:12:54 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 2738C5814B7; Wed, 22 May 2013 08:10:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20130522033921.GB101217@meili.valhalla.31bits.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225147>

On Tue, May 21, 2013 at 11:39:21PM -0400, Josef 'Jeff' Sipek wrote:
> I applied this one and the "guilt: skip empty line after..." patch.

Thanks!  BTW, it looks like you are not using "git am -s" to apply
these patches?  The reason why I ask is that whatever you're using
isn't removing the [XXX] subject prefix (e.g., [PATCH] or [PATCH -v2]
which is useful for mailing lists, but less useful in the git commit
descriptions.

If you're using guilt, do you have some script that preformats a Unix
mbox into guilt-friendly files?  If so, maybe it would be good to
modify it to strip out the [PATCH] annotations.  If not, let me know,
since I've been thinking about writing a script to take a Unix mbox,
and bursts it into a separate patch-per-file with a series file
suitable for use by guilt, removing mail headers and doing other
appropriate pre-parsing --- basically, a "guilt am" which works much
like "git am".  But if someone else has done this already, no point
duplicating effort.  :-)

						- Ted
