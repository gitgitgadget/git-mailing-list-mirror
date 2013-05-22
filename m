From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: override merge.ff =?UTF-8?Q?=3D=20false=20using=20--ff-only?=
Date: Wed, 22 May 2013 15:36:50 +0200
Organization: OPTEYA
Message-ID: <428ac6eff0b1a118a9b09f0835ab65b5@meuh.org>
References: <CAJELnLEGCshD9z9get62+T6Z83OdPJ+A5BNSzsHA1_OC1Q00Hw@mail.gmail.com>
 <CAJELnLFqzVBd57vudsCFrTNMVxETO75GT5T5NO0sDMtgHZJU6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Matt McClure <matthewlmcclure@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 15:59:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf9Zf-0004ik-9k
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 15:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326Ab3EVN7X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 May 2013 09:59:23 -0400
Received: from mx-out.ocsa-data.net ([194.36.166.37]:50855 "EHLO
	mx-out.ocsa-data.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018Ab3EVN7W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 09:59:22 -0400
X-Greylist: delayed 1350 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 May 2013 09:59:22 EDT
Received: from [192.168.111.12] (helo=rc.ouvaton.coop)
	by mx-out.ocsa-data.net with esmtpa (Exim - FreeBSD Rulez)
	id 1Uf9Dm-000DhG-8A; Wed, 22 May 2013 15:36:50 +0200
In-Reply-To: <CAJELnLFqzVBd57vudsCFrTNMVxETO75GT5T5NO0sDMtgHZJU6g@mail.gmail.com>
X-Sender: ydroneaud@opteya.com
User-Agent: Roundcube Webmail/0.8.4
X-abuse-contact: abuse@ocsa-data.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225159>

Hi,

Le 22.05.2013 15:21, Matt McClure a =C3=A9crit=C2=A0:
> I naively tried to override merge.ff =3D false using --ff-only on the
> command line. I expected that it would override the configured=20
> default
> and perform a fast-forward merge. Instead, it said:
>
>     $ git config -l | grep -F 'merge.ff'
>     merge.ff=3Dfalse
>
>     $ git merge --ff-only foo
>     fatal: You cannot combine --no-ff with --ff-only.
>
> On the other hand, I see that --ff works just fine in the same=20
> initial state.
>

You might want to read the following messages from thread "git merge=20
<tag> behavior"

http://article.gmane.org/gmane.comp.version-control.git/218519
http://article.gmane.org/gmane.comp.version-control.git/218755
http://article.gmane.org/gmane.comp.version-control.git/218786


Regards.

--=20
Yann Droneaud
OPTEYA
