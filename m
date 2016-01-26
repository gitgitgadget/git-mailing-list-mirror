From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 17/19] mingw: fix git-svn tests that expect chmod to
 work
Date: Tue, 26 Jan 2016 07:31:27 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601251910080.2964@virtualbox>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <9045a31ec16da672a74d9b1e0b65807d21ef277e.1453650173.git.johannes.schindelin@gmx.de> <xmqq1t96be2k.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-202260969-1453789888=:2964"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 07:31:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNxAB-0008MH-PP
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 07:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755396AbcAZGbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 01:31:36 -0500
Received: from mout.gmx.net ([212.227.15.18]:62164 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755390AbcAZGbf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 01:31:35 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M7Yhz-1a91Lb38WF-00xKkN; Tue, 26 Jan 2016 07:31:28
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq1t96be2k.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:zIjhcpAe6tBsIYp1iMMmPIwBBQRWk37gGkVbVi0d30LRXi0Ho+i
 rfIkCuYYS+zPl97191siV7YSUgVQ+eOicDSsLueUGk/brCJdHSoYKTUYy8ZEu6Lfwmd+rEO
 h4Bu53NZfQA++01/85nazKkF9wczE7SoapXN/Bpg4DjNnUxmefpXwmW84vsZSG1TeQeJ0db
 5NzboeKoyuxP9jSPN4jIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hUH49q8eMNc=:kPMKhjww+2f1f1shCuU/i+
 UJmNXk3G6WskKJkUDs7H50E1k5ldlUU2XrAVaM/aYYVDM4ZdHcLGNNd0eRCCvxhs0aoPHmnt4
 hc+FEgIKAnPUzhTJYzeo6SS+KirHPozjZ9GISNyApAOkIX7oT+sHJEO3Xv+0szPS+YYqAZ9a2
 acqyd9ecabYaEKJO1zMt2QyXIj08+LoUT3OTQrucUm/g9HUyf5kXMfQ2jCaJZsNwvateCosGB
 1LSdOwda+5hxHZxHpnij3MmBg2SenWrdHE+1SkCiiQw6WGuBsU/SaAiidSOzFB/PHFq1Q+DuT
 o1suFyIlcwjJxKAb7DDLECF2s5ajS/DOLSAI74QHcgc/Qz6UZd0vH7A7nvEaeQ9e7nIvW7SK4
 k+pjJjUrtVknWTqXYQNgKHqiAwokHAUu3sGjHe/Y1uSEPxtVrmihkwMfuqW59s9NIo+lum+sa
 EP+eP5uM5HJ2DbfHwz9sHBVqoXs/Enofn1FofdGShNLxHT7YQo4bmebIDcstuHlcdwbA1GQk9
 UTL9kfybOQpdnE202TOVfxD5EfrPutuEwGuDVLZukkqoBdsKZeLxQWqjdd02SzChFbX177c0r
 egx8khgxZkd7cjOXpMMqhUaX7mpNldKaB7Do41GX5/p76NVu75Cbrmr1XqTq6vxj7C+AadFEs
 Cs0yOBZY0PlzeZiYVj8P6o4sxTUCnbmYjuLG1SKJgPXe9MvHtnvl9/RUJ+Vlsx2Wc2IolpkXe
 sRWYZAyALVZLTmiWhvADfdWozVj8jWsh6E87X+xmlC0QyMEFfzx9P0gRh/1uIMQ6DDJXeN/E 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284779>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-202260969-1453789888=:2964
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Sun, 24 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>=20
> > From: =EB=A7=88=EB=88=84=EC=97=98 <nalla@users.noreply.github.com>
> >
> > Some git-svn tests expect that the executable bit of files can be
> > toggled. On Windows, this is not possible because Windows' Access
> > Control Lists are much more fine-grained than the POSIX permission
> > concept. Let's just not try to flip the executable bit.
>=20
> Most of the changes are protected by !POSIXPERM but one of them
> seems to use MINGW, which looks inconsistent and I suspect was not a
> distinction made on purpose.  The above description sounds to me
> that the !POSIXPERM prerequisite is the right thing to use.

This is my fault: there are two MINGW prereqs, and they guard against
trying to work with file names ending in a dot (which is illegal on
Windows' file systems).

My original plan was to split the patch into two, but I actually reworked
the patch from scratch.

> I am not sure if it is a good idea to sprinkle test-have-prereq and
> make the test script test different things on different platforms,
> though.

I agree that this is not desirable, and I changed it where possible to
simply skip the entire test case. In some cases, however, the 'setup' test
case was affected, and of course we cannot skip that one, else everything
falls apart.

The result of my work consists of these three patches (which will be part
of v2):

=09https://github.com/dscho/git/compare/ea813597~3...ea813597

Thanks,
Dscho
--8323329-202260969-1453789888=:2964--
