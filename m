From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Question about removing changes from the index
Date: Fri, 6 Feb 2009 15:09:11 +0100
Message-ID: <20090206140911.GC31491@atjola.homenet>
References: <a1e915350902060557m5a67eba0q819c2ba2a0a49c21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Gustav =?iso-8859-1?Q?H=E5llberg?= <gustav@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 15:11:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVRQE-0006Xz-Kx
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 15:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581AbZBFOJX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Feb 2009 09:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753508AbZBFOJX
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 09:09:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:42656 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753180AbZBFOJW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 09:09:22 -0500
Received: (qmail invoked by alias); 06 Feb 2009 14:09:20 -0000
Received: from i577B8C08.versanet.de (EHLO atjola.local) [87.123.140.8]
  by mail.gmx.net (mp040) with SMTP; 06 Feb 2009 15:09:20 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/aC9tPr2HaI8cl/DVWHbbFk4nt0JMzJzpu3tmFPD
	gYlJEl0Dwqa1Gc
Content-Disposition: inline
In-Reply-To: <a1e915350902060557m5a67eba0q819c2ba2a0a49c21@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108711>

On 2009.02.06 14:57:35 +0100, Gustav H=E5llberg wrote:
> I'm wondering if there's anyone who can recommend a smart way to
> "reset" the index entry for individual files to the contents of HEAD,
> in effect, removing any previous change between HEAD and the index
> (for those files).

Believe it or not, it's "git reset" ;-)

git reset -- file

You can only reset the index entry for that file to some older version,
e.g. "git reset HEAD~5 -- file".

Bj=F6rn
