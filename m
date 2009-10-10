From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Merging non-git releases of a project
Date: Sat, 10 Oct 2009 12:04:58 +0200
Message-ID: <20091010100458.GC17220@m62s10.vlinux.de>
References: <26ae428a0910091411i39a03650o51163f794b984524@mail.gmail.com> <32541b130910091427i7c8a2426hb69a9914aabde8bc@mail.gmail.com> <26ae428a0910091433v2c959a70g9bfc6c54382f370d@mail.gmail.com> <32541b130910091543x19b3b46an109f90be5c5bfaa2@mail.gmail.com> <20091010084742.GB17220@m62s10.vlinux.de> <20091010090053.GA4843@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Howard Miller <howard@e-learndesign.co.uk>, git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 10 12:07:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwYra-00086c-CV
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 12:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756775AbZJJKFt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Oct 2009 06:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756250AbZJJKFt
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 06:05:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:56939 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755963AbZJJKFs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2009 06:05:48 -0400
Received: (qmail invoked by alias); 10 Oct 2009 10:05:00 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp025) with SMTP; 10 Oct 2009 12:05:00 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX185vetZmzk5oW+JREDUL57vAc92MPtr9uwCZrpWpL
	RLK8/BV0Uqa96n
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 77AF21BC07; Sat, 10 Oct 2009 12:04:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20091010090053.GA4843@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129876>

On Sat, Oct 10, 2009 at 11:00:53AM +0200, Bj=F6rn Steinbrink wrote:
> On 2009.10.10 10:47:42 +0200, Peter Baumann wrote:
> > On Fri, Oct 09, 2009 at 06:43:50PM -0400, Avery Pennarun wrote:
> > > Try this:
> > >=20
> > >    cd mygitproject
> > >    git rm -rf .
> > >    cp -a /tmp/wherever/vendor-1.2/. .
> > >    git add .
> >=20
> > This won't commit deleted files from v1.0 - v1.2. Use git add -A to=
 stage all
> > modified and deleted files for the next commit.
>=20
> It will, the "git rm" already cleans the index.
>=20

You are right. I missed the "git" part and read only rm -rf.

-Peter
