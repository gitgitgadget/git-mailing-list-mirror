From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/8] generate-cmdlist.sh: avoid selecting synopsis at
 wrong place
Date: Mon, 1 Dec 2008 16:39:43 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812011546560.30769@pacific.mpi-cbg.de>
References: <1228042478-1886-1-git-send-email-pclouds@gmail.com> <1228042478-1886-2-git-send-email-pclouds@gmail.com> <alpine.DEB.1.00.0812011505551.30769@pacific.mpi-cbg.de> <7vtz9oq92i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 16:32:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7AlO-0003cc-7d
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 16:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbYLAPb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 10:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbYLAPb0
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 10:31:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:36951 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751537AbYLAPbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 10:31:25 -0500
Received: (qmail invoked by alias); 01 Dec 2008 15:31:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp031) with SMTP; 01 Dec 2008 16:31:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Uio4y5o/UtljJXYdOsffBMCeyJU5SZP2JhARUYH
	+qK/B3+wTjFt0p
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vtz9oq92i.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102050>

Hi,

On Mon, 1 Dec 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > As it is, the patch series is _already_ hard to review (as it is large 
> > not only in term of number of patches, but also individual patch 
> > size), _especially_ given the fact that there is no clear, precise and 
> > short description of why/how the sparse checkout is implemented.
> 
> Hmm, can you really tell the lack of such description without reading 
> the series, I have to wonder...

Okay, I thought it was obvious, but here is a template for the BLURP of 
the cover letter that would at least get me started:

-- snip --
A "sparse checkout" is an index/working directory pair where not all 
files/directories of the HEAD commit are actually checked out in the 
working directory.  Instead, they are marked as "not being checked out" in 
the index.

The real meat of this series is patch *** M/N *** which teaches Git to 
understand the *** XYZ flag *** for index entries.

The following operations are affected by sparse checkout: *** X, Y, Z ***

These operations respect sparse checkouts by *** THIS, THIS AND THIS ***.

The first patch really should be independent, but patch *** M/N *** would 
fail without it.
-- snap --

And of course, the whole BLURP should not consist of 10-20 line 
paragraphs, but try to fit everything into 3-4 line paragraphs (I seem to 
remember that there was a mail on this list saying than more than 4 
lines/paragraph are too much for the average attention span...).

Ciao,
Dscho
