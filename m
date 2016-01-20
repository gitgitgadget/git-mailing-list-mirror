From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] Documentation: remove unnecessary backslashes
Date: Wed, 20 Jan 2016 13:35:12 -0800
Message-ID: <20160120213512.GA10192@ftbfs.org>
References: <1453310497-7971-1-git-send-email-kraai@ftbfs.org>
 <20160120182421.GA27562@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Matthew Kraai <matt.kraai@abbott.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 22:35:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM0PU-00010Z-A1
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 22:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbcATVfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 16:35:19 -0500
Received: from 46-22-115-26.ip.axbyte.se ([46.22.115.26]:39006 "EHLO
	kvm.ftbfs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757964AbcATVfS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 16:35:18 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.84)
	(envelope-from <kraai@ftbfs.org>)
	id 1aM0PI-0002gp-9T; Wed, 20 Jan 2016 13:35:12 -0800
Content-Disposition: inline
In-Reply-To: <20160120182421.GA27562@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284471>

Hi,

On Wed, Jan 20, 2016 at 01:24:21PM -0500, Jeff King wrote:
> On Wed, Jan 20, 2016 at 09:21:37AM -0800, Matt Kraai wrote:
> > -'<refname>@\{<date>\}', e.g. 'master@\{yesterday\}', 'HEAD@\{5 minutes ago\}'::
> > +'<refname>@{<date>}', e.g. 'master@\{yesterday\}', 'HEAD@{5 minutes ago}'::
> 
> I see you didn't tweak the middle one here, because it _does_ look like
> an attribute. Does asciidoctor actually remove the backslashes there?

Yes, asciidoctor appears to remove the backslashes in some cases but
not others.  I removed the backslashes from the source if it did not
remove them.  I verified that the asciidoc output isn't affected.

> > -'<refname>@\{<n>\}', e.g. 'master@\{1\}'::
> > +'<refname>@{<n>}', e.g. 'master@\{1\}'::
> 
> Ditto here for "1". IMHO asciidoctor's behavior is somewhat crazy, as it
> means you have to know arcane quoting rules to get correct output (you
> cannot just err on the side of quoting). But it's probably still worth
> working around.

I couldn't find any documentation of asciidoctor's behavior.  I didn't
try figuring the behavior out from asciidoctor's source code.

-- 
Matt                                           https://ftbfs.org/~kraai/
