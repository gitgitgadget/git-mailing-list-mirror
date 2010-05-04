From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [patch 02/16] const-expr.patch
Date: Tue, 4 May 2010 05:01:55 +0000
Message-ID: <20100504050155.GA7374@thor.il.thewrittenword.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
 <20100427135812.656626000@mlists.thewrittenword.com>
 <1AFA5FB2-EB8B-4775-8941-86428C7F740E@gmail.com>
 <20100503013946.GB1550@thor.il.thewrittenword.com>
 <A4E8B513-AD31-4F3B-9DEF-6A85AA8DC7B3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Gary V. Vaughan" <git@mlists.thewrittenword.com>,
	git@vger.kernel.org
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 04 07:02:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9AH5-0000xa-9C
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 07:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515Ab0EDFB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 01:01:56 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:61790 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab0EDFBz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 01:01:55 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 112F35CC3;
	Tue,  4 May 2010 05:18:22 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 112F35CC3
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 3CF5DBBA;
	Tue,  4 May 2010 05:01:55 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id 2DE01BAB1; Tue,  4 May 2010 05:01:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <A4E8B513-AD31-4F3B-9DEF-6A85AA8DC7B3@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146290>

Hi Josh,

On Sun, May 02, 2010 at 10:57:40PM -0700, Joshua Juran wrote:
> On May 2, 2010, at 6:39 PM, Gary V. Vaughan wrote:
> 
> > On Sat, May 01, 2010 at 03:21:24AM -0700, Joshua Juran wrote:
> >> On Apr 27, 2010, at 6:57 AM, Gary V. Vaughan wrote:
> >>
> >>> Index: b/remote.c
> >>> ===================================================================
> >>> --- a/remote.c
> >>> +++ b/remote.c
> >>> @@ -657,10 +657,9 @@ static struct refspec *parse_refspec_int
> >>>
> >>>  int valid_fetch_refspec(const char *fetch_refspec_str)
> >>>  {
> >>> -	const char *fetch_refspec[] = { fetch_refspec_str };
> >>>  	struct refspec *refspec;
> >>>
> >>> -	refspec = parse_refspec_internal(1, fetch_refspec, 1, 1);
> >>> +	refspec = parse_refspec_internal(1, &fetch_refspec_str, 1, 1);
> >>>  	free_refspecs(refspec, 1);
> >>>  	return !!refspec;
> >>>  }
> >>
> >> I'm the author of this patch.

Agreed.

> > I don't follow this list, and made this patch independently without
> > reference to yours.
> 
> You sent a different patch to the list, to which I responded[1] (both  
> to the list and to you directly) with one identical to the one shown  
> above, after which your subsequent patches included a change equal to  
> the one I suggested.  If in fact you came up with it independently,  
> that's fine.  I was just under the impression that you had adopted my  
> change.

Apologies, yes you're quite right.  Either my age, or the vast sea of
patches for all the projects I'm porting at the moment somehow erased
that important exchange from my memory. I hope I didn't cause offence,
none was intended.

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
