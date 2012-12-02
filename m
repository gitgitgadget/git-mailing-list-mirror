From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v5 0/2] submodule update: add --remote for submodule's
 upstream changes
Date: Sun, 02 Dec 2012 20:32:19 +0100
Message-ID: <50BBACC3.1070504@web.de>
References: <CABURp0oSo9ACFKkBEK1_qNu2mEAu1=nUJxnROaRsXiaWvHih=w@mail.gmail.com> <cover.1354130656.git.wking@tremily.us> <20121129191326.GC27409@odin.tremily.us> <CABURp0piLAG+hEsav-uro+nq9ZRZ9CFFjVG8VKYk3ZtYvRi8=A@mail.gmail.com> <20121130032719.GE29257@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Dec 02 20:32:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfFHU-00028G-Tt
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 20:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835Ab2LBTcc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Dec 2012 14:32:32 -0500
Received: from mout.web.de ([212.227.15.3]:63601 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846Ab2LBTcc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2012 14:32:32 -0500
Received: from [192.168.178.41] ([91.3.176.235]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0M1FqS-1TLMuM1QpE-00tj1r; Sun, 02 Dec 2012 20:32:30
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121130032719.GE29257@odin.tremily.us>
X-Enigmail-Version: 1.4.6
X-Provags-ID: V02:K0:31eJhIinEjST+mMpcZICjJ1dIcj2KG/ZUBChM6Z/5rq
 NyVTOQqMa2DkMQUgEjwydADdhzkrQfvQEwMtccGf9gX7G/GYh2
 lnvpu3Sd1RPiEzAlQP8OCykKhFDybeq8rcm+y21aP/APmScsaP
 CtW8TLCGPFo91siH2A2sByGzV5uVvLofrZWEUCRY/IIvcEI+iG
 BKsCXJCcNX13CG6jQt/6w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211015>

Am 30.11.2012 04:27, schrieb W. Trevor King:
> On Thu, Nov 29, 2012 at 08:11:20PM -0500, Phil Hord wrote:
>> On Thu, Nov 29, 2012 at 2:13 PM, W. Trevor King <wking@tremily.us> w=
rote:
>>> On Thu, Nov 29, 2012 at 01:29:12PM -0500, Phil Hord wrote:
>>>> But I really don't want to figure out how to handle submodule
>>>> collisions during a merge (or rebase!) of my superproject with cha=
nges that
>>>> someone else auto-committed in his local $superproject as he and I
>>>> arbitrarily floated up the upstream independently.  There is nothi=
ng but
>>>> loathing down that path.
>>>
>>> This is true.  I'm not sure how gitlink collisions are currently
>>> handled=E2=80=A6
>>
>> They've always been trouble for me.  But it may be that I am ignoran=
t.
>=20
> I haven't dealt with any gitlink merges, but I think that supporting
> easy gitlink merges is orthogonal to this --remote option.  For simpl=
e
> cases like "autocommitted submodule floats", one of the conflicting
> gitlinks will be an ancestor of the other, so it should be easy to
> automate that merge.

Submodule merges where one submodule commit is the ancestor of the
other are already resolved automatically in recent git. So Phil's
example will just work as long as only fast-forward merges are needed.
