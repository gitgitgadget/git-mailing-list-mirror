From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: Re: I18N.pm is incompatible with perl < 5.8.3
Date: Thu, 2 Feb 2012 22:23:31 +0100
Message-ID: <4F2AFED3.6090605@statsbiblioteket.dk>
References: <4F2A8B78.6090902@statsbiblioteket.dk> <CACBZZX5YuN8vpmTiP_38Aa=c3KDqEHCKBX3DE2YKkeMCdR4GBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 22:23:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt48M-0007dU-KZ
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 22:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757071Ab2BBVXe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 16:23:34 -0500
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:32931 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756498Ab2BBVXd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 16:23:33 -0500
Received: from [130.225.25.159] (130.225.25.159) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.3.213.0; Thu, 2 Feb 2012 22:23:31 +0100
User-Agent: Thunderbird 2.0.0.24 (X11/20111118)
In-Reply-To: <CACBZZX5YuN8vpmTiP_38Aa=c3KDqEHCKBX3DE2YKkeMCdR4GBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189710>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, Feb 2, 2012 at 14:11, Tom G. Christensen
> <tgc@statsbiblioteket.dk> wrote:
>> Hello,
>>
>=20
> Thanks Tom, I'll submit a patch for that. Does this work, i.e. does
> 5.8.3 need *{import} =3D instead of *import =3D ?
>=20
<snip>
I applied the patch and have run the test with perl 5.8.0 (el3) and=20
5.8.5 (el4) and it passes the test on both versions.

I noticed an additional problem which is that Git/I18N.pm is not=20
installed when NO_PERL_MAKEMAKER is used.
It looks like perl/Makefile did not get updated when Git/I18N.pm was=20
added to perl/Makefile.PL.

In perl 5.8.0 ExtUtils::MakeMaker is too old (6.03) to be used with=20
perl/Makefile.PL.

-tgc
