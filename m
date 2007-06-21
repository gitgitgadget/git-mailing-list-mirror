From: "Dave O'Neill" <dmo@roaringpenguin.com>
Subject: Re: [PATCH] Let git-svnimport clean up SVK commit messages.
Date: Thu, 21 Jun 2007 10:22:57 -0400
Message-ID: <20070621142257.GB21065@magnesium.roaringpenguin.com>
References: <1182392095394-git-send-email-dmo@roaringpenguin.com> <467A141D.1050502@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Jun 21 16:23:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1NYp-0001CP-VF
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 16:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894AbXFUOW6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 10:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752630AbXFUOW6
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 10:22:58 -0400
Received: from www.roaringpenguin.com ([206.191.13.82]:1138 "EHLO
	www.roaringpenguin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbXFUOW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 10:22:58 -0400
Received: from magnesium.roaringpenguin.com (ottawa-hs-64-26-171-99.s-ip.magma.ca [64.26.171.99])
	by www.roaringpenguin.com (8.14.1/8.14.0) with ESMTP id l5LEMuL8025853;
	Thu, 21 Jun 2007 10:22:57 -0400
Received: from magnesium.roaringpenguin.com (localhost.localdomain [127.0.0.1])
	by magnesium.roaringpenguin.com (8.12.10/8.12.10) with ESMTP id l5LEMwWo022818;
	Thu, 21 Jun 2007 10:22:58 -0400
Received: (from dmo@localhost)
	by magnesium.roaringpenguin.com (8.12.10/8.12.10/Submit) id l5LEMvAu022816;
	Thu, 21 Jun 2007 10:22:57 -0400
Content-Disposition: inline
In-Reply-To: <467A141D.1050502@vilain.net>
User-Agent: Mutt/1.4.1i
X-Scanned-By: CanIt (www . roaringpenguin . com) on 206.191.13.82
X-Scanned-By: MIMEDefang 2.57 on 192.168.10.12
X-Spam-Score: undef - spam scanning disabled
X-CanItPRO-Stream: outgoing (inherits from default)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50631>

On Thu, Jun 21, 2007 at 06:01:01PM +1200, Sam Vilain wrote:
> This is a good idea, of course if somebody didn't specify the magic -I
> switch to their 'svk sm' incantation then there will be multiple changes
> listed in a single revision

Yeah, I don't think there's much hope of fully cleaning up those
messages.  My goal was just to make 'git log --pretty=oneline' show
something meaningful from the commit message, rather than:

edfbf48adabb68f9b3973f5950570c355f3ee811  r6211@oxygen:  dmo | 2007-04-17 17:28:23 -0400
d5b3268e815ce9e88dd617a5b62df80da263f396  r6210@oxygen:  dmo | 2007-04-17 15:54:04 -0400

Cheers,
Dave
