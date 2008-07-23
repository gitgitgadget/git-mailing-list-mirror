From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@fzi.de>
Subject: Re: git-svn - failed to clone repository
Date: Wed, 23 Jul 2008 19:08:38 +0200
Message-ID: <20080723170838.GK22606@neumann>
References: <20080723160659.GB6705@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Derek Fawcus <dfawcus@cisco.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 19:09:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLhqM-0005kH-WA
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 19:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbYGWRIk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 13:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbYGWRIj
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 13:08:39 -0400
Received: from francis.fzi.de ([141.21.7.5]:43077 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752597AbYGWRIj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 13:08:39 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 23 Jul 2008 19:08:37 +0200
Content-Disposition: inline
In-Reply-To: <20080723160659.GB6705@cisco.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 23 Jul 2008 17:08:37.0677 (UTC) FILETIME=[BF55E5D0:01C8ECE6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89715>

On Wed, Jul 23, 2008 at 05:06:59PM +0100, Derek Fawcus wrote:
> I tried to create a clone of an svn repository,  and it gave
> up part way through with the following error:
>=20
>   Incomplete data: Delta source ended unexpectedly at /usr/bin/git-sv=
n line 3858
>=20
> Looking at the source,  this is the call '$reporter->finish-report($p=
ool)'
> near the end of gs_do_update.
>=20
> This is using git 1.5.6 from the etch backports repository.
>=20
> The repository in question was cocotron,  the command being:
>=20
>   git svn clone http://cocotron.googlecode.com/svn -t tags -b branche=
s -T trunk
It might not help you, but with svn version 1.4.6 (r28521) (from
Ubuntu 8.04) and current git master the above command has just
finished successfully.

G=E1bor
