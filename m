From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Wed, 23 Jul 2008 15:56:21 +0200
Message-ID: <20080723135621.GJ22606@neumann>
References: <20080723130518.GA17462@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Jul 23 15:57:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLeqJ-0001fc-Fw
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 15:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbYGWN4X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 09:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbYGWN4X
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 09:56:23 -0400
Received: from francis.fzi.de ([141.21.7.5]:14799 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751772AbYGWN4W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 09:56:22 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 23 Jul 2008 15:56:20 +0200
Content-Disposition: inline
In-Reply-To: <20080723130518.GA17462@elte.hu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 23 Jul 2008 13:56:20.0962 (UTC) FILETIME=[E2EAE420:01C8ECCB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89654>

Hi,

On Wed, Jul 23, 2008 at 03:05:18PM +0200, Ingo Molnar wrote:
> I've got the following, possibly stupid question: is there a way to=20
> merge a healthy number of topic branches into the master branch in a=20
> quicker way, when most of the branches are already merged up?
>=20
> Right now i've got something like this scripted up:
>=20
>   for B in $(git-branch | cut -c3- ); do git-merge $B; done=20
you cound use 'git branch --no-merged' to list only those branches
that have not been merged into your current HEAD.


=DCdv,
G=E1bor
