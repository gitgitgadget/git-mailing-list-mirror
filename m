From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [RFC/PATCH] attr: map builtin userdiff drivers to well-known
 extensions
Date: Fri, 26 Aug 2011 10:33:38 -0500
Message-ID: <49Jb0B80dYohdvQHEk2HW7bFvbaGqrVei6JPtUczcIQObOhHK_bRVKFymHMrH2zujgbzsGeCGMdeqznOy2_QjqRtEmq6i-OlPkXcT1B76QA@cipher.nrlssc.navy.mil>
References: <20110825204047.GA9948@sigill.intra.peff.net> <MHA1dh6UZVuMcLY3WlGaxgT1aGDDZPlJNdM-l--eDgr_pi3krsey_A@cipher.nrlssc.navy.mil> <20110826024533.GB17625@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Boaz Harrosh <bharrosh@panasas.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 17:33:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwyPu-0004ti-FA
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 17:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955Ab1HZPdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 11:33:54 -0400
Received: from mail3.nrlssc.navy.mil ([128.160.11.249]:42840 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787Ab1HZPdx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 11:33:53 -0400
Received: by mail3.nrlssc.navy.mil id p7QFXccQ014971; Fri, 26 Aug 2011 10:33:38 -0500
In-Reply-To: <20110826024533.GB17625@sigill.intra.peff.net>
X-OriginalArrivalTime: 26 Aug 2011 15:33:38.0496 (UTC) FILETIME=[86BBA400:01CC6405]
X-Virus-Scanned: clamav-milter 0.97.2 at mail3
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180174>

On 08/25/2011 09:45 PM, Jeff King wrote:
> On Thu, Aug 25, 2011 at 05:29:36PM -0500, Brandon Casey wrote:
> 
>>> Also, any other extensions that would go into such a list?
>>
>> *.bib diff=bibtex
>> *.tex diff=tex
> 
> I had those ones already. ;P

Indeed.  I must be blind, I skipped right over them.

>> *.[Ff] diff=fortran
>> *.[Ff][0-9][0-9] diff=fortran
> 
> Thanks, I'll add those. I don't see a big problem with generalizing
> f[0-9][0-9] to always be fortran, even though many of those numbers
> aren't used. I don't think I've ever seen one used for anything else.
> 
> Should all of our matches be case-insensitive? That is, should we be
> matching both .HTML and .html? Clearly lowercase is the One True Way,
> but I don't know what kind of junk people with case-insensitive
> filesystems have, or whether we should even worry about it.

For the fortran case, Gnu fortran actually processes the files differently
depending on whether the f is capitalized (it preprocesses or not).  So
there is a functional reason for using a capital letter.

For the others, I don't know.  Do people still create files named .HTML
or is that just a relic of the past?  I can't really think of a strong
argument for or against matching insensitively.

-Brandon
