From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Merging non-git releases of a project
Date: Sat, 10 Oct 2009 10:47:42 +0200
Message-ID: <20091010084742.GB17220@m62s10.vlinux.de>
References: <26ae428a0910091411i39a03650o51163f794b984524@mail.gmail.com> <32541b130910091427i7c8a2426hb69a9914aabde8bc@mail.gmail.com> <26ae428a0910091433v2c959a70g9bfc6c54382f370d@mail.gmail.com> <32541b130910091543x19b3b46an109f90be5c5bfaa2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Howard Miller <howard@e-learndesign.co.uk>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 10:49:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwXeE-0005Pw-17
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 10:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854AbZJJIsd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Oct 2009 04:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755680AbZJJIsd
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 04:48:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:46515 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755567AbZJJIsc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2009 04:48:32 -0400
Received: (qmail invoked by alias); 10 Oct 2009 08:47:44 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp052) with SMTP; 10 Oct 2009 10:47:44 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18zLKkmz9szvCV6wbjMAE7SeAZAmnrbAfpaBeAVOi
	ztCBBQm7oyMRHG
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 505C61BC07; Sat, 10 Oct 2009 10:47:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <32541b130910091543x19b3b46an109f90be5c5bfaa2@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129872>

On Fri, Oct 09, 2009 at 06:43:50PM -0400, Avery Pennarun wrote:
> On Fri, Oct 9, 2009 at 5:33 PM, Howard Miller
> <howard@e-learndesign.co.uk> wrote:
> > I'm missing the point here though. Where/when =A0do I actually add =
the
> > new pristine code? If I checkout, as you suggest, my initial commit=
 I
> > just have (say) v1.0 of the vendor's code. I can't just copy (say)
> > version 1.2 on top as the files probably won't match one-one.
> >
> > Sorry - I'm probably completely failing to understand.
>=20
> Try this:
>=20
>    cd mygitproject
>    git rm -rf .
>    cp -a /tmp/wherever/vendor-1.2/. .
>    git add .

This won't commit deleted files from v1.0 - v1.2. Use git add -A to sta=
ge all
modified and deleted files for the next commit.

>    git commit
>=20
> Don't worry, git won't double-store files that are identical between
> the old 1.0 and new 1.2 versions.
