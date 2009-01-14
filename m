From: Alan <alan@clueserver.org>
Subject: Re: How can I restrict git-diff to a specific set of directories?
Date: Tue, 13 Jan 2009 16:33:16 -0800
Message-ID: <1231893196.31432.7.camel@rotwang.fnordora.org>
References: <1231890543.31432.5.camel@rotwang.fnordora.org>
	 <20090114000220.GB12624@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 01:34:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMtiV-0000MR-6C
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 01:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760296AbZANAdU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jan 2009 19:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760079AbZANAdT
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 19:33:19 -0500
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:52815 "EHLO
	clueserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759956AbZANAdS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 19:33:18 -0500
Received: from [127.0.0.1] (blackbox.fnordora.org [127.0.0.1])
	by clueserver.org (Postfix) with ESMTP id 30D7BF503EC;
	Tue, 13 Jan 2009 16:33:17 -0800 (PST)
In-Reply-To: <20090114000220.GB12624@atjola.homenet>
X-Mailer: Evolution 2.24.2 (2.24.2-2.fc10) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105566>

On Wed, 2009-01-14 at 01:02 +0100, Bj=C3=B6rn Steinbrink wrote:
> On 2009.01.13 15:49:03 -0800, Alan wrote:
> > I have a repository that I need to build a set of patches for a sin=
gle
> > directory path.  (I just want the diffs on the one driver.)
> >=20
> > Is there a clean non-hacky way to do this?
> >=20
> > It is not cross repository or anything. I just need to generate a d=
iff
> > between one commit and another, but only for the contents of a spec=
ific
> > directory.
> >=20
> > I am not finding a real straightforward way to do that.  (Unless I =
am
> > missing something, which is quite possible.)
>=20
> git diff commitA commitB -- some/paths/here some/more/here and/then/s=
ome
>=20
> That limits the diff to the paths after the dashes.

Thanks! That is EXACTLY what I need.
