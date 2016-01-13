From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/3] pull: allow interactive rebase with
 --rebase=interactive
Date: Wed, 13 Jan 2016 13:13:57 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601131313270.2964@virtualbox>
References: <cover.1452612112.git.johannes.schindelin@gmx.de> <cover.1452668201.git.johannes.schindelin@gmx.de> <2ebf99214ba600b63a39c58bcb9abb7941a7619d.1452668201.git.johannes.schindelin@gmx.de>
 <CACRoPnS_CcAuu_jBo9zcjycSN4kvSQhCONNYnY1XRnarRF9Zmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 13:14:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJKJn-0000DT-To
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 13:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbcAMMOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 07:14:23 -0500
Received: from mout.gmx.net ([212.227.15.18]:58399 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701AbcAMMOW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 07:14:22 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MGBB1-1aMICH2Oj1-00FBAX; Wed, 13 Jan 2016 13:13:58
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CACRoPnS_CcAuu_jBo9zcjycSN4kvSQhCONNYnY1XRnarRF9Zmw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:CdI75lfwnQ5oAPnnMDbdKR4nYYHMTAuLCaBXzlaihziM0x4Hjsw
 a+g93ATEokwNGxCNeLFXgvK+EFYRAUNwE6SWpo73unJZ5o+feQ91KPSKfvBAmGhtBCXn+Fd
 +WEYRH+lKhYmOKWs4SN/975nrDRWUL0mdil4xLrhcm68jVgn/NUi8d6v4qM6M7YuaKshOD+
 ds7IC4ISiZ5xavkmTsSzA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6UDUhnflUrw=:gFpB+3wau8IOTS5ZdxmQBS
 H7IkCWspjV0Y/zlmR5MR5LXftad0ARmCp8ToNMGYyj1OHuAHeZ8OYUiyCRVQY3ZxV3JCPtBH/
 okJorrz+E6VsioKsi31Rky8WqdOJNAm5kYd2w4oG8HwDuonCSFSnQ2ELPRA8Hct/QGwNHckr0
 /LL7z+S1UoSEPqlVOz+PQSLFZ4nxgYDu5F19XDNMWnjEROWvIK31cLdfCSCbp6AbhmWhUk5x8
 K0zHLzbnYf4ePs0wJph48wndjaFsR8VHXYMZUeaYvq2kKNtmVpZ0S8ecO8SEZKWIg4p+MJJ3m
 8Etx6vK8nKfak1iLxIFu4MGnuYQzlFKp+1HefLmAbiE90yctIKeFZGmg1mafpx2z0gqh/6KdC
 0r4eEpuGTiLiJ/JIj38gagzdZ4sbBmQymipdd30vy04uDjeGWwwWvSblD1PvsEFNKnHuSHsWU
 fUU6StdCUpyHVQX4xoHRLysLzrkfjNxHz68nErfI6KCewMniJDXq8UfUy8GKxxzvBKVmYTJ82
 Ap65GmwrlxgcB/FjZ1C55+oe+m2M18IIewyxakrOTuR/yb7B1Qz2SftOvU7fSneFpjQD/39W3
 i4aSjFMIYlh56K5qtKbkTdzc32Ax67YGc4xTLDeXHx3NRMbpjv4Pgh3i79fQZTg1D0gCVCRU0
 4iGH6LJTLcZ1EVHWUIARrOOf/0tqFfPNl8fOKt8F1OBA89m3tjFie1/rMTzJ6Ke3JggZepecy
 zgC/2EEUQop6w8niq3MnhuHF3jtuL/7nJBwKlwhiJg1mQvQ3JOvi3F8ZMQFqCtSB1ZAwaT0A 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283903>

Hi Paul,

On Wed, 13 Jan 2016, Paul Tan wrote:

> On Wed, Jan 13, 2016 at 2:57 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index 07f7a3b..e5897e9 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -865,6 +865,7 @@ branch.<name>.rebase::
> >         instead of merging the default branch from the default remote when
> >         "git pull" is run. See "pull.rebase" for doing this in a non
> >         branch-specific manner.
> > +       When the value is `interactive`, the rebase is run in interactive mode.
> >  +
> >  When preserve, also pass `--preserve-merges` along to 'git rebase'
> >  so that locally committed merge commits will not be flattened
> 
> I think this change needs to be repeated for the section on
> "pull.rebase" as well.
> 
> > [...]
> > --
> > 2.6.3.windows.1.300.g1c25e49
> 
> Other than that, builtin/pull.c has the following option definition
> that needs to be updated:
> 
> { OPTION_CALLBACK, 'r', "rebase", &opt_rebase, "false|true|preserve",
> N_("incorporate changes by rebasing rather than merging"),
> 
> The "false|true|preserve" needs to be updated to
> "false|true|preserve|interactive", I think.

Good points, both. Fixed in the upcoming v3.

Ciao,
Dscho
