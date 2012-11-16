From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] tcsh-completion re-using git-completion.bash
Date: Fri, 16 Nov 2012 22:22:24 +0100
Message-ID: <20121116212224.GA12052@goldbirke>
References: <1352980269-15569-1-git-send-email-marc.khouzam@gmail.com>
 <CAMP44s0Guq0nYJEfbvNDyt8Oqaux-cXbTsyro6pxUnEpA4+XOw@mail.gmail.com>
 <CAFj1UpEdft+L5KW+tMy6Lqm1eUkHQgwWuXaC0UTUdqwW=ohk-Q@mail.gmail.com>
 <CAMP44s1RtOj6LKCNJ8SX8KSA8eNCMZ+4D-VfQ+WtXju-KhG8ng@mail.gmail.com>
 <CAFj1UpHLf2je_+b1e5B_5thZ03UYVmW=CWhAh63kNRCbke0kQw@mail.gmail.com>
 <CAMP44s1RvMSBu2RJqKw9ne4cJyMO4dbFc-gW2HgsN2-uviv=fA@mail.gmail.com>
 <CAFj1UpHMc-bHJgSZKY13YH_69TXkz-50g5xpLA6C+Eh0aqcN9A@mail.gmail.com>
 <CAMP44s3S4c7ciJNurxGdS2o_TDJJDkGK73dtCGji+C1NoV+Jvw@mail.gmail.com>
 <20121116204017.GX12052@goldbirke>
 <CAMP44s2UVGKa7XkqPxdxQ2ueSMn=Xn4qihy5JWbDovH85n8BwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Khouzam <marc.khouzam@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 22:22:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZTN9-0000Q2-Fz
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 22:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545Ab2KPVWe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2012 16:22:34 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:59739 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab2KPVWd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 16:22:33 -0500
Received: from localhost6.localdomain6 (p5B130644.dip0.t-ipconnect.de [91.19.6.68])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0M1XiL-1TKGvx3Rd3-00tSqW; Fri, 16 Nov 2012 22:22:25 +0100
Content-Disposition: inline
In-Reply-To: <CAMP44s2UVGKa7XkqPxdxQ2ueSMn=Xn4qihy5JWbDovH85n8BwQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:nH/dueznUtw9yT27OMVXwyvN/wsDYnOdsACNMvAKSzd
 K5fAxw4jgjkOOcNiLZyDT0cOrjY6HnnaLOXSXnlmIkPKhExsy/
 Syn+83M/Av1hDh+i1SNIUD9N9Z1G7GRoJRVxRD+GDUV/Eiaemm
 LNuXfvEny1J26FrlYAfxGSbuqIeQQ5UUMAHcscKonN+uokcYUG
 dhsD+bGGO7OixRYv80+V7xxC5dsFMeBE7dizWDxHU4u8JTtukd
 rp8GSCIZPURQpxT2zoRTW0JPX6aR9wCBQc2Kk3MQZ1NEHIr5Z2
 gbIt5Rz0yKcgIxL5+kfnTP+uP5yKT+3rxPaFSMxQoMU+tQbjfM
 TCEELtGg9kYOzQRufDpBZQrGHHj80Iz2jnRGGs3so
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209914>

On Fri, Nov 16, 2012 at 10:03:41PM +0100, Felipe Contreras wrote:
> On Fri, Nov 16, 2012 at 9:40 PM, SZEDER G=E1bor <szeder@ira.uka.de> w=
rote:
> > On Fri, Nov 16, 2012 at 09:04:06PM +0100, Felipe Contreras wrote:
> >> > I agree, and this is why I made the proposed
> >> > __git_complete_with_output () generic.  That way it could be
> >> > used by other shells or programs.  But at this time, only tcsh
> >> > would make use of it.
> >> >
> >> > If you think having __git_complete_with_output () could
> >> > be useful for others, I think we should go with solution (A).
> >> > If you don't think so, or if it is better to wait until a need
> >> > arises first, then solution (C) will work fine.
> >
> > I think it would be useful.
>=20
> For what?

=46or zsh.

> >> I don't see how it could be useful to others, and if we find out t=
hat
> >> it could, we can always move the code.
> >
> > For zsh, perhaps?
>=20
> Nope.

Sure.

> > As I understand the main issues with using the completion script wi=
th
> > zsh are the various little incompatibilities between the two shells
> > and bugs in zsh's emulation of Bash's completion-related builtins.
> > Running the completion script under Bash and using its results in z=
sh
> > would solve these issues at the root.  And would allow as to remove
> > some if [[ -n ${ZSH_VERSION-} ]] code.
>=20
> We can remove that code already, because we now have code that is
> superior than zsh's bash completion emulation:
>=20
> http://article.gmane.org/gmane.comp.version-control.git/208173

Which depends on the completion script having a wrapper function
around compgen filling COMPREPLY.  However, COMPREPLY will be soon
filled by hand-rolled code to prevent expansion issues with compgen,
and there will be no such wrapper.

> This is the equivalent of what Marc is doing, except that zsh has no
> problems running bash's code. Note there's a difference with zsh's
> emulation bash (or rather bourne shell, or k shell), and zsh's
> emulation of bash's _completion_. The former is fine, the later is
> not.

There are a couple of constructs supported by Bash but not by zsh,
which we usually try to avoid.
