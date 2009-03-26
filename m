From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: svn clone Checksum mismatch question
Date: Thu, 26 Mar 2009 14:02:13 +0100
Message-ID: <20090326130213.GC3114@atjola.homenet>
References: <22719363.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Gilbert Liddell <gliddell@totalrepair.co.uk>
X-From: git-owner@vger.kernel.org Thu Mar 26 14:26:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmpat-0008KJ-AP
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 14:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbZCZNYZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2009 09:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752400AbZCZNYY
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 09:24:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:55213 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752312AbZCZNYY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 09:24:24 -0400
Received: (qmail invoked by alias); 26 Mar 2009 13:24:21 -0000
Received: from i59F569BB.versanet.de (EHLO atjola.local) [89.245.105.187]
  by mail.gmx.net (mp064) with SMTP; 26 Mar 2009 14:24:21 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/T1yYiaMHTQy6emnCINPwKxzRhXQaPRY0asuhMdg
	WCbz/h5oVj7o/X
Content-Disposition: inline
In-Reply-To: <22719363.post@talk.nabble.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114775>

On 2009.03.26 03:31:53 -0700, Gilbert Liddell wrote:
> This morning i decided to test the clone with the full project i'm wo=
rking
> on (11,000 files) and I get the error message Checksum mismatch: vn2.=
sln
> 0f7a82f1d38b819 expected: fde799e5ba0d1d07e6b539016bea3260
> got: e71db1010a0da06ea76d4163c452df72
>=20
> Can someone help with why this error is happening? Is there an issue =
with
> the GIT clone and large repositories?

Which git version is that? There was some bug in git-svn that caused it
to fill the disk with temporary files, without noticing that those file=
s
get truncated when the disk is full. That was fixed in some 1.6.0.x
release IIRC.

Bj=F6rn
