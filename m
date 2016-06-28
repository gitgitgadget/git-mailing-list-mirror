Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 389AF1FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 09:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbcF1JYF (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 05:24:05 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:52060 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752501AbcF1JX7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2016 05:23:59 -0400
X-AuditID: 12074414-c83ff700000008b4-0d-57724222c5c2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 91.64.02228.22242775; Tue, 28 Jun 2016 05:23:48 -0400 (EDT)
Received: from [192.168.69.130] (p508EAE14.dip0.t-ipconnect.de [80.142.174.20])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5S9NhkA006463
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 28 Jun 2016 05:23:44 -0400
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
To:	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
 <1634E84E-5260-4F7B-A74F-AF5D3A7C0181@gmail.com>
 <576650E7.70107@alum.mit.edu> <xmqqmvmhvyn5.fsf@gitster.mtv.corp.google.com>
 <xmqqd1ncvisw.fsf@gitster.mtv.corp.google.com>
 <8E05CEA5-C573-4271-A73F-99E7BAE1BF06@gmail.com>
 <576B9081.3020405@alum.mit.edu>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>, novalis@novalis.org
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <5772421F.3030100@alum.mit.edu>
Date:	Tue, 28 Jun 2016 11:23:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
MIME-Version: 1.0
In-Reply-To: <576B9081.3020405@alum.mit.edu>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsUixO6iqKviVBRucP6umUXXlW4mi4beK8wW
	jx8uYbU4Pusau8WSh6+ZHVg9HlzZwuixc9Zddo+u9iNsHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ3xY+MEloKZMhWd1/YyNzCeE+ti5OSQEDCRaDm5lK2LkYtDSGAro8TOb8eYIJzzTBLP
	fp9kBakSFrCXWLx3NwuILSIQJdG48ydUxyEmiZvXD4ElmAUyJQ5/uccOYrMJ6Eos6mlmArF5
	BbQlFvx/yAxiswioSjS2fwKrFxUIkTi/bisrRI2gxMmZT8DinAI6Eq/2v2aFmKknseP6Lyhb
	XmL72znMExj5ZyFpmYWkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdC30cjNL9FJT
	SjcxQsJZZAfjkZNyhxgFOBiVeHh31BWGC7EmlhVX5h5ilORgUhLlXcBQFC7El5SfUpmRWJwR
	X1Sak1p8iFGCg1lJhLfBESjHm5JYWZValA+TkuZgURLn/bZY3U9IID2xJDU7NbUgtQgmK8PB
	oSTBawbSKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+KyvhiYFyCpHiA9vaC7S0u
	SMwFikK0nmI05lg398ZaJo4j+++tZRJiycvPS5US59V0ACoVACnNKM2DWwRLZK8YxYH+FuZ9
	D1LFA0yCcPNeAa1iAlrFWp0PsqokESEl1cDopvfk+wNjR8PnNnHMttlvjfrYQpdslPHKYHnx
	69vCz6/2cie6FDvxXv3IZfPc++JXRZcNPBvLd7K3fjtsfYpxV4w4W/Vvsw1imSt+5U/L3Mqg
	kC0rdON3aVuwzbL3au+38ypdPbdp4TtOTZGAPRn/o6NXr+P5vfF8/KV7HWkMUyp1P89acPin
	EktxRqKhFnNRcSIA/dnltj8DAAA=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 06/23/2016 09:32 AM, Michael Haggerty wrote:
> [...]
> I have to say, I'm still confused about how the old code could have
> worked at all. For quite some time, Git hasn't allowed references with
> weird names like `git-p4-tmp/6` to be created, so how could there be any
> references there that need to be deleted? It seems to me that one of the
> following must be true:
> [...]
> * I'm wrong about Git not allowing references like `git-p4-tmp/6` to
>   be created, in which case I'd like to know what code path allows it
>   so that I can fix it.

I was indeed wrong.

Reference names are vetted by `check_refname_format()` on creation, but
that function knows and enforces nothing about the `refs/` namespace or
the ALL_CAPS convention for top-level references. Moreover, the relevant
caller passes the `REFNAME_ALLOW_ONELEVEL` option, which has semantics
that are fairly useless as far as I can tell. A casual reader might
assume that `REFNAME_ALLOW_ONELEVEL` allows one-level reference only if
they satisfy the special `ALL_CAPS` convention, but in fact it doesn't
enforce the convention. (I suppose that `REFNAME_ALLOW_ONELEVEL` was
meant for checking partial reference names, for example to vet "foo"
that the caller wants to pass to `git branch`, which automatically turns
it into `refs/heads/foo`.)

In summary, `check_refname_format()` is in some ways less strict than
`refname_is_safe()`. For example, it allows reference names like
`git-p4-tmp/6` or even `git-p4-tmp`. With current master:

    $ git update-ref git-p4-tmp HEAD
    $ echo $?
    0
    $ git rev-parse git-p4-tmp
    cf4c2cfe52be5bd973a4838f73a35d3959ce2f43
    $ git update-ref -d git-p4-tmp
    $ echo $?
    0

I don't know what I was thinking. Long ago, when I refactored and
documented check_refname_format(), I realized that the checks are
surprisingly lax and that the `REFNAME_ALLOW_ONELEVEL` option is
misleading. But I was new to the project and wasn't brave or energetic
enough to do something about it. Meanwhile I guess I forgot that it
never got fixed. Commit

d0f810f0 2014-09-03 refs.c: allow listing and deleting badly named refs

, which introduced `refname_is_safe()`, perhaps muddled the situation by
adding a "fallback" check that is not strictly laxer than the main check.

Where does that leave us?

* It is currently possible to create and delete references with
  names that are neither within `refs/` nor ALL_CAPS (though not
  remotely).

* Such references do not participate in reachability checks, so
  they have to be considered semi-broken.

* Users could create chaos (though not remotely) by creating a
  loose "reference" whose name coincides with that of another
  file under `$GIT_DIR`.
  (`git update-ref objects/info/alternates HEAD` anyone?)

* `git-p4` is apparently the only code within the Git project that
  was making use of this questionable freedom.

* Presumably there is user code in the wild that creates and uses
  such references.

I think we need to get this under control, but given that we've allowed
such references (albeit partly broken) for a long time, we probably need
to provide an escape hatch to aid the transition. I'm skeptical that the
mh/split-under-lock patch series is the best place to start such a
campaign. On the other hand, I don't want that patch series to open up
any new avenues to creating references that escape `$GIT_DIR`.

Let me think for a bit about the next step. Input is welcome.

In any case, I think that Lars's patch to `git-p4` is a good thing.

Michael

