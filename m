From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 1/2] git-prompt.sh: strip unnecessary space in prompt
 string
Date: Mon, 13 May 2013 13:05:51 +0200
Message-ID: <20130513110551.GT2331@goldbirke>
References: <1368289513-8700-1-git-send-email-artagnon@gmail.com>
 <1368289513-8700-2-git-send-email-artagnon@gmail.com>
 <7v61ynsci8.fsf@alter.siamese.dyndns.org>
 <CALkWK0m0dT-sX=nu5jaDj=y1oOSo0cRKQ=2K_S-yepnsm8ny7A@mail.gmail.com>
 <20130513091718.GA21636@goldbirke>
 <CALkWK0m+mG39W7RqU-9KfPWLnaey5pL+jvfdZg49ixsASE+QoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 13:06:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbqZw-0000Ly-4S
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 13:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417Ab3EMLGA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 May 2013 07:06:00 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:50690 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab3EMLF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 07:05:59 -0400
Received: from localhost6.localdomain6 (goldbirke.fzi.de [141.21.50.31])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MBZ3e-1UmKyU0U2o-00AVOC; Mon, 13 May 2013 13:05:52 +0200
Content-Disposition: inline
In-Reply-To: <CALkWK0m+mG39W7RqU-9KfPWLnaey5pL+jvfdZg49ixsASE+QoQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:HrTA/+m13GbChEAe2i1yOf80ro9lwN4mS+W34//9T15
 SlYzVcTODuWMjmP802u5k6kTXjV76Lyx44QBnVEQ8TymSC8Wf+
 r9rpczSuFjsouoFxqsfWKO7BrEWzWPQoWY+PpZ8jXIIUc0v/Ju
 RXFYvmpdvvhCoHMAp7Llxoy1iN+cbf88vc4E58/wbFoRyiQT8i
 STyq7nxQLJRR+4mnfepjmxJFD95BmVEiJhiLw6XinnjXzkO7yo
 5vvVH5Mr33iu1/ZAIPkPHgrCfv6RphlQ1dyLZ8fuz0MDF1Vg9H
 SpTX6IBWemKTizI7rg7oYGr6Vkt5xJ8FJc2r0zLoEk2Yiia6mn
 M8Jl3HlkIPs9O4b0MJpk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224119>

On Mon, May 13, 2013 at 03:43:43PM +0530, Ramkumar Ramachandra wrote:
> SZEDER G=E1bor wrote:
> > Don't forget that others might use a different prompt format and us=
ing
> > colors in the prompt is optional.  With the default prompt format a=
nd
> > without colors I find that that space definitely helps readability.
>=20
> I'm finding it hard to believe that anyone would want to use a colorl=
ess prompt.

Well, back then I was shell-shocked to find that there are people who
want colors in their prompt ;)

> > IMHO that's just ugly ;)
>=20
> If we can agree that it's just a matter of taste, we should both be
> able to have what we want.  Any suggestions on how to make this
> configurable?

The same way we make other things configurable in the prompt: specify
the GIT_PS1_HIDESTATESEPARATOR or something similar variable to strip
that space from the prompt.
