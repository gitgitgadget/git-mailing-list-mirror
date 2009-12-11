From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: How to selectively recreate merge state?
Date: Fri, 11 Dec 2009 12:09:44 +0100
Message-ID: <20091211110944.GB19232@atjola.homenet>
References: <76718490912101556o3e2911e8t32b48c0b735fd98c@mail.gmail.com>
 <m38wdae4k4.fsf@localhost.localdomain>
 <7vzl5q71rp.fsf@alter.siamese.dyndns.org>
 <200912110233.18756.jnareb@gmail.com>
 <4B222289.6000004@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Dec 11 12:09:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ3Ni-0008TF-Ay
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 12:09:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762287AbZLKLJm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Dec 2009 06:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762282AbZLKLJm
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 06:09:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:41099 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762281AbZLKLJm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 06:09:42 -0500
Received: (qmail invoked by alias); 11 Dec 2009 11:09:46 -0000
Received: from i59F564AD.versanet.de (EHLO atjola.homenet) [89.245.100.173]
  by mail.gmx.net (mp022) with SMTP; 11 Dec 2009 12:09:46 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX192s8ljIV52nzxzoehaJshA/dHH/LJPIrWc0LwN3S
	e84XLIlNQ+TLwr
Content-Disposition: inline
In-Reply-To: <4B222289.6000004@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135079>

On 2009.12.11 11:44:25 +0100, Michael J Gruber wrote:
> Jakub Narebski venit, vidit, dixit 11.12.2009 02:33:
> >  $ git checkout --conflict=3Dmerge foo
> >  error: path 'foo' does not have all three versions
> >=20
> > Let's recover it by hand:
> >=20
> >  $ echo -e "100644 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 1\tfoo"=
 |=20
> >    git update-index --index-info
> >  $ git ls-files --stage foo
> >  100644 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 1       foo
> >  100644 3bd1f0e29744a1f32b08d5650e62e2e62afb177c 2       foo
> >  100644 469a41eda5c8b45503a3bfc32ad6b5decc658132 3       foo
> >  $ git checkout --conflict=3Dmerge foo
>=20
> Yeah, if we knew that sha1...

Hm, isn't that "$(git merge-base HEAD MERGE_HEAD):foo"?

Bj=F6rn
