From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: English/German terminology, git.git's de.po, and pro-git
Date: Thu, 16 May 2013 11:00:28 +0200
Message-ID: <87wqqze1ub.fsf@linux-k42r.v.cablecom.net>
References: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net>
	<alpine.LNX.2.01.1305131542210.30808@nerf07.vanv.qr>
	<001d01ce500b$c7c08b70$5741a250$@scanmyfood.de>
	<alpine.LNX.2.01.1305132119220.2288@nerf07.vanv.qr>
	<CAN0XMOL3rkYDinSCN2GLaRj7dOvbF=SdMRxM4PHCZ5h7g5Nkkw@mail.gmail.com>
	<51936218.9020306@ira.uka.de> <519370D3.3000306@web.de>
	<CAN0XMOJ7hRwTAR+i8_C2z2NmmcycLQkiya0ayfWS0vAw3-zqkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	"Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>,
	Jan Engelhardt <jengelh@inai.de>,
	Ralph =?utf-8?Q?Hau=C3=9Fmann?= <ralph@scanmyfood.de>,
	Christian Stimming <stimming@tuhh.de>,
	Sven Fuchs <svenfuchs@artweb-design.de>,
	git <git@vger.kernel.org>, Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 11:00:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucu3E-0000N6-Bv
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 11:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807Ab3EPJAg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 May 2013 05:00:36 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:1742 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755758Ab3EPJAe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 May 2013 05:00:34 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 16 May
 2013 11:00:30 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 16 May 2013 11:00:28 +0200
In-Reply-To: <CAN0XMOJ7hRwTAR+i8_C2z2NmmcycLQkiya0ayfWS0vAw3-zqkg@mail.gmail.com>
	(Ralf Thielow's message of "Thu, 16 May 2013 07:57:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224515>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Hi,
>
> I think the discussion might work better via ML than GitHub.
> This is the full glossary of git's de.po as it would look
> like with (hopefully) all the changes included that have been
> discussed here. Still without any reasoning for decisions
> (except HEAD).
[...]
> +    remote branch          =3D externer Zweig
> +    remote tracking branch =3D externer =C3=9Cbernahmezweig

Hrm, before we (erm, you) do any extensive work on redoing the glossary=
,
I think we should step back and agree on a direction.

Remember what this thread started with:

} However, an unfortunate and unsatisfactory situation has developed:
} Christian Stimming's git-gui de.po uses a Ger translation, and Ralf
} Thielow built core git's de.po on top of it, so it's also Ger.
}=20
} Meanwhile, and independently, Sven Fuchs and Ralph Haussmann wrote a
} translation of pro-git (which is also quite mature at this point, hav=
ing
} apparently begun in 2009), and as you probably guessed by now, it's G=
+E.
}=20
} So that leaves us at a point where "the" libre Git book (and also the
} one that happens to be hosted on git-scm.com, the official site) does
} not match the terminology used by German git.
}=20
} Like, at all.  They're not even remotely near each other.

My thinly veiled opinion in the thread starter was that we should redo
git's de.po from scratch using a translation similar to pro-git.

I can accept that discussion takes a different turn, and thus the
translation does something else.  But my impression in the thread so fa=
r
was that:

* Everyone voted for G+E.

* The thread went of on a tangent, bikeshedding on some Ger
  translations.

Please tell me I'm wrong...

Otherwise, assuming any agreement can be reached, IMHO the first step
must be to write/complete a glossary that matches *current usage* in
pro-git.  We can perhaps bikeshed about some glaring issues in the
result, but remember that -- again assuming G+E is the conclusion -- an=
y
such change again either means a divergence between book and git (bad!)
or a lot of work for the book translators.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
