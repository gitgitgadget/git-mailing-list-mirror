From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [patch 02/16] const-expr.patch
Date: Mon, 3 May 2010 01:39:46 +0000
Message-ID: <20100503013946.GB1550@thor.il.thewrittenword.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
 <20100427135812.656626000@mlists.thewrittenword.com>
 <1AFA5FB2-EB8B-4775-8941-86428C7F740E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 03 03:40:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8kdb-0004va-JR
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 03:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917Ab0ECBjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 21:39:53 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:55911 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403Ab0ECBjw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 21:39:52 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 03F0D5C4D;
	Mon,  3 May 2010 01:56:16 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 03F0D5C4D
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id C4CEFA84;
	Mon,  3 May 2010 01:39:22 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id 38C33BAAE; Mon,  3 May 2010 01:39:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1AFA5FB2-EB8B-4775-8941-86428C7F740E@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146210>

Hi Joshua,

On Sat, May 01, 2010 at 03:21:24AM -0700, Joshua Juran wrote:
> On Apr 27, 2010, at 6:57 AM, Gary V. Vaughan wrote:
> 
> > Index: b/remote.c
> > ===================================================================
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -657,10 +657,9 @@ static struct refspec *parse_refspec_int
> >
> >  int valid_fetch_refspec(const char *fetch_refspec_str)
> >  {
> > -	const char *fetch_refspec[] = { fetch_refspec_str };
> >  	struct refspec *refspec;
> >
> > -	refspec = parse_refspec_internal(1, fetch_refspec, 1, 1);
> > +	refspec = parse_refspec_internal(1, &fetch_refspec_str, 1, 1);
> >  	free_refspecs(refspec, 1);
> >  	return !!refspec;
> >  }
> 
> I'm the author of this patch.

I don't follow this list, and made this patch independently without
reference to yours.

However, attribution doesn't concern me, and I don't mean to tread on
toes... so feel free to reassign attribution on push.

> Signed-off-by: Joshua Juran <jjuran@gmail.com>

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
