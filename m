From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGit PATCH] IgnoreAction to add to .gitignore files
Date: Thu, 23 Apr 2009 21:19:36 +0200
Message-ID: <200904232119.36707.robin.rosenberg@dewire.com>
References: <20090423115042.743E6D9CDC@apple.int.bandlem.com> <200904231427.29832.fge@one2team.com> <0A94BEDB-37A1-44D2-BE54-D05F0C3124EE@bandlem.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Francis Galiegue <fge@one2team.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Alex Blewitt <alex@bandlem.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 21:21:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx4U2-0001lt-Hi
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 21:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760170AbZDWTTr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2009 15:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760186AbZDWTTq
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 15:19:46 -0400
Received: from mail.dewire.com ([83.140.172.130]:20722 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760164AbZDWTTp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2009 15:19:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id EB8CB14927D6;
	Thu, 23 Apr 2009 21:19:39 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DsKoZyoPPeUp; Thu, 23 Apr 2009 21:19:37 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 99BC814927C9;
	Thu, 23 Apr 2009 21:19:37 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.27-14-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <0A94BEDB-37A1-44D2-BE54-D05F0C3124EE@bandlem.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117369>

torsdag 23 april 2009 14:32:46 skrev Alex Blewitt <alex@bandlem.com>:
> Actually, that's pretty much exactly the format that Eclipse users =20
> will be expecting.
>=20
> CVS: Add to .cvsignore
> SVN: Add to svn:ignore
>=20
> I suggest that we go with that style of format for the menu items, in=
 =20
> order to achieve consistency with the way that the other team =20
> providers work.

Ouch, top posting....

Anyway, I agree  with Alex. My motivation is that there are more
than one way to specify ignore. There's .gitignore, .git/info/excludede=
s
and the Team ignore settings themselves. This option specifically
messes with .gitignore.=20

-- robin

> Note also that the tooltip is usually much shorter than that ... it's=
 =20
> not a full help description, it explains what it does.
>=20
> Alex
>=20
> On 23 Apr 2009, at 13:27, Francis Galiegue wrote:
>=20
> > Le jeudi 23 avril 2009, Alex Blewitt a =E9crit :
> >> diff --git a/org.spearce.egit.ui/plugin.properties
> > b/org.spearce.egit.ui/plugin.properties
> >> index 523a959..be3b40c 100644
> >> --- a/org.spearce.egit.ui/plugin.properties
> >> +++ b/org.spearce.egit.ui/plugin.properties
> >> @@ -52,10 +52,12 @@ FetchAction_tooltip=3DFetch from another repos=
itory
> >> PushAction_label=3D&Push To...
> >> PushAction_tooltip=3DPush to another repository
> >>
> >> +IgnoreAction_label=3DAdd to .git&ignore...
> >> +IgnoreAction_tooltip=3DIgnore the selected resources
> >> +
> >> GitActions_label=3DGit
> >> GitMenu_label=3D&Git
> >>
> >
> > The label and tooltip are too "git-specific", IMHO. I'd rather see:
> >
> > IgnoreAction_label=3D&Ignore file(s) for commits...
> > IgnoreAction_tooltip=3DThe selected file(s) will not be included by=
 =20
> > default in
> > your commits. However, you may force the include of these files in =
a =20
> > commit
> > by explicitly adding them via "Team->Add" [or whatever the label is=
].
> > \n\nSelecting files to ignore by this mechanism will automatically =
=20
> > add one or
> > more files named .gitignore in your next commit.
> >
> > --=20
> > Francis Galiegue
> > ONE2TEAM
> > Ing=E9nieur syst=E8me
> > Mob : +33 (0) 683 877 875
> > Tel : +33 (0) 178 945 552
> > fge@one2team.com
> > 40 avenue Raymond Poincar=E9
> > 75116 Paris
>=20
>=20
