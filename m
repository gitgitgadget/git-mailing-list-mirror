From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: Our merge bases sometimes suck
Date: Mon, 23 Jun 2014 13:43:12 +0200
Message-ID: <53A812D0.1080402@gmail.com>
References: <539A25BF.4060501@alum.mit.edu>	<xmqq8uovo9pa.fsf@gitster.dls.corp.google.com>	<53A06264.9080205@alum.mit.edu>	<xmqqtx7gdqbt.fsf@gitster.dls.corp.google.com> <CAK3OfOjfyrsN47Ho0MFh4VZUg6YMjjwPOa16iuw3xtqyhz16hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Nico Williams <nico@cryptonector.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 13:43:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz2ei-0002qV-MR
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 13:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbaFWLnV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jun 2014 07:43:21 -0400
Received: from mail-we0-f178.google.com ([74.125.82.178]:45855 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbaFWLnU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 07:43:20 -0400
Received: by mail-we0-f178.google.com with SMTP id x48so6918900wes.9
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 04:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=31yVb2E1fN+MFFUWRZBUu/0xAQ+rEUUFwgXoWh2NkO4=;
        b=bpaj6AmfH6UdOVL6fbEcNfga55ixwex69IOzA3HgIGx+pqT/R4DFi09awa0hREzJhw
         1oza7OpsgsO88finopdkucgYY/Ex2i3ivWw/0RKC9F5Vf2Oo4S4+tDqTrwlO1iiSStRd
         0sNiT9LzZzYWwLU1H9cFlDeKi5YJeJX3MfjOHPzPv1jlLWhAKxu3ZuGaoQbkqVSlre9X
         /bL3Py7tq/d9m6DZPujA4FGKl6KWSdvrmW1AGIYid2e1LMGz42e78Sm99NazyIlbfVx0
         nmSs5NFl7xmbd3ol0hU6RlZY+Z5Jt+ZAduZ1a2ReqQgX9P2i5bx8qfA6W2dy/jYCwV4R
         g5Wg==
X-Received: by 10.180.19.233 with SMTP id i9mr25768659wie.38.1403523798913;
        Mon, 23 Jun 2014 04:43:18 -0700 (PDT)
Received: from [192.168.130.241] ([158.75.2.130])
        by mx.google.com with ESMTPSA id gi8sm32682614wib.8.2014.06.23.04.43.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 23 Jun 2014 04:43:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CAK3OfOjfyrsN47Ho0MFh4VZUg6YMjjwPOa16iuw3xtqyhz16hg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252341>

W dniu 2014-06-20 23:17, Nico Williams pisze:
> On Fri, Jun 20, 2014 at 1:53 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>> [...]
>>
>> Hmph, but that obviously will become very expensive to compute as
>> project grows.
>
> That's the main reason to like Fossil's approach (namely, the use of
> SQL, specifically SQLite3): you can write declarative queries and let
> the query planner optimize.

I do wonder if using *generic* RDBMS / key-value store would really
make Git faster than current filesystem-like approach.

BTW. perhaps caching generation numbers would help here; the idea
of adding performance-helper generation number header to commit
object was rejected.

> (That's also about the only thing I like about Fossil: the use of
> SQL/SQLite3, and all that that implies.  Fossil is otherwise an
> anti-git, and that makes it useless for me.)

There are Bazaar and Veracity that are supposed to have pluggable
backends...

--=20
Jakub Nar=C4=99bski
