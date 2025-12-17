Received: from 7.mo576.mail-out.ovh.net (7.mo576.mail-out.ovh.net [46.105.50.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D647B3E1
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.50.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980638; cv=none; b=rrZB8oC67DQzhL/1yWEOrwHWseXdKI4hULuXVHIBcFyeXz0yLs7yMiHeOCOTrg9rEn72SJBW7WKa8a8blQw6xKKQD7DBMhnrhaE3pB5fSAOz0yOMsA2Gnd3HXCo3iVxoTHhrUnsxvIJU1raBbmoiWSpMN7EiAEADtTDp7NBQs5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980638; c=relaxed/simple;
	bh=J3sKRPu5IqFS4w0dNAzuxBDjWWON+7M+J5kEXU3RMMc=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To; b=BqT4AtOjUl3JGP0AxAf3Fm9AFsMHUWcJkaZUCal+76vtHR8se9Q5JHwSH4AlX6KGbKTaKxmcQNnK3ixoFt5zSYtHw+1OOHTadGBxuups5/I49b2t0pUSLIUDkHtwK7IAodGOH8uxNsLW+T+WTk4suxntc/okf6fjobNNX/TfRmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scantech.com; spf=pass smtp.mailfrom=scantech.com; dkim=pass (2048-bit key) header.d=scantech.com header.i=@scantech.com header.b=oW/PD9fl; arc=none smtp.client-ip=46.105.50.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scantech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scantech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scantech.com header.i=@scantech.com header.b="oW/PD9fl"
Received: from director10.ghost.mail-out.ovh.net (unknown [10.109.254.71])
	by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4dWZnJ11bXz5wnB
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 13:45:40 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-lqls4 (unknown [10.110.118.225])
	by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 6F11FC0FA3;
	Wed, 17 Dec 2025 13:45:39 +0000 (UTC)
Received: from scantech.com ([37.59.142.98])
	by ghost-submission-7d8d68f679-lqls4 with ESMTPSA
	id lqErEQO0Qmmn3wgALwElvw
	(envelope-from <jean-noel.avila@scantech.com>); Wed, 17 Dec 2025 13:45:39 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-98R002cdf0975a-eed4-4be7-a53b-cb367fbc7195,
                    55C39F18C8501933CD2E96577179C67B8CC366AD) smtp.auth=jean-noel.avila@scantech.com
X-OVh-ClientIp:141.255.129.53
Content-Type: multipart/mixed; boundary="------------Lr2GJkNTpe0e0s4Cp93x01GR"
Message-ID: <876ee36d-610b-4df6-9297-96b38f106c6c@scantech.com>
Date: Wed, 17 Dec 2025 14:45:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: flock of small fixes to various documentation files
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.2016.git.1765830229824.gitgitgadget@gmail.com>
 <031d7b41-b6d3-450c-925e-cddaf2e7aa85@app.fastmail.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jean-noel.avila@scantech.com>
Content-Language: fr
In-Reply-To: <031d7b41-b6d3-450c-925e-cddaf2e7aa85@app.fastmail.com>
X-Ovh-Tracer-Id: 12971211354284089083
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFTVaePVn2hZRlnX7CC8VNPbAMaVqUyb3OhfXfgcEjCeC/PK32YWxuM934YZuP+uhBll0HW9LiwCz/NoK/FWifhVEl6pilNPKNCHBNNBf5KndsD/5L4R+c2FGZzXNt5DOt2n8cnG4efqXmZ36Oi14SFxHlkN26i0mqI5UhCm1X+/4cD84IELzTlcLRtAfYVemaMihB8WafjSi71zxjgiTvfi3EtTurIxJQEs39lxWCND5qXr+UiUl9wnACUTLdUUfAYt69YkPU396yic2ruAD74XbON4gBeKdQVG+uGFbVIZGgkxy4ewezQ1ENqJwLa2q5Y7VbKUR4HTHeENpx/rihvH3hLAUbr8abYJwjFd/w0JZLOPXBR15baugxjto+RgN0p8hKfoqds5WRsStMAvZf+0gwtEcyAjcCmHhcANiC5502zuAjIvTp8aJO3OcDAt6VCiucXIQN75BZ+hgk1O6EXnqBh2S9ckGmBM547GQ/IHIgft16Br0yqTkWibIPdourwdTCteLP2MyJN/kA2+TwdtakjymzGHpNOY4nl/p77kg1aRHt0LILVjPLvIgaYphL5Y3GtbbjAO01vBnEJk26V6ndtiOD4u4azNXLyUcegNWTjCftCJI3KfRFgXFEFeFDq7Srmbc9IMY8/50sh7/Sj8ffQLvd1koMc/NhBCza+lg
DKIM-Signature: a=rsa-sha256; bh=vkOrf8DPRKBSLzQgjVuY2tWElbonelfVxAtPJkHJBJY=;
 c=relaxed/relaxed; d=scantech.com; h=From; s=ovhmo3875056-selector1;
 t=1765979140; v=1;
 b=oW/PD9flINJIXwhkDubyVh/e51d/yEjaXLZ3eV3sz0+6JxxDHTuq+u5j36hUdIcjBxK3KIjl
 PCWPjGvv8HVmAuBt8WIIco4IaZUxOfb1Lvqdvh7jq6d3+MCg/0zaoI117vElN0/MKF9NCzIY39h
 5xrR/CI1hvKaoHEN+sLKIi2sXjNB5qYqvzUDSvjWms/IRwdCz+E9xjpa9mV+YUOgKTZFqsat9lm
 bT+O6hHAGRBllq6rnslUCozsA2pDbAdZsLo9vd/kbpIrTl6TLD54azmrcCHxYEvWg4FZArIznPA
 7PJGxi6EFCPaDMzUiDxHNM0TPyS2kKB87pqMAcxeHlSDA==

This is a multi-part message in MIME format.
--------------Lr2GJkNTpe0e0s4Cp93x01GR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 15/12/2025 à 23:50, Kristoffer Haugsbakk a écrit :
>> [PATCH] doc: flock of small fixes to various documentation files
> 
> This doesn’t say much.
> 

Yes, this is a set of disparate changes, except that they all relate to
documentation.

> On Mon, Dec 15, 2025, at 21:23, Jean-Noël Avila via GitGitGadget wrote:
>> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
>>
>> While translating the Git documentation into French, I noticed several small
>> issues in various files. This commit addresses these issues to improve the
>> overall quality and consistency of the documentation.
> 
> This paragraph doesn’t add any relevant information. The following
> bullet list would be fine on its own. That it was stumbled upon while
> doing X is typical below the three-dash/hyphen line info.

True, will remove.

> 
> Any code/doc change aims to improve the overall quality.
> 
>>  * enforce consistent imperative mood in option descriptions
>>  * lighten wording in several places for clarity
>>  * add missing parameters
>>  * fix minor asciidoc markup issues
> 
> I also use bullet-list commits sometimes. (And it’s cousin: “Let’s
> also...”) But this commit does two things:
> 
> • Change prose: imperative mood, lighten wording
> • Fix mistakes source formatting:
>   • Correct markup
>   • Add missing paren
>   • Split up markup of options: `-f`/`--force`
>   • Weird indent
> 
> Could this fruitfully be split into at least two commits?
> 
> I just think these are two different categories.

For me these changes are so straightforward that splitting/grouping
seemed overkill. But, I understand your point. Style vs. pure formatting
is a good approach, even if here the style is not about the approach to
writing the documentation.

> 
> Is that just an academic concern? Well, in my experience it is very
> pleasant to pickaxe through a snippet of text, stumble upon clearly
> marked commits like
> 
> • Use USA spelling
> • Fix articles (the/a/an)
> • *: typos
> 
> and just race past them. Because I am looking for the original
> motivation for some phrasing (say), typos and missing articles and all,
> and these commits are simple to bunny hop. But here, fixing a missing
> parentheses is mixed together with
> 
>     Replace: less than `<n>`, where `<n>` represents a number of bytes,
>     With: less than `<n>` bytes
> 
> And now I might have to pause and think which implicated change this is
> about for my purposes; a subjective-but-good change or a
> fix-objective-mistake change. Because that matters when I want to know
> why the text is phrased in a certain way.
> 

OK, will split in two.

>>
>> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
>> ---
>>     doc: flock of small fixes to various documentation files
>>
>> Published-As:
>> https://github.com/gitgitgadget/git/releases/tag/pr-2016%2Fjnavila%2Fdoc_small_fixups-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git
>> pr-2016/jnavila/doc_small_fixups-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/2016
>>
>>  Documentation/git-checkout.adoc   |  2 +-
>>  Documentation/git-rebase.adoc     |  2 +-
>>  Documentation/git-repack.adoc     |  6 +++---
>>  Documentation/git-send-email.adoc | 26 +++++++++++++-------------
>>  Documentation/git-worktree.adoc   |  2 +-
>>  5 files changed, 19 insertions(+), 19 deletions(-)
>>
>> diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
>> index 6f281b298e..43ccf47cf6 100644
>> --- a/Documentation/git-checkout.adoc
>> +++ b/Documentation/git-checkout.adoc
>> @@ -509,7 +509,7 @@ ARGUMENT DISAMBIGUATION
>>  -----------------------
>>
>>  When you run `git checkout <something>`, Git tries to guess whether
>> -`<something>` is intended to be a branch, a commit, or a set of file(s),
>> +_<something>_ is intended to be a branch, a commit, or a set of file(s),
>>  and then either switches to that branch or commit, or restores the
>>  specified files.
> 
> Correct markup since this is a `synopsis` document. Good.
> 
>>
>> diff --git a/Documentation/git-rebase.adoc
>> b/Documentation/git-rebase.adoc
>> index 9742833ebe..e177808004 100644
>> --- a/Documentation/git-rebase.adoc
>> +++ b/Documentation/git-rebase.adoc
>> @@ -87,7 +87,7 @@ of the to-be-rebased branch. However, `ORIG_HEAD` is
>> not guaranteed to still
>>  point to that commit at the end of the rebase if other commands that
>> change
>>  `ORIG_HEAD` (like `git reset`) are used during the rebase. The
>> previous branch
>>  tip, however, is accessible using the reflog of the current branch
>> (i.e. `@{1}`,
>> -see linkgit:gitrevisions[7].
>> +see linkgit:gitrevisions[7]).
> 
> Add missing end-paren. Good.
> 
> *Could* maybe also replace the comma with a semicolon?
> 
>     i.e. `@{1}`; see ...
> 
>>
>>  TRANSPLANTING A TOPIC BRANCH WITH --ONTO
>>  ----------------------------------------
>> diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
>> index d12c4985f6..673ce91083 100644
>> --- a/Documentation/git-repack.adoc
>> +++ b/Documentation/git-repack.adoc
>> @@ -77,14 +77,14 @@ to the new separate pack will be written.
>>  	Only useful with `--cruft -d`.
>>
>>  --max-cruft-size=<n>::
>> -	Overrides `--max-pack-size` for cruft packs. Inherits the value of
>> +	Override `--max-pack-size` for cruft packs. Inherits the value of
>>  	`--max-pack-size` (if any) by default. See the documentation for
>>  	`--max-pack-size` for more details.
> 
> Imperative mood.
> 
>>
>>  --combine-cruft-below-size=<n>::
>>  	When generating cruft packs without pruning, only repack
>> -	existing cruft packs whose size is strictly less than `<n>`,
>> -	where `<n>` represents a number of bytes, which can optionally
>> +	existing cruft packs whose size is strictly less than `<n>`
>> +	bytes, which can optionally
>>  	be suffixed with "k", "m", or "g". Cruft packs whose size is
>>  	greater than or equal to `<n>` are left as-is and not repacked.
>>  	Useful when you want to avoid repacking large cruft pack(s) in
> 
> Here drop a wordy “where `<n>` represents a number of bytes” clause in
> favor of just “<n> bytes”.
> 
>> diff --git a/Documentation/git-send-email.adoc
>> b/Documentation/git-send-email.adoc
>> index 263b977353..cdaf421cda 100644
>> --- a/Documentation/git-send-email.adoc
>> +++ b/Documentation/git-send-email.adoc
>> @@ -208,7 +208,7 @@ Sending
>>  	for your own case. Default is the value of `sendemail.smtpEncryption`.
>>
>>  --smtp-domain=<FQDN>::
>> -	Specifies the Fully Qualified Domain Name (FQDN) used in the
>> +	Specify the Fully Qualified Domain Name (FQDN) used in the
>>  	HELO/EHLO command to the SMTP server.  Some servers require the
>>  	FQDN to match your IP address.  If not set, `git send-email` attempts
>>  	to determine your FQDN automatically.  Default is the value of
> 
> Imperative mood.
> 
>> @@ -245,7 +245,7 @@ a password is obtained using linkgit:git-credential[1].
>>  	Disable SMTP authentication. Short hand for `--smtp-auth=none`.
>>
>>  --smtp-server=<host>::
>> -	If set, specifies the outgoing SMTP server to use (e.g.
>> +	Specify the outgoing SMTP server to use (e.g.
>>  	`smtp.example.com` or a raw IP address).  If unspecified, and if
>>  	`--sendmail-cmd` is also unspecified, the default is to search
>>  	for `sendmail` in `/usr/sbin`, `/usr/lib` and `$PATH` if such a
>> @@ -258,7 +258,7 @@ command names.  For those use cases, consider using
> 
> Imperative mood and drop “If set”.
> 
> We can see in the resulting file that many commands use this “Specify”
> start. Not a mix of “Specify” and “If set, ...”.
> 
> Although see also the positive/negative options that start with “If this
> is set,”. Maybe unrelated to this change, but maybe they could be
> rephrased with less “if set” ceremony. Relevant:
> 
> https://lore.kernel.org/git/xmqqcyct1mtq.fsf@gitster.g/
> 

Not the purpose of this commit, but maybe, it would make sense to stress
out that the first sentence for explaining an option should describe
bluntly its positive action expressed in imperative mood, with no
ceremony. After this first sentence, the negative equivalient, more
context, more precision or use cases can be described.

>> `--sendmail-cmd`
>>  instead.
>>
>>  --smtp-server-port=<port>::
>> -	Specifies a port different from the default port (SMTP
>> +	Specify a port different from the default port (SMTP
> 
> Same.
> 
>>  	servers typically listen to smtp port 25, but may also listen to
>>  	submission port 587, or the common SSL smtp port 465);
>>  	symbolic port names (e.g. `submission` instead of 587)
>> @@ -266,7 +266,7 @@ instead.
>>  	`sendemail.smtpServerPort` configuration variable.
>>
>>  --smtp-server-option=<option>::
>> -	If set, specifies the outgoing SMTP server option to use.
>> +	Specify the outgoing SMTP server option to use.
> 
> Same.
> 
>>  	Default value can be specified by the `sendemail.smtpServerOption`
>>  	configuration option.
>>  +
>> @@ -277,7 +277,7 @@ must be used for each option.
>>  --smtp-ssl::
>>  	Legacy alias for `--smtp-encryption ssl`.
>>
>> ---smtp-ssl-cert-path::
>> +--smtp-ssl-cert-path <path>::
>>  	Path to a store of trusted CA certificates for SMTP SSL/TLS
>>  	certificate validation (either a directory that has been processed
>>  	by `c_rehash`, or a single file containing one or more PEM format
> 
> Add parameter. Makes sense.
> 
>> @@ -347,11 +347,11 @@ Automating
>>  --no-to::
>>  --no-cc::
>>  --no-bcc::
>> -	Clears any list of `To:`, `Cc:`, `Bcc:` addresses previously
>> +	Clear any list of `To:`, `Cc:`, `Bcc:` addresses previously
>>  	set via config.
> 
> Imperative mood.
> 
>>
>>  --no-identity::
>> -	Clears the previously read value of `sendemail.identity` set
>> +	Clear the previously read value of `sendemail.identity` set
> 
> Ditto. And these two look like the only relevant `--no` options. So this
> looks consistent.
> 
>>  	via config, if any.
>>
>>  --to-cmd=<command>::
>> @@ -510,12 +510,12 @@ have been specified, in which case default to `compose`.
>>  	Currently, validation means the following:
>>  +
>>  --
>> -		*	Invoke the sendemail-validate hook if present (see linkgit:githooks[5]).
>> -		*	Warn of patches that contain lines longer than
>> -			998 characters unless a suitable transfer encoding
>> -			(`auto`, `base64`, or `quoted-printable`) is used;
>> -			this is due to SMTP limits as described by
>> -			https://www.ietf.org/rfc/rfc5322.txt.
>> +* Invoke the sendemail-validate hook if present (see linkgit:githooks[5]).
>> +* Warn of patches that contain lines longer than
>> +  998 characters unless a suitable transfer encoding
>> +  (`auto`, `base64`, or `quoted-printable`) is used;
>> +  this is due to SMTP limits as described by
>> +  https://www.ietf.org/rfc/rfc5322.txt.
>>  --
> 
> Non-functional change it seems. This looks better in the source. 2–3
> tabs were not needed here.
> 

It turns out the tool to translate the manpages Po4a also dislikes (i.e.
does not interpret correctly) the tabs.

>>  +
>>  Default is the value of `sendemail.validate`; if this is not set,
>> diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
>> index f272f79783..d74ad7b0e9 100644
>> --- a/Documentation/git-worktree.adoc
>> +++ b/Documentation/git-worktree.adoc
>> @@ -104,7 +104,7 @@ associated with a new unborn branch named _<branch>_ (after
>>  passed to the command. In the event the repository has a remote and
>>  `--guess-remote` is used, but no remote or local branches exist, then the
>>  command fails with a warning reminding the user to fetch from their remote
>> -first (or override by using `-f/--force`).
>> +first (or override by using `-f`/`--force`).
> 
> Fix inline-verbatim since you are quoting two options/switches. So the
> `/` does not go inside the (`). Good.
> 
>>
>>  `list`::
>>
>>
>> base-commit: d8af7cadaa79d5837d73ec949e10b57dedb43e9b
>> --
>> gitgitgadget
> 
> `doc-diff` also looks good.
> 

--------------Lr2GJkNTpe0e0s4Cp93x01GR
Content-Type: text/vcard; charset=UTF-8; name="jean-noel_avila.vcf"
Content-Disposition: attachment; filename="jean-noel_avila.vcf"
Content-Transfer-Encoding: base64

YmVnaW46dmNhcmQNCmZuO3F1b3RlZC1wcmludGFibGU6SmVhbi1Obz1DMz1BQmwgQXZpbGEN
Cm47cXVvdGVkLXByaW50YWJsZTpBdmlsYTtKZWFuLU5vPUMzPUFCbA0Kb3JnOlNjYW50ZWNo
IFMuQS4NCmFkcjtxdW90ZWQtcHJpbnRhYmxlOlNhdm9pZSBUZWNobm9sYWMgQlAgMjQ0OztC
PUMzPUEydGltZW50IEFuZHJvbT1DMz1BOGRlIC0gMTA4IEF2ZW51ZSBkdSBMYWMgTD1DMz1B
OW1hbiA7IExBIE1PVFRFIFNFUlZPTEVYOzs3MzI5MDtGcmFuY2UNCmVtYWlsO2ludGVybmV0
OmplYW4tbm9lbC5hdmlsYUBzY2FudGVjaC5jb20NCnRpdGxlOkVtYmVkZGVkIHN5c3RlbXMg
bWFuYWdlcg0KdGVsO3dvcms6KzMzIDQ3OSAyNSA1NCA1MA0KdGVsO2NlbGw6KzMzIDYzMyAw
NCA2NCAxOA0KeC1tb3ppbGxhLWh0bWw6RkFMU0UNCnVybDpodHRwOi8vd3d3LnNjYW50ZWNo
LmNvbQ0KdmVyc2lvbjoyLjENCmVuZDp2Y2FyZA0KDQo=

--------------Lr2GJkNTpe0e0s4Cp93x01GR--
