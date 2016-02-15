From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Custom merge driver with no rename detection
Date: Mon, 15 Feb 2016 09:06:53 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602150854520.2964@virtualbox>
References: <CALMa68ovz=VZYkCcUDvEn1d7=xJDx__71caqsPXUFASZ1phfdw@mail.gmail.com> <xmqqpovyr22u.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-552935812-1455523038=:2964"
Cc: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 09:07:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVEBX-0003Sb-MI
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 09:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbcBOIHC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 03:07:02 -0500
Received: from mout.gmx.net ([212.227.17.20]:50100 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751440AbcBOIHA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 03:07:00 -0500
Received: from virtualbox ([37.24.143.97]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MZ8fw-1aH0BG2Jjg-00KyDP; Mon, 15 Feb 2016 09:06:54
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqpovyr22u.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
Content-ID: <alpine.DEB.2.20.1602150906510.2964@virtualbox>
X-Provags-ID: V03:K0:nR2JQc7bZ/fXRg7n31WEs45C2jP+KfHUq4xnsmrGtd6AzYvdmp3
 wXu5On8Gj6E2MDpi1NfkAuZNOEVH1iIjH1h/3r0A17xXqz3ukrwzlXgH2dwgd1pfb2s6xXF
 y3k48ttODqwqMp5P2EGtAcQUfG7C4TKerlDB9KxSktZ+9km2tHSEIRmv1jvETtttnDsAagJ
 WWlKqqof9XPme9vCzPu/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6e22EUERxxI=:ThoeF3LWWXen9kfQCYKxhL
 8t/6eLSxF/K0CgrS318Qn+ZQFAO5ONC5ZAjGKJYnXxK1RGRR0mqUoJPZT/M9DZD1IDW5OarGy
 4SwIcYiKJ8aet68Ku+NjP92yvsvFOXfoACtTu+9Y4R3cGbNBJXfqPmx7qaVZIDWn/LboFUBR8
 +/HSokKzoLAi5Piq12vP0TqubhcO47diCK5WHjJvQj7ikfTdNGrwr4aI8Pnpn9ef6gmpPBbl1
 cKeBVoyrmJft3ENSthCNqMpfnINN3GLFj1/Xb7bSxt0eODye/DghfDhYR3D5lTSclHrBY8Zwb
 2weO1xXOCWyRaFs4YaJL3MFlcLFh2x7KdADj8pB/4suBjEAW2+cDbfwvtHAjUOWrrmnzVwTpb
 b+jjL/3bobgEvRZQCKLpCvpRBS8XX9TrMMq++Z05Yplmle4lj/eiOJnAH1zMT1R3hXAc4H1zY
 TKQeEglaaFugaXX8CWgJVmQhpGX82R43KLZHKF857RTsa56HOu7V7TzfsctaTZZOvjW84ZuLJ
 x9NOybp7DYukwfjOR4bmXLs0/04YXWjLs6eJaqkcWFtMgpFbncKTUV4XIcpHnlDC3cQhYxihM
 5Tt5+MT9y2rVkyqxVYuMcXvW5voLOhEJ+qryv/jmYJa3L4AyTEvf0IGp2PptrZFy/wu2rw86O
 fsp7RZfzb4awZ46RiZN6R0V78jZ+NYcmE22udcLRr5+2e00J18LSWRwVMD/1CzbpCq89DHNHd
 9duFRTlrmjgCTUCufs8jFeNN5N56cvn67zheRnLOT5Q82jkNax6C7BHruGJM4wWWrzkNg61l 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286181>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-552935812-1455523038=:2964
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.20.1602150906511.2964@virtualbox>

Hi Junio,

On Sun, 14 Feb 2016, Junio C Hamano wrote:

> Felipe Gon=C3=A7alves Assis <felipeg.assis@gmail.com> writes:
>=20
> > The usual workaround is using the resolve strategy, but apparently it
> > ignores the custom merge driver.
>=20
> Hmph.
>=20
> Indeed, git-merge-file seems to call xdl_merge() directly, bypassing
> the ll_merge(), which is understandable as the former predates the
> latter.  That needs to be fixed, I think.

I think this is by design. (Because I designed it.)

The original idea of git-merge-file was to serve as a drop-in replacement
for GNU/BSD merge when you want to avoid to be subject to the vagaries of
the GNU vs BSD implementations.

Ciao,
Dscho
--8323329-552935812-1455523038=:2964--
