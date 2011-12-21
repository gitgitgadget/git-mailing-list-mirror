From: Nathan Panike <nwp@cs.wisc.edu>
Subject: Re: [PATCH] Specify a precision for the length of a subject string
Date: Wed, 21 Dec 2011 08:53:53 -0600
Message-ID: <20111221145352.GB13097@llunet.cs.wisc.edu>
References: <20111220220754.GC21353@llunet.cs.wisc.edu>
 <m2liq6go7y.fsf@igel.home>
Reply-To: nathan.panike@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nathan W. Panike" <nathan.panike@gmail.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Dec 21 15:54:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdNYQ-0005o9-Tv
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 15:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271Ab1LUOx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 09:53:58 -0500
Received: from llunet.cs.wisc.edu ([128.105.175.76]:46477 "EHLO
	llunet.cs.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531Ab1LUOx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 09:53:57 -0500
Received: from llunet.cs.wisc.edu (localhost [127.0.0.1])
	by llunet.cs.wisc.edu (8.14.1/8.14.1) with ESMTP id pBLErrEb013414;
	Wed, 21 Dec 2011 08:53:53 -0600
Received: (from nwp@localhost)
	by llunet.cs.wisc.edu (8.14.1/8.14.1/Submit) id pBLErrWr013413;
	Wed, 21 Dec 2011 08:53:53 -0600
Content-Disposition: inline
In-Reply-To: <m2liq6go7y.fsf@igel.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187565>

On Wed, Dec 21, 2011 at 12:26:25PM +0100, Andreas Schwab wrote:
> "Nathan W. Panike" <nathan.panike@gmail.com> writes:
> 
> > $ git log --pretty='%h %30s' d165204 -1
> 
> In C's formatted output this syntax denotes a minimum field width, not a
> precision, so it will probably be surprising to many people.

C semantics are already broken because (from git-log(1))

"If you add a - (minus sign) after % of a placeholder, line-feeds that
immediately precede the expansion are deleted if and only if the placeholder
expands to an empty string."

rather than indicating justification of the field.
> 
> Andreas.
> 
> -- 
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."
