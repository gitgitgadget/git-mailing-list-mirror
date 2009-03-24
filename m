From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [RFC/PATCH 7/8] user-manual: add global config section
Date: Tue, 24 Mar 2009 18:42:35 -0400
Message-ID: <20090324224235.GS19389@fieldses.org>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-4-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-5-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-6-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-7-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-8-git-send-email-felipe.contreras@gmail.com> <20090324215223.GL19389@fieldses.org> <94a0d4530903241517g1453033fs2c02de631595f7e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 23:44:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmFMX-000591-RG
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 23:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbZCXWmj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 18:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbZCXWmi
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 18:42:38 -0400
Received: from mail.fieldses.org ([141.211.133.115]:54467 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbZCXWmh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 18:42:37 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1LmFKN-0006Xb-VC; Tue, 24 Mar 2009 18:42:35 -0400
Content-Disposition: inline
In-Reply-To: <94a0d4530903241517g1453033fs2c02de631595f7e9@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114506>

On Wed, Mar 25, 2009 at 12:17:12AM +0200, Felipe Contreras wrote:
> On Tue, Mar 24, 2009 at 11:52 PM, J. Bruce Fields <bfields@fieldses.o=
rg> wrote:
> > On Sun, Mar 22, 2009 at 08:05:20PM +0200, Felipe Contreras wrote:
> >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> >> ---
> >> =C2=A0Documentation/user-manual.txt | =C2=A0 34 ++++++++++++++++++=
++++++++++++++++
> >> =C2=A01 files changed, 34 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/Documentation/user-manual.txt b/Documentation/user-ma=
nual.txt
> >> index 3278aa7..b7678aa 100644
> >> --- a/Documentation/user-manual.txt
> >> +++ b/Documentation/user-manual.txt
> >> @@ -40,6 +40,40 @@ without any explanation.
> >> =C2=A0Finally, see <<todo>> for ways that you can help make this m=
anual more
> >> =C2=A0complete.
> >>
> >> +[[getting-started]]
> >> +Getting started
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +You can skip this section safely, however, configuring git at an =
early stage
> >> +would probably make your overall experience with it more pleasant=
=2E Also many
> >> +parts on this manual would be easier to grasp.
> >
> > I'd skip this first paragraph.
>=20
> Ok. I was regretting it even as I was writing it :p
>=20
> >> +
> >> +Git's configuration is distributed on different locations: 'syste=
m', 'global', and
> >> +'repository'. Variables are stored in the form of 'foo.bar', and =
the precedence
> >> +order is 'repository' > 'global' > 'system'.
> >
> > "distributed on" isn't right ("among" instead of "on" might work). =
=C2=A0It's
> > not obvious to me what ">" means in terms of precedence. =C2=A0And =
I'm not
> > sure the comment about the form conveys any useful information. =C2=
=A0Also, I
> > think the systemwide configuration is less important, and could be =
left
> > to the man page.
>=20
> Ok. That would make it easier.
>=20
> How about:
> Git's configuration is distributed among different locations--on this
> manual we are only going to deal with 'global' and 'repository', wher=
e
> 'repository' variables take precedence over 'global' ones.

Sounds OK, but "on this" should be "in this", or even simpler just:
"this manual will only deal with...".  And then 'global' and
'repository' aren't really nouns on their own (what are they
modifying?).  So maybe: "deal with 'global' and 'repository' variables"=
?

>=20
> >> +
> >> +You would probably want to start setting up something useful:
> >> +------------------------------------------------
> >> +$ git config --global color.ui auto
> >> +------------------------------------------------
> >> +
> >> +This will make prettier the output of certain commands such as `g=
it diff`, but
> >> +that's not important; what is important here is that `color.ui` h=
as been
> >> +stored in the 'global' (for the user) configuration.
> >> +
> >> +You can take a look and manually modify the configuration with th=
e `--edit`
> >
> > "take a look and" isn't really necessary; either eliminate it or re=
place
> > it by "view and" or just "also".
>=20
> I like "View and".

OK.  Thanks!--b.
