From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Sun, 04 Oct 2015 14:51:22 +0200
Organization: gmx
Message-ID: <e8f26179dc4f590073efc8a2f1bf23d2@dscho.org>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
 <xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
 <1443150875.3042.3.camel@kaarsemaker.net>
 <699c08632232180166145f70c7f16645@dscho.org>
 <CAE5ih7_f8qy9WvmgRUR6-qFwB4WFhZ6Qr5iOpE0YxqJH8AsZyw@mail.gmail.com>
 <vpq7fnc83ki.fsf@grenoble-inp.fr> <vpq4mie1m3n.fsf@grenoble-inp.fr>
 <xmqqlhbqcrf7.fsf@gitster.mtv.corp.google.com>
 <CAFY1edZSNKepx_+2U=C-raOBiVK3Zh2r_Y_NO2-RtbhH_n-tdg@mail.gmail.com>
 <CAPc5daXkn=C-D5RQCw2w+JrHn7XZA6X-P4F-PugRe-S4Z2RO0g@mail.gmail.com>
 <xmqq612n2z3d.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Roberto Tyley <roberto.tyley@gmail.com>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Luke Diamand <luke@diamand.org>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 04 14:51:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiilS-00004r-05
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 14:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbbJDMvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 08:51:36 -0400
Received: from mout.gmx.net ([212.227.17.20]:58050 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412AbbJDMvf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 08:51:35 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MKu9E-1ZiilD0OyO-0000iH; Sun, 04 Oct 2015 14:51:27
 +0200
In-Reply-To: <xmqq612n2z3d.fsf@gitster.mtv.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:AwaXHPbnV5YgnYVgbwMPJj25cuUGdihbKexk1pADQS0E4+TkLd/
 DB0Fo1MTm1Ov/LgRXYSYsIQ2+VeCw/KylOa+34EZrraSYVeASZsc36IELIZroDFOx4ek11T
 a3D24u7k289WgC3wHjT2/90L3H5H9Wdob46Zxt7gh3J025HaEwhWYVHwneBO34etomYNw0g
 OfCGUwAKoPuhKDNM+UiaA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zhoUn3ocZAc=:ha+UeQ02W5dP0ufgTofnXB
 vMy6r4ZU9jEs2NIKwwGVDS/N330MokFmzWZc/BTkypYF6fwwO1GMqM1wI1DiG13jz1nyJykuD
 JHLc2touClIbZg+2nrgnLnTeHd4P/0ZDnl+b/pQCB6hysiF4c9XgSm+n9+69D1/wGY6kyssSH
 d668bsoroBJod6ZgcznN4au69WjvItyC7timFYCr67NsK7ZF5MvR9jW9m7bjE5zzhgGEY6nga
 HqdBYFxVB7E/5Cm3lPGjP7w6jlCmmvdhK+6XuRx6sKWTpSTJyb9mvL8C24HZ+DCmNAXV8Mhma
 fcgDbeHChUI8Kcp8+JdgfIESFdO2kJ/ekiTYFiS8CyW4YpB3EsUXOg26JTeFOIfeT+wPL0RhO
 sUkMwow7YK/1cI54CyBXAB37nOh9RMpBhj3Y9kcQ00FadiPVP9SxTCLS7VBixd7smzNxBCtDF
 c90lqSG5vPipHRZorG/6y3VF7jKBQVV+fmt3kxbvEb4NBZVtxuAs9ZkblbrthKRI2Nv1xuVDy
 MCT8RuxY8Fpa17WzM9jHv//1wa0CVY+OT3ir2kxqudGtAYIuFn+iiipEprRG8pf4X7Z7XW9v8
 zku5MJoeLWqr5yFDYEcv+tT1hDQtDcz9Q6pzuo0drvKiA1M7RPb2SlVNbNBBFZNURjHwfPgHC
 tvcDxtnUEBhsxVxY1SJmPD8qLwf7EoLhc9PQXpgcJ6pN67+n2ucjCj0ubjAWKem/eygGT4A3v
 JxDQ5FEsRVWXwX97LjOCF46LenZ1xAPV3uJNo0Z50BK0gGuGpuWhW1JoPbhRG7Jt0a3psPzg 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278998>

Hi Junio,

On 2015-10-04 03:37, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> On Sat, Oct 3, 2015 at 3:23 PM, Roberto Tyley <roberto.tyley@gmail.com> wrote:
>>>
>>> Given this, enabling Travis CI for git/git seems pretty low risk,
>>> are there any strong objections to it happening?
>>
>> I still don't see a reason why git/git needs to be the one that is
>> used, when somebody
>> so interested (and I seem to see very many of them in the thread) can
>> sacrifice his or
>> her own fork and enable it him or herself.
> 
> To state it a bit differently.
> 
> If somebody says "I've been maintaining a clone of git/git with
> Travis webhooks enabled and as the result caught this many glitches
> during the past two months without any ill side effect.

Heh... given that Travis CI requires that .travis.yml file, nobody can really say that they have been using Travis CI *before* you add that file to `master`. If you make successful testing with Travis a *precondition* before adding that file, it is kinda asking for the impossible.

Now, I like Travis, even if I have used Jenkins previously (came as part of my previous day-job). And my experience with Jenkins (in the form of BuildHive) was pretty positive: it *did* catch a couple of breakages. Even with my Git fork.

But I agree with basically everybody who chimed in and said that the biggest bang for the buck would be made by enabling it on https://github.com/git/git.

The only cost I see is for that `.travis.yml` file to live in Git's source code. Small price to pay, if you ask me. If you do not want to use it yourself, that is fine. But I would like to ask for it to be included so that those of us who do want to benefit from Travis' testing are not precluded from doing so [*1*].

As far as I can tell, the patch is fine as-is. Although I would put the `before_script` commands into some file inside `contrib/`.

Thanks,
Dscho

Footnote *1*: of course it would be possible to manually rebase the patch, or to set up a scripted version of that. That is very cumbersome, though, and the benefit would obviously be substantially diminished.
