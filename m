From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Merging non-git releases of a project
Date: Sat, 10 Oct 2009 11:00:53 +0200
Message-ID: <20091010090053.GA4843@atjola.homenet>
References: <26ae428a0910091411i39a03650o51163f794b984524@mail.gmail.com>
 <32541b130910091427i7c8a2426hb69a9914aabde8bc@mail.gmail.com>
 <26ae428a0910091433v2c959a70g9bfc6c54382f370d@mail.gmail.com>
 <32541b130910091543x19b3b46an109f90be5c5bfaa2@mail.gmail.com>
 <20091010084742.GB17220@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Howard Miller <howard@e-learndesign.co.uk>, git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 10 11:03:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwXr1-0001O8-AM
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 11:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755920AbZJJJBp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Oct 2009 05:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755879AbZJJJBp
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 05:01:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:43346 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755707AbZJJJBo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2009 05:01:44 -0400
Received: (qmail invoked by alias); 10 Oct 2009 09:00:57 -0000
Received: from i59F571D9.versanet.de (EHLO atjola.homenet) [89.245.113.217]
  by mail.gmx.net (mp020) with SMTP; 10 Oct 2009 11:00:57 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+x7T8bfGixwSYkBfLAeVxoziUKHlIc1AP2xkcLDD
	q5+AB6jV7CyU47
Content-Disposition: inline
In-Reply-To: <20091010084742.GB17220@m62s10.vlinux.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129874>

On 2009.10.10 10:47:42 +0200, Peter Baumann wrote:
> On Fri, Oct 09, 2009 at 06:43:50PM -0400, Avery Pennarun wrote:
> > Try this:
> >=20
> >    cd mygitproject
> >    git rm -rf .
> >    cp -a /tmp/wherever/vendor-1.2/. .
> >    git add .
>=20
> This won't commit deleted files from v1.0 - v1.2. Use git add -A to s=
tage all
> modified and deleted files for the next commit.

It will, the "git rm" already cleans the index.

Bj=F6rn
