Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11E415FD17
	for <git@vger.kernel.org>; Thu,  2 May 2024 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714676358; cv=none; b=pUJfXMPQuWbcUpsO6ZVyGs2GKSswwEwEBdEXYxhDAPAP+7/y9SwDQ+raEg1KT4yx7egmEQW4WVyiTSaswEyCvdplmHnvW6gIFNNjiJUgQhtk7opZOgpJhYnm/47EIBfbo8cKm5UsDMMpvw14uoKw1Czl5nni5fg9bIeeJ60KNaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714676358; c=relaxed/simple;
	bh=65r8bZi64A9bmUZVsVpyBTBo2vabfOEUQuS+g09fVFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZvwFFk5jgOG+Jl6+bYpiTr3Duc1BX4Ksz5Veap5cJS7WXZ4KVNQj6MECExV0+KY6r0yZt0PqGQp2EjIGtExqhZcQZh+cZuIrJ5DKI62BtKxrDqL6rU9rLLib51HZiFYpCo3DZI8Q2B8m5QzChHWzv6hvRBVax+oI7abCS51ugQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=UGpY/lny; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="UGpY/lny"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714676344; x=1715281144; i=tboegi@web.de;
	bh=X5lpNGYzZgQS2ARS4OSzXlKa/HRMqw8vwypjtiTtbQQ=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UGpY/lnydoX+OeO0iSsGpoWY08HYC3lRpjtw9AkCPyfLCfwu6H3y86uAhaXOPyZ4
	 huPqgkyeOxRBU46xV5tWvG76oJU5DWrH1WRhAJ0lPpqbxpd6TV/r2X1z3wzra1w2k
	 FczCXKuhXMUOZxUmQDxVyEInreGh/BJrcd9hp1QfdL8+lGUmeM/cWSLzfO1XLz5b/
	 awv7FtRYRTJV5iYU7k4Nk+7w6Fha8mu50qfx7tPzePBccpZQgcR6Vm+nLeMdbyTXZ
	 kg5EnNQnj1y4FjWMpP24oO1CSnJ7kNp2wPpdjh7WY+eryOt3m76tHpT5D/PkhZ7Y2
	 v5qxWoaYcH8RSl6m8w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mc1VL-1se9aR1rJf-00dLzo; Thu, 02
 May 2024 20:59:04 +0200
Date: Thu, 2 May 2024 20:59:03 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: t4216-log-bloom.sh broken ?
Message-ID: <20240502185903.GA11895@tb-raspi4>
References: <xmqq8r0ww0sj.fsf@gitster.g>
 <20240502055621.GA29945@tb-raspi4>
 <xmqqsez0fbam.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqqsez0fbam.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:JsNyUWbWR2LpYM9L2dlxsWQFeKAUNwvWqf3OvKgkPLlZfVvL3jz
 IHhCosDv2OmElDaM/6dVs2/VUZqwh/x37oVhKPBwoxuyaYjHMfq7t9lnI9Y3M950wVuP3On
 dAukeoADaK0ldWzlbARfLKM6oodD3i5Xsv9hO727o+4/NAYrjTKh41eUNgQHOaHjxuCaHZG
 M02QtZkeOnk6+fDR4iCjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8w8J8F9+cUI=;gRlbs04B5odq0BDuJToNA/ZoW/H
 R0k1TiJY9e6R78oiuXYHVzrTfeqX1S6lu39CYOjGJezpGzwFGQNz9rug5OkBjoJRDuF/rAss7
 boA0+0b+Rznwt3W4qC4JTykPwWh6wiktiSYZvgapP5A+yd18+YI7y31RtjmZ9gCg/2zgoA0+5
 MoRISR8ICMFSUZr6PiBA1ux7GF5o7IJYy11K3wNQBnGjQneDvn1jXPBqQRXAMp7RJ9S8p5KRn
 bdN9hGSH58tW/yUaOo3AXndrKtmQ1DnAZTPPMEn0N7eHIsCEEkHldyd5ioaExdwb8YEtZlx1q
 UmMzKJuPKpsx1Gyipze7M4h4538uyQKJCoz3XjCz4CWhV2XQlGerVEemX7RQNrfPpKCkVDmxi
 RYVy+yWqbii5yso+XcBAzz9qojqtdjVEPSuOKn8g3ZpFPhW8ZUKPg8huIQ4ZRYQTtwIt+BAH9
 E7UaRa5R9LEQfQo1imiqqi3NwSyxzlReCVnpTzcddNP+2iffRo7GmjcAfXJIvdTVTYmzPOXmb
 H5MHBc8eTkK1YBP6JJjytYlQcoOnuF3icrDJVXX+qZKv/weGYftcdnd7arHybmE7Lf2xF9QBw
 IQKjR//C2LyD9ha8tw5/LCYSxAuReWF2G3AaZLW6cCg5l29rqyO7G23Vug7yGsVQY0XEBCJqd
 VMSAiBANgqQjq5ebZyKivFZKNwLQZ8ilxPZ7gD9YL149IbXKIK0zxTBY417kzYsPf0HPrnKzD
 GoQt1RvwJ92f5Ue6+zVIl5EqyiaP6wmCW6wBPuOPu9HQhfL+8KP58Qofxp42xp7Rqw6GTmcMd
 Re2jxxzmIpLF8EvWm3lVsugAO0BxiU4sXsA2m3JkflQno=

On Thu, May 02, 2024 at 09:06:41AM -0700, Junio C Hamano wrote:
> Torsten B=F6gershausen <tboegi@web.de> writes:
>
> > There are 4 test cases in t4216-log-bloom.sh, that do not pass on one
> > Mac here (they pass on another machine)
>
> Another machine being another mac?

Yes, different mac, different MacOs, different $PATH probably.

>
> > expecting success of 4216.141 'Bloom reader notices too-small data chu=
nk':
> > 	check_corrupt_graph BDAT clear 00000000 &&
> > 	echo "warning: ignoring too-small changed-path chunk" \
> > 		"(4 < 12) in commit-graph file" >expect.err &&
> > 	test_cmp expect.err err
> >
> > ++ check_corrupt_graph BDAT clear 00000000
> > ++ corrupt_graph BDAT clear 00000000
> > ++ graph=3D.git/objects/info/commit-graph
> > ++ test_when_finished 'rm -rf .git/objects/info/commit-graph'
> > ++ test 0 =3D 0
> > ++ test_cleanup=3D'{ rm -rf .git/objects/info/commit-graph
> > 		} && (exit "$eval_ret"); eval_ret=3D$?; :'
> > ++ git commit-graph write --reachable --changed-paths
> > ++ corrupt_chunk_file .git/objects/info/commit-graph BDAT clear 000000=
00
> > ++ fn=3D.git/objects/info/commit-graph
> > ++ shift
> > ++ perl /Users/tb/NoBackup/projects/git/git.pu/t/lib-chunk/corrupt-chu=
nk-file.pl BDAT clear 00000000
> > ++ command /usr/bin/perl /Users/tb/NoBackup/projects/git/git.pu/t/lib-=
chunk/corrupt-chunk-file.pl BDAT clear 00000000
> > ++ /usr/bin/perl /Users/tb/NoBackup/projects/git/git.pu/t/lib-chunk/co=
rrupt-chunk-file.pl BDAT clear 00000000
> > ++ mv .git/objects/info/commit-graph.tmp .git/objects/info/commit-grap=
h
> > override r--r--r--  tb/staff for .git/objects/info/commit-graph? (y/n =
[n]) not overwritten
>
> Is this failure preventing the later steps of the test work as
> expected, I wonder.  Is there something curious with the permission
> bits of /Users/tb/NoBackup/projects/git/git.pu/ directory or its t/
> subdirectory?  Is there something curious with the "umask" of the
> user running the test?  Are they different from what you see on your
> other mac that does not exhibit the problems?
>
> Thanks.
>
>

mv is /bin/mv, that seems to be good:

$ type mv
mv is /bin/mv

$ alias | grep mv

$ which mv
/bin/mv

$ umask
0022

I don't know, why we see
r--r--r--  tb/staff for .git/objects/info/commit-graph

But, the "-r--r--r--" may be part of the problem, here is another one:
$ find . -name commit-graph -print0 | xargs -0 ls -l
-r--r--r--  1 tb  staff  1792 May  2 12:12 ./trash directory.t5318-commit-=
graph/bare/objects/info/commit-graph
(And some more 6 in total. All with -r--r--r--)

Which means, yes, t5318 does not pass either:
t5318-commit-graph.sh not ok 101 - reader notices too-small oid fanout chu=
nk
t5318-commit-graph.sh not ok 102 - reader notices fanout/lookup table mism=
atch
t5318-commit-graph.sh not ok 103 - reader notices out-of-bounds fanout
t5318-commit-graph.sh not ok 104 - reader notices too-small commit data ch=
unk
t5318-commit-graph.sh not ok 105 - reader notices out-of-bounds extra edge
t5318-commit-graph.sh not ok 106 - reader notices too-small generations ch=
unk

Same problem here:
++ mv full/.git/objects/info/commit-graph.tmp full/.git/objects/info/commi=
t-graph
override r--r--r--  tb/staff for full/.git/objects/info/commit-graph? (y/n=
 [n]) not overwritten

The rest of the test suite passes, I see the same failures even under a
fresh cloned repo.

Any hints are appreciated.


