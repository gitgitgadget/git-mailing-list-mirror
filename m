From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: I: git-fetch: -n option disappeared but git-fetch(1) still
 describe it
Date: Wed, 12 Mar 2008 17:04:12 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803121703010.1656@racer.site>
References: <20080312105102.GE14040@wo.int.altlinux.org> <47D7EE27.50407@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Dmitry V. Levin" <ldv@altlinux.org>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Mar 12 17:06:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZTRj-0007EW-ER
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 17:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbYCLQEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 12:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbYCLQEI
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 12:04:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:60718 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751486AbYCLQEI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 12:04:08 -0400
Received: (qmail invoked by alias); 12 Mar 2008 16:04:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp038) with SMTP; 12 Mar 2008 17:04:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Yd09SGFeYD0A5ryh8rbkk1kEDQFXrkxNAkOl+1B
	zKBkKpKDbxMVBI
X-X-Sender: gene099@racer.site
In-Reply-To: <47D7EE27.50407@op5.se>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76961>

Hi,

On Wed, 12 Mar 2008, Andreas Ericsson wrote:

> Dmitry V. Levin wrote:
> 
> > git-fetch builtinification (commit v1.5.3.2-93-gb888d61) apparently 
> > dropped -n option (alias to --no-tags) documented in 
> > Documentation/fetch-options.txt
> > 
> > Either builtin-fetch.c or Documentation/fetch-options.txt should be 
> > adjusted to sync the code with its docs.
> > 
> > Original bug report: 
> > https://bugzilla.altlinux.org/show_bug.cgi?id=14870
> 
> I have a (very) vague memory that git-fetch.sh had to iterate over tags 
> one by one, making tag-heavy projects excruciatingly slow to fetch from 
> with the shellscript version. Some pathological case with 2700 tags was 
> presented where a fetch took nearly an hour, iirc. AFAIR, the 
> builtinification (or was it a protocol extension?) reduced that time to 
> something around 10 seconds for the pathological case.

AFAIR this was helped by the fetch--tool helper, even at the time of 
non-builtin fetch.

> Does anyone else have a sharper memory of what caused the -n option to 
> be dropped?

AFAICT this was done because of the parsopt'ification.  But I forgot the 
details.

Hth,
Dscho
