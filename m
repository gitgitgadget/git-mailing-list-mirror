From: Petr Baudis <pasky@suse.cz>
Subject: Re: What I miss from Cogito...
Date: Thu, 27 Mar 2008 03:36:54 +0100
Message-ID: <20080327023654.GE6803@machine.or.cz>
References: <47E69044.3000207@zytor.com> <20080323173841.GA24943@mit.edu> <47E6978C.4040207@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@MIT.EDU>,
	Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 03:38:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jei0G-0002us-36
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 03:38:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650AbYC0ChF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 22:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753701AbYC0ChF
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 22:37:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54751 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754650AbYC0ChE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 22:37:04 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 10113393A2E2; Thu, 27 Mar 2008 03:36:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <47E6978C.4040207@zytor.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78322>

On Sun, Mar 23, 2008 at 10:46:52AM -0700, H. Peter Anvin wrote:
> Theodore Tso wrote:
>> #!/bin/sh
>> #
>> prefix=$(git rev-parse --show-prefix)
>> for i in $*
>> do
>>         git show HEAD:$prefix$i > $i
>> done
>
> FWIW, cg-restore is a 131-line shell script, so one can assume it's not 
> just doing it for fun.

Actually, such an assumption is not safe, simply since it was written
long before the :-syntax and many other nice features were invented; if
one wants to do things in Git sanely these days, it's not even safe to
look at Cogito's source code for inspiration anymore as it had to work
only with really hardcore primitives.

(And 38 lines is documentation.  ;-)

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
