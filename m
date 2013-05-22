From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] prompt: fix show upstream with svn and zsh
Date: Wed, 22 May 2013 02:20:28 +0200
Message-ID: <20130522002028.GH30969@goldbirke>
References: <1369169667-25166-1-git-send-email-t.gummerer@gmail.com>
 <20130521224119.GF30969@goldbirke>
 <CAMP44s1cbO-xzUAHR4THz4MPdqxY6SHG7uf_da_OM8YCDbTi+A@mail.gmail.com>
 <20130521233617.GG30969@goldbirke>
 <CAMP44s3nMSj5=pr-WmWTd_iUjK4iU_8KnOKHYgRHLAQyyMH9bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 02:20:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UewnE-0005uD-2R
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 02:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636Ab3EVAUc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 May 2013 20:20:32 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:49367 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990Ab3EVAUb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 20:20:31 -0400
Received: from localhost6.localdomain6 (f051105197.adsl.alicedsl.de [78.51.105.197])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0LfYxF-1U8P8X2WcL-00p3NH; Wed, 22 May 2013 02:20:28 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s3nMSj5=pr-WmWTd_iUjK4iU_8KnOKHYgRHLAQyyMH9bA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:vNkiLVnOB8b25l+Dmj5+Vh2TASUq5NJtBy1Nygep4U8
 5PcH94y4WsJeWBKpLhvLUZ9EaHLmFwFWdEEf/naKIufuS4VaAZ
 ywWOBOu4FuTFDaxIqHAg+B8bLue4wazxZePYH4BdCp86cYpE7w
 +5Ok5Zux61yZbI4sqH0F/QeJ+aaJHKwSU/BqXZCzuBFwsSZqTu
 1ShIM5Fm12bumtr+83f2EG+dVxQf3vUAfdrQMAmKJ74DdtcPQy
 o/1eZRtv9bOENiH9vz7Mpuc6w8HLRYP9YjhHGk196NfUz6D9yD
 J5QQkjruAvczfhW2XuCuE1y1JY64Vm383sJoqcLSHTBaBZgPEE
 6UjVugpz6ooBVfAqwMwqdfgFBz0xbF5TENa+K1SEB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225098>

On Tue, May 21, 2013 at 07:03:09PM -0500, Felipe Contreras wrote:
> On Tue, May 21, 2013 at 6:36 PM, SZEDER G=E1bor <szeder@ira.uka.de> w=
rote:
> > On Tue, May 21, 2013 at 06:04:35PM -0500, Felipe Contreras wrote:
> >> On Tue, May 21, 2013 at 5:41 PM, SZEDER G=E1bor <szeder@ira.uka.de=
> wrote:
> >>
> >> > On Tue, May 21, 2013 at 10:54:27PM +0200, Thomas Gummerer wrote:
> >> >> Currently the __git_ps1 git prompt gives the following error wi=
th a
> >> >> repository converted by git-svn, when used with zsh:
> >> >>
> >> >>          __git_ps1_show_upstream:19: bad pattern: svn_remote[
> >> >>
> >> >> This was introduced by 6d158cba (bash completion: Support "dive=
rgence
> >> >> from upstream" messages in __git_ps1), when the script was for =
bash
> >> >> only.  Make it compatible with zsh.
> >> >
> >> > What is the actual cause of this problem/incompatibility and how=
/why do
> >> > these changes fix it?
> >>
> >> I think the commit message makes that very clear.
> >
> > If that were the case I wouldn't have asked in the first place.
>=20
> You are not the authority on what *I think*, or if you meant s/If tha=
t
> were the case/If the message was clear/, still; you are not the
> authority on what is or is not true. Only on what is your opinion.

I would have preferred a more constructive reply, perhaps with answers
to the questions I asked earlier...

Bye,
G=E1bor
