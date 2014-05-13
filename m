From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [GUILT v2 00/29] Teach guilt import-commit how to create legal
 patch names, and more
Date: Tue, 13 May 2014 16:45:47 -0400
Message-ID: <20140513204546.GB11391@thunk.org>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Sipek <jeffpc@josefsipek.net>, git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue May 13 22:45:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJaE-0004kQ-Rz
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbaEMUpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:45:51 -0400
Received: from imap.thunk.org ([74.207.234.97]:38019 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752378AbaEMUpu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=bp9kdQDlEzDPDyUr+QVjtEWhQKsgw0osa3cjpclMsMM=;
	b=RgPfrHcokqWjYf0/I/N5G2761+Bd+dsu+Yl1s7KjGyWDzxJJY2aPNwAg0fJkQQC6GTCOxHa2nuIS1IzA3PWu0JVJHEXjzN1s7aXZJZNnc3SJpFiO9bF2y/LRNAH3Ri70Lm/yJh9H9ELoB1+aepAfNhbiCD9CbEerG+Axd8YNtkk=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1WkJa7-00056t-Vl; Tue, 13 May 2014 20:45:48 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 10F49580239; Tue, 13 May 2014 16:45:47 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1400013065-27919-1-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248848>

On Tue, May 13, 2014 at 10:30:36PM +0200, Per Cederqvist wrote:
> I recently found myself sitting on a train with a computer in front of
> me.  I tried to use "guilt import-commit", which seemed to work, but
> when I tried to "guilt push" the commits I had just imported I got
> some errors.  It turned out that "guilt import-commit" had generated
> invalid patch names.

Thanks, I ran into this just last night (although I had manually
created the patch file from an e-mail I received instead of using
"guilt import-commit").

>  - Changed behavior: by default, guilt no longer changes branch when
>    you push a patch.  You need to do "git config guilt.reusebranch
>    false" to re-enable that.  This patch sets the default value of
>    guilt.reusebranch to true; it should in my opinion change to false
>    a year or two after the next release.

We've been living with the "origin" -> "guilt/origin" branch change
for a year already, and in fact, these days I've gotten used to the
new behavior.  Is it really worth it to change the default?

    	       	     	    	     	       - Ted
