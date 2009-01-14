From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: How can I restrict git-diff to a specific set of directories?
Date: Wed, 14 Jan 2009 01:02:20 +0100
Message-ID: <20090114000220.GB12624@atjola.homenet>
References: <1231890543.31432.5.camel@rotwang.fnordora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alan <alan@clueserver.org>
X-From: git-owner@vger.kernel.org Wed Jan 14 01:03:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMtEb-0008Vc-AW
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 01:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756584AbZANACZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jan 2009 19:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754799AbZANACZ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 19:02:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:49759 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756160AbZANACY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 19:02:24 -0500
Received: (qmail invoked by alias); 14 Jan 2009 00:02:22 -0000
Received: from i577B816A.versanet.de (EHLO atjola.local) [87.123.129.106]
  by mail.gmx.net (mp018) with SMTP; 14 Jan 2009 01:02:22 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+GyUZJRTuGAbBnFP+KpexzWdsrNeKsvS5YvyCDsG
	oQcHq9vx84mVoD
Content-Disposition: inline
In-Reply-To: <1231890543.31432.5.camel@rotwang.fnordora.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105564>

On 2009.01.13 15:49:03 -0800, Alan wrote:
> I have a repository that I need to build a set of patches for a singl=
e
> directory path.  (I just want the diffs on the one driver.)
>=20
> Is there a clean non-hacky way to do this?
>=20
> It is not cross repository or anything. I just need to generate a dif=
f
> between one commit and another, but only for the contents of a specif=
ic
> directory.
>=20
> I am not finding a real straightforward way to do that.  (Unless I am
> missing something, which is quite possible.)

git diff commitA commitB -- some/paths/here some/more/here and/then/som=
e

That limits the diff to the paths after the dashes.

Bj=F6rn
