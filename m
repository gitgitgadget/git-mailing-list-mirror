From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH 3/3] gitk: Allow displaying time zones from author and
 commit timestamps
Date: Mon, 30 May 2011 17:35:55 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1105301717520.23145@dr-wily.mit.edu>
References: <alpine.DEB.2.02.1101191445130.23868@dr-wily.mit.edu> <m3mxi4yco5.fsf@localhost.localdomain> <20110530061757.GC3723@Imperial-SD-Longsword> <201105300829.52619.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Guirgies <lt.infiltrator@gmail.com>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 23:36:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRA85-0007Un-Ra
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 23:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361Ab1E3VgA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 17:36:00 -0400
Received: from DMZ-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.35]:55852 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752950Ab1E3Vf7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 17:35:59 -0400
X-AuditID: 12074423-b7babae000007c6b-f8-4de40db643a7
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	by dmz-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 1E.14.31851.6BD04ED4; Mon, 30 May 2011 17:35:50 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id p4ULZvd5021054;
	Mon, 30 May 2011 17:35:57 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p4ULZtmT023031
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 30 May 2011 17:35:56 -0400 (EDT)
In-Reply-To: <201105300829.52619.jnareb@gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IR4hTV1t3G+8TX4MY/S4uuK91MFiuuzmG2
	eHVVy2LNkcXsDiweO2fdZfeYu6uP0ePzJrkA5igum5TUnMyy1CJ9uwSujEdfm9gK7vJU9E8O
	b2CcxdXFyMkhIWAicf3ETnYIW0ziwr31bF2MXBxCAvsYJTZMnsII4WxglOhfvAcqs4dJ4u/J
	M2wgLSwC2hKTJi4Es9kE1CTmbpgMNkpEQFXi1oa1jCA2s0COxMnLP1hBbGGBOImJbxcxg9ic
	AkYSXa0/wWp4BRwlrp3Yxg61gFHiacMDsISogK7E5u6lbBBFghInZz5hgRiqLnHg00WoBdoS
	92+2sU1gFJyFpGwWkrJZSMoWMDKvYpRNya3SzU3MzClOTdYtTk7My0st0jXTy80s0UtNKd3E
	CApudhflHYx/DiodYhTgYFTi4eXe/9hXiDWxrLgy9xCjJAeTkijvfa4nvkJ8SfkplRmJxRnx
	RaU5qcWHGCU4mJVEeGe+AyrnTUmsrEotyodJSXOwKInzzpVU9xUSSE8sSc1OTS1ILYLJynBw
	KEnwmgOjWEiwKDU9tSItM6cEIc3EwQkynAdo+E8eoBre4oLE3OLMdIj8KUZFKXFeG5BmAZBE
	RmkeXC8s+bxiFAd6RZhXF6SKB5i44LpfAQ1mAhrc++4hyOCSRISUVANj9WrJEzFZu/Vr39iq
	27xVrb0otjT3/M8tLOyieQ1/W581yM+N0J9X5rY3OOqBw43KVwrCl7+l3I7b84Fzx9MpicFO
	721MlwpHyx1+umHuszOzVoSHTVm8MKXS68myRdd3R+7TOr2Ljy1jjqp9ectTt4Lj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174779>

On Mon, 30 May 2011, Jakub Narebski wrote:
> > > Why not use UTC+N timezone [=E2=80=A6]?
>=20
> I think full specification is UTC+HH:MM or UTC-HH:MM.  GNU date
> understands 'TZ=3DUTC+09:30 date'.

No, that=E2=80=99s not what the letter code in TZ means.  TZ=3DEDT+04:0=
0 means that
  =E2=80=A2 The current time zone is called EDT.
  =E2=80=A2 The current time zone is at offset -04:00 from UTC.  (Note =
the sign=20
    reversal.)
EDT is displayed as the name of the zone and is not used in any=20
calculations; it does not mean we=E2=80=99re taking an offset _from_ ED=
T.

So it doesn=E2=80=99t make sense to write TZ=3DUTC=C2=B1NN:NN for any N=
N:NN other than=20
00:00.  Otherwise libc will happily give you the nonsense that you aske=
d=20
for:
  $ TZ=3DUTC+00:00 date; TZ=3DUTC+09:30 date
  Mon May 30 21:21:32 UTC 2011
  Mon May 30 11:51:32 UTC 2011

This is why I used =E2=80=9CUnknown=E2=80=9D instead of =E2=80=9CUTC=E2=
=80=9D.

(Oh, my comment should have said =E2=80=9CUnknown=C2=B1NN:NN=E2=80=9D i=
nstead of=20
=E2=80=9CUnknown=C2=B1NNNN=E2=80=9D; the code gets it right.)

If I wanted to do better, I=E2=80=99d need a way to translate UTC offse=
ts to zone=20
names, but I don=E2=80=99t know of a canonical way to do that (there=E2=
=80=99s not even a=20
unique answer in general).

In Tcl =E2=89=A5 8.5, none of this matters because =E2=80=98clock forma=
t -timezone=E2=80=99 just=20
uses the numerical UTC offset as the zone name.  For the fallback code,=
 I=20
can=E2=80=99t do that by manipulating TZ, because the zone name needs t=
o be made=20
of letters.

Anders
