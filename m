From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] filter-branch -d: Export GIT_DIR earlier
Date: Wed, 18 Feb 2009 11:25:53 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902181125410.6274@intel-tinevez-2-302>
References: <20090217083146.GA7338@lars.home.noschinski.de> <alpine.DEB.1.00.0902171327270.6185@intel-tinevez-2-302> <20090217175959.GA3564@lars.home.noschinski.de> <20090217180540.GB3564@lars.home.noschinski.de> <alpine.DEB.1.00.0902180002090.10279@pacific.mpi-cbg.de>
 <20090218083535.GA5466@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Lars Noschinski <lars@public.noschinski.de>
X-From: git-owner@vger.kernel.org Wed Feb 18 11:27:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZjeH-0006UC-MB
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 11:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbZBRKZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 05:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbZBRKZz
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 05:25:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:51853 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751692AbZBRKZz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 05:25:55 -0500
Received: (qmail invoked by alias); 18 Feb 2009 10:25:53 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp059) with SMTP; 18 Feb 2009 11:25:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Efg8ThBBEHiIQjibPkBSq4NmmtDs6MYjPaJgXVl
	LzVzqIbo2dnSpy
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090218083535.GA5466@lars.home.noschinski.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110523>

Hi,

On Wed, 18 Feb 2009, Lars Noschinski wrote:

> The improved error handling catches a bug in filter-branch when using
> -d pointing to a path outside any git repository:
> 
> $ git filter-branch -d /tmp/foo master
> fatal: Not a git repository (or any of the parent directories): .git
> 
> This error message comes from git for-each-ref in line 224. GIT_DIR is
> set correctly by git-sh-setup (to the foo.git repository), but not
> exported (yet).
> 
> Signed-off-by: Lars Noschinski <lars@public.noschinski.de>
> Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
> 
> Last iteration :)

Yep, I like it.

Thanks,
Dscho
