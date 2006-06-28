From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Makefile: set USE_PIC on Linux x86_64 for linking with
	Git.pm
Date: Wed, 28 Jun 2006 16:52:25 -0400
Message-ID: <1151527945.1619.17.camel@dv>
References: <20060628183557.GA5713@fiberbit.xs4all.nl>
	 <7vr719159v.fsf@assigned-by-dhcp.cox.net>
	 <7virml14za.fsf@assigned-by-dhcp.cox.net>
	 <20060628192145.GD5713@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 22:52:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fvh1X-00056V-3g
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 22:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbWF1Uwc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 16:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbWF1Uwc
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 16:52:32 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:9703 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751523AbWF1Uwb
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 16:52:31 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fvh1R-0004eL-0E
	for git@vger.kernel.org; Wed, 28 Jun 2006 16:52:29 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1Fvh1N-0000Xj-Di; Wed, 28 Jun 2006 16:52:25 -0400
To: Marco Roeland <marco.roeland@xs4all.nl>
In-Reply-To: <20060628192145.GD5713@fiberbit.xs4all.nl>
X-Mailer: Evolution 2.7.3 (2.7.3-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22823>

On Wed, 2006-06-28 at 21:21 +0200, Marco Roeland wrote:
> I certainly do not know cases outside Linux where this might break on
> x86-64. I just tried to limit it to the case I could test. But perhaps
> someone with an x86-64 BSD or Solaris might try it?
> 
> To paraphrase Dave Jones: I type 'make', it fails. Some 'git log' later
> I realise I have to manually define 'USE_PIC'. Hey, why doesn't it work
> automagically?

Automagically?  You should search the archives for "Autoconf".  When I
proposed using it, the hell broke loose.  Now let me indulge in
Schadenfreude :-)

I guess I'll need to argue with a working patch next time.

-- 
Regards,
Pavel Roskin
