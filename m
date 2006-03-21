From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Don't use merge labels in the ed scripts
Date: Tue, 21 Mar 2006 16:44:25 -0500
Message-ID: <1142977465.8712.4.camel@dv>
References: <20060321205414.8301.97041.stgit@dv.roinet.com>
	 <20060321205956.GX19263@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 21 22:45:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLofD-0002gL-P5
	for gcvg-git@gmane.org; Tue, 21 Mar 2006 22:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbWCUVpJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 16:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWCUVpJ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 16:45:09 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:52663 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750845AbWCUVpH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Mar 2006 16:45:07 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FLoeb-0003c1-NL
	for git@vger.kernel.org; Tue, 21 Mar 2006 16:45:03 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1FLoeP-0002Ip-7r; Tue, 21 Mar 2006 16:44:25 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060321205956.GX19263@pasky.or.cz>
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17791>

Hi, Petr!

On Tue, 2006-03-21 at 21:59 +0100, Petr Baudis wrote:
> Dear diary, on Tue, Mar 21, 2006 at 09:54:14PM CET, I got a letter
> where Pavel Roskin <proski@gnu.org> said that...
> > From: Pavel Roskin <proski@gnu.org>
> > 
> > Merge labels keep changing, and they are not required to identify
> > specific lines uniquely for the test purposes.
> > 
> > Signed-off-by: Pavel Roskin <proski@gnu.org>
> 
> Well, I sincerely hope that they won't change again. ;-)

Actually, it would be nice to never expose labels starting with
".merge_file_" - cogito should provide more meaningful labels instead.

If you prefer, I'll submit a minimal patch to 0017-alice-bob-fixup.ed
instead.  Once ".merge_file_" is gone, the "tutorial" testsuite would
check that such labels never appear again.

-- 
Regards,
Pavel Roskin
