From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Support custom tunnel schemes instead of SSH
 only
Date: Wed, 27 Mar 2013 18:08:18 +0000
Message-ID: <20130327180818.GA6645@dcvr.yhbt.net>
References: <51521216.2050309@gmail.com>
 <20130327043255.GA3667@dcvr.yhbt.net>
 <7va9poolj7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wieser <wieser.eric@gmail.com>, git@vger.kernel.org,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 19:09:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKumK-000854-V0
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 19:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804Ab3C0SIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 14:08:22 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43271 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751540Ab3C0SIT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 14:08:19 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3B571F4DD;
	Wed, 27 Mar 2013 18:08:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7va9poolj7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219294>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> >
> >   git-svn: Support custom tunnel schemes instead of SSH only (2013-03-27 04:28:04 +0000)
> 
> Thanks.  Will pull.
> 
> By the way, did nobody in the patch chain find the log message
> problematic?  It does not give any information other than a URL to
> an external site, and if you look at the URL it refers to, it only
> says
> 
>   "git svn fetch" failed while talking to svn+xyz:// at Git/SVN/Ra.pm line 307
> 
> which could easily have been written in the log message itself with
> fewer words.

Oops, I wasn't happy with the log message, either, but remained silent
since I thought the subject/title for an obvious one-line change was
sufficient.  In other words, I think an empty log message (+S-o-b) would
suffice, too.
