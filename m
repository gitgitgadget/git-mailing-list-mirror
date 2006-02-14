From: Pavel Roskin <proski@gnu.org>
Subject: Re: cg-clean, cg-status improvements
Date: Tue, 14 Feb 2006 13:17:12 -0500
Message-ID: <1139941032.26723.4.camel@dv>
References: <1139930899.1944.13.camel@dv>
	 <20060214155356.GB9573@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 14 19:17:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F94jo-0000uv-8Y
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 19:17:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422750AbWBNSRR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 13:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422751AbWBNSRR
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 13:17:17 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:18362 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1422750AbWBNSRQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 13:17:16 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1F94jj-0006ht-Cp
	for git@vger.kernel.org; Tue, 14 Feb 2006 13:17:15 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1F94jg-0006xx-Vl; Tue, 14 Feb 2006 13:17:13 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060214155356.GB9573@pasky.or.cz>
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16150>

On Tue, 2006-02-14 at 16:53 +0100, Petr Baudis wrote:
>   I didn't plan to require git 1.2.0 with 0.17, so it would be better if
> you could do the workaround. But if the workaround means significant
> hassle, it's no biggie if git 1.2.0 will be required.

It turns out a proper workaround can only be implemented in cg-Xlib, not
in cg-clean.  It's a bit hairy for my taste (a bash guru could write it
better, I believe), but it's a compact blob of code that can be easily
removed at any time.

The patches have been sent by StGIT.

-- 
Regards,
Pavel Roskin
