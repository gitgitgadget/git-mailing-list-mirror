Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="AWl3UKmp"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46616B7
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 09:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1702402183; x=1703006983; i=tboegi@web.de;
	bh=LfUYhGjt73+mzNTTgJ3s9FzvvS2EExyIJpPgKtakGW4=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=AWl3UKmpIMJLEvAlchMMLjY9YoWjY0G3ct5R41oh5YpiJCHQ9RYbise7PtLXyVAh
	 Z+gy8QOESbr1XSq+sSq3YmENalTdRntTAZl7OOIwcil+6sE+jCt/xbmZrmEy5iG7f
	 xXjLWAcfks/9XBP6IhpPPEZ9ksRTb0Wtr1KhWnV7BVwcrtY6Gf1HwkWe4U4Q3tOU4
	 AAG73mZFgpiMe8+VZuUj6x894ci1FLn3xw9kkUZrix80HSj/CdGhV7axaQG+zaNwO
	 mnRMvWyDZVWQN17BMy7EnVYMumqXMUvX7wRVJJjL8/VpImkIxaBlb2tghH1UxMAjb
	 f/Xo9JlGEJus8BYvOg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2xvy-1rC0793708-003qBK; Tue, 12
 Dec 2023 18:29:43 +0100
Date: Tue, 12 Dec 2023 18:29:43 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Haritha D <Harithamma.D@ibm.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Propose a change in open for passing in the file type.
Message-ID: <20231212172942.GA12692@tb-raspi4>
References: <E1D54D98-3836-41CA-84B5-32AEAF7642D8@ibm.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <E1D54D98-3836-41CA-84B5-32AEAF7642D8@ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:1EQdjO8Ipf+/osWCmc3hPPvVf7stM475Njxlr+VAr/Paw1yjXNT
 TzAInXzNIpRHGrXXjf47jDY9szR92qyHjQdENodrknTAct7nh8fxQv700rIGU9gNIUa6yAf
 yKIv5VQglpONOVOoXZkQ6/iYri5M6B0F7qbBax3/63iwzn8xk8EyWoXu/ahURwA39Ju2vPq
 gueOIcNYZhYS1fB/aUNHw==
UI-OutboundReport: notjunk:1;M01:P0:kNPoHt/h6ks=;wivDPh8V0APnLzWuz5Y73odNmSV
 oGUWRDe99bAgf6Oc3qno6U55HeFI3E7eqvlpOEOZ+ZeWZc/UYDzO+1H/Jl51O9IDkOG1+MtmX
 pb4ewCjmpRDk78PCRwABtlKQipFYIBKpqk4DcQontY0qk+KbvV9lv51QuDx1ZHuHn/UdHFH6V
 ri7VqSLqOBM9jf/HAC2q11pdatBHxCZom1cHjgVyHBf/vkiFZ8qH2Qx6bEpN5gfmzTWFOik0m
 LDoYwMGm7EoqP4Vfyj/1jaevmQ86+5k9orbqBpPJF2VmBRx6zIpBbqbM+0/LQGUy0ymVZC+lV
 RE23L00OZa0LKxPf/jljx9t5ve3o6gcpDPgzTP61PBo1N4DijnrztyW2WX1aIVGkVNF3zmTaS
 4Mw5+K3v7y0px8oUzEm5wfR7AuRK23w/gZ9G3ey+/gmgz4mTO8jERk6NoI1+UWbTr+D/RNQuo
 zyFj505dWYS0ZOuAAoBQ+VVQ/lnyw1DzR6wmEO0vxGBRJqVRDeifBT/pLZRDHQk+3D72jRBjy
 y5KKs/65AHN1R/vj3anau/A0QFIxaI9PBKds3mXILqQxTL/ahVomXvzdyoYSIoH6erVEDxhjo
 KFz6RW1N7e6BKpjC15uQkSuvj6IfWrocWKt2qgIL7uD5t08qLM5lLZGvVuXFmWdHzXuihl6NP
 uvBobv63i+2p3qTATuqgTBgfgKxNicBGzmDXdz8LgGnUw2XAquTaUm4RrazjJHVzU9WN/4yv0
 l+0XcAdvY9zjqGtZV59BaoJVKtBwu/5dNreN6YnDIbXbuTJQr0m2n7hZ4t5rayVdQihbyQ5K3
 yDYw87SBts7a4ONvpdlbjL6qqwM+HaX45ASatrPDWMINDsFgKyWM5u5IRz0TjaiE3hmyZj8Ar
 prrEGqoptWhXoiD0/+Sad/x0awK+X4H/o9LDjx/ChL73XlKheafKFAD0dWb5K41Uo/OTNzbDt
 l6iMZjfJYn7KRPDCfZI31tFxutw=

On Tue, Dec 12, 2023 at 02:46:04PM +0000, Haritha D wrote:
> Hi Everyone,
>
> Am working on porting git to z/OS. For reference, the pull request am wo=
rking on https://github.com/git/git/pull/1537.
>
> On z/OS there is a notion of file tag attributes. Files can be tagged as=
 binary, ASCII, UTF8, EBCDIC, etc. z/OS uses these attributes to determine=
 if auto-conversion is necessary. It was recommended in PR that we add log=
ic directly to xopen . In order for me to do this in xopen , I have to pas=
s an extra parameter to xopen that specifies the file type.=A0
> =A0
> Ex:
> xopen(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
>
> To :
> xopen(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0666, BINARY);
>
> BINARY: would be an enum value.
>
> Would this be okay to do? Or are there other recommendations?

I think that the suggestion was to embedd the BINARY thing into xopen(),
not to all callers of xopen().

If you have this type of special handling for one specific OS,
call it quirks, if you want, they are better placed in an own file.

Please see e.g. compat/mingw.c as an example, how things are solved
for Git for windows.
Then there are some include files, which re-define things like open(),
if needed.

Another example could be
compat/win32/dirent.c

Where exactly things are placed, is may be a matter of taste,
that may be decided later.
In your case a file like
compat/z_os.c and z_os.h may make clear what this is about to everybody.




>
> Best regards
> Haritha
>
>
