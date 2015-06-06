From: Luca Milanesio <luca.milanesio@gmail.com>
Subject: Re: Submodules as first class citizens (was Re: Moving to subtrees for plugins?)
Date: Sat, 6 Jun 2015 20:53:37 +0100
Message-ID: <D2BB8369-E552-4AC3-967E-8F963206E03C@gmail.com>
References: <CABURp0og9i9S3_ZWf5Ce9LT785QJo4H-TVtFaKUTXr2N7FB+ew@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Repo Discussion <repo-discuss@googlegroups.com>,
	Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 21:53:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1KA2-000056-9l
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 21:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972AbbFFTxi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Jun 2015 15:53:38 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34609 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbbFFTxg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Jun 2015 15:53:36 -0400
Received: by wibut5 with SMTP id ut5so49849065wib.1
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 12:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:mime-version:subject:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Tak2sqsm5jSO6Sk/G55sgnvunzXgUNGfEN2Y6IoZ+JY=;
        b=eNERyRrnnetXtRF3YH94vkhlvhru0eh2L/DFbcfyNWwCng6qvxH47Dn2OhI0yV1v2w
         P52PdcLMy0mWqnjwlh+xol4SG2H7Q4j70NkFtIWISxKgN3dN7ZujHeAEOkiWq63FzyTo
         w07ROQI1WOhlIqVkMYwr7RV4siicKD/j1w0viMbehL25z724YVmPCV5tNmwYj3zKEl04
         z+1SAXwOPE6m8K33NCTp1r8QzIQm8h6fDjV2HFAgUldPEK+exqEmZ9jcfNzZf9G1AnCv
         iF5GOqjhi3JCy+4WwgI+kDE40Uh7IH4jmvScnJhJcH1E++snGjSg1i1Br/mXMJsDoKeR
         9tTw==
X-Received: by 10.180.100.194 with SMTP id fa2mr7819880wib.8.1433620415339;
        Sat, 06 Jun 2015 12:53:35 -0700 (PDT)
Received: from skywalker.home (host109-150-108-38.range109-150.btcentralplus.com. [109.150.108.38])
        by mx.google.com with ESMTPSA id o6sm3843608wiz.24.2015.06.06.12.53.33
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 06 Jun 2015 12:53:34 -0700 (PDT)
X-Google-Original-From: Luca Milanesio <Luca.Milanesio@gmail.com>
In-Reply-To: <CABURp0og9i9S3_ZWf5Ce9LT785QJo4H-TVtFaKUTXr2N7FB+ew@mail.gmail.com>
X-Mailer: Apple Mail (2.2098)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270941>

Thank you Phil, you anticipated me :-)

Luca.

> On 6 Jun 2015, at 18:49, Phil Hord <phil.hord@gmail.com> wrote:
>=20
> On Fri, Jun 5, 2015, 2:58 AM lucamilanesio <luca.milanesio@gmail.com>=
 wrote:
>>>=20
>>> Some devs of my Team complained that with submodules it is
>>> difficult to see the =E2=80=9Cfull picture=E2=80=9D of the differen=
ce
>>> between two SHA1 on the root project, as the submodules
>>> would just show as different SHA1s. When you Google
>>> =E2=80=9Csubtree submodules=E2=80=9D you find other opinions as wel=
l:
>>>=20
>>> Just to mention a few:
>>> -
>>> https://codingkilledthecat.wordpress.com/2012/04/28/why-y
>>> our-company-shouldnt-use-git-submodules/ -
>>> http://blogs.atlassian.com/2013/05/alternatives-to-git-su
>>> bmodule-git-subtree/
>>>=20
>>> To be honest with you, I am absolutely fine with
>>> submodules as I can easily leave with the =E2=80=9Cextra pain=E2=80=
=9D of
>>> diffing by hand recursively on submodules. But it is true
>>> that it may happen to either forget to do a git submodule
>>> update or otherwise forget you are in a detached branch
>>> and start committing =E2=80=9Con the air=E2=80=9D without a branch.
>=20
> ...
>=20
>> Ideally, as a "git clone --recursive" already exists, I would like t=
o
>> see a "git diff --recursive" that goes through the submodules as wel=
l :-)
>>=20
>> Something possibly to propose to the Git mailing list?
>=20
>=20
> I've worked on git diff --recursive a bit myself, along with some
> simpler use cases (git ls-tree --recursive) as POCs. I think some of
> the needs there begin to have ui implications which could be
> high-friction. I really want to finish it someday, but I've been too
> busy lately at $job, and now my experiments are all rather stale.
>=20
> It would be a good discussion to have over at the git list (copied).
> Heiko and Jens have laid some new groundwork in this area and it may
> be a good time to revisit it.  Or maybe they've even moved deeper tha=
n
> that; I have been distracted for well over a year now.
>=20
> Phil
