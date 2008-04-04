From: =?iso-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre_rosa@lge.com>
Subject: RES: [REGRESSION] git-gui
Date: Fri, 4 Apr 2008 08:20:43 -0300
Message-ID: <00e801c89645$ee77fd50$93a7c10a@LGE.NET>
References: <007901c89590$a827f7c0$93a7c10a@LGE.NET> <57518fd10804030700r6de977f5p6f0418e6eaea2583@mail.gmail.com> <200804032304.17054.barra_cuda@katamail.com> <57518fd10804031615m5c299df6hf31de3c689e16521@mail.gmail.com> <20080404012723.GL10274@spearce.org> <20080404013356.GM10274@spearce.org> <20080404110201.GA8298@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "'Jonathan del Strother'" <maillist@steelskies.com>,
	"'Michele Ballabio'" <barra_cuda@katamail.com>,
	<git@vger.kernel.org>
To: "'Marco Roeland'" <marco.roeland@xs4all.nl>,
	"'Shawn O. Pearce'" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Apr 04 13:22:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhjzI-0006wF-5E
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 13:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbYDDLUz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Apr 2008 07:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752400AbYDDLUz
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 07:20:55 -0400
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:49491 "EHLO
	LGEMRELSE6Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbYDDLUz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Apr 2008 07:20:55 -0400
X-AuditID: 9c930179-a3aedbb0000031bc-54-47f60f0f14a4
Received: from SPSSO10NA0679 (unknown [156.147.140.121])
	by LGEMRELSE6Q.lge.com (Symantec Mail Security) with ESMTP id 63015420002;
	Fri,  4 Apr 2008 20:20:44 +0900 (KST)
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AciWPJhzIqpUZ/GpQiuQ6fT0zuh6OAABvY3g
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
In-Reply-To: <20080404110201.GA8298@fiberbit.xs4all.nl>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78801>

> Hmm, maybe I should offer the patch.  :-)
>=20
> --8>--
> Subject: [PATCH] git-gui: Switch keybindings for [ and ] to=20
> bracketleft and bracketright
>=20
> Thanks to Michele Ballabio for the quick fix.
> This resolves the error introduced by c91ee2bd61.
>=20
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

> This solves the problem on Debian GNU/Linux 'sid', with Tcl/Tk versio=
n
8.5.1. So somehow the Linux implementation seems to be the problem, not=
 the
Tcl/Tk version as > such. Man keysyms here does list "bracketleft" and
"bracketright" but no direct symbols for '[' or ']'. Thanks!

It solves the issue indeed. Please apply.

Thank you all,
Andr=E9
