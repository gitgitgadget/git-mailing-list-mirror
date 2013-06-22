From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 1/2] completion: handle unstuck form of base git options
Date: Sat, 22 Jun 2013 14:35:33 +0200
Message-ID: <20130622123533.GJ20052@goldbirke>
References: <adafd1a0c0d7d059d215d9fd1ea68579525efe6e.1371900318.git.john@keeping.me.uk>
 <20130622123033.GI20052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Jun 22 14:35:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqN2a-0005Ls-Lr
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 14:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267Ab3FVMfg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Jun 2013 08:35:36 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:64097 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756024Ab3FVMff (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 08:35:35 -0400
Received: from localhost6.localdomain6 (f051195150.adsl.alicedsl.de [78.51.195.150])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MJVXP-1Uspsk2SZn-002qK3; Sat, 22 Jun 2013 14:35:33 +0200
Content-Disposition: inline
In-Reply-To: <20130622123033.GI20052@goldbirke>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:0SK1K5oP172m1V7azIQfvuOWbQTq38gIZfAf4niF9Rz
 kbyIX2UuHHQYfxcbjyY2LDSLIQSJi77lDH6H7uAdxdVdiGHVIE
 UELfjqW//5CJi/CKc6x37tj3+7ZSUDZRGVp3VV+v8+A/xAzSI4
 yBI+JGrPCQyjeEyuAuggIVcOPRXNEg9Jde9V6gh592lE0EFIxK
 fKcyvB9nrSToMrsXDNt0ge5WwxKJ3h5LW5IpeZEKMn3t4zhaBh
 x42K6yEfhxHOzQTiiIp0kV22dcCKeSLVpe4vQctiE5lNqM+OHK
 lTx0Wjv6Gy4Q/cnXsxVd+cywAuU2fBb56A9NiVGGZnEzhFzZMR
 c4ATUG8n1SBbJQb45XKjTxfFl/L5Q325AKkKq/GAi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228703>

On Sat, Jun 22, 2013 at 02:30:33PM +0200, SZEDER G=E1bor wrote:
> Hi,
>=20
> On Sat, Jun 22, 2013 at 12:25:17PM +0100, John Keeping wrote:
> > git-completion.bash's parsing of the command name relies on everyth=
ing
> > preceding it starting with '-' unless it is the "-c" option.  This
> > allows users to use the stuck form of "--work-tree=3D<path>" and
> > "--namespace=3D<path>" but not the unstuck forms "--work-tree <path=
>" and
> > "--namespace <path>".  Fix this.
>=20
> I never use these commands, so I looked up what --namespace means.
> While doing so I noticed that --exec-path takes a path just like thes=
e
> options, so that option should be handled similarly as well.

Never mind, I misunderstood the docs: --exec-path either takes a path
as --exec-path=3D<path> or it doesn't take one at all, but there is no
'--exec-path <path>'.


G=E1bor
