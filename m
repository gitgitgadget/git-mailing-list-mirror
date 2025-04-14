Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281021AF0AE
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 19:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744658551; cv=none; b=m4xy6QtH+mUckYjJFmF4hPZYD8XSESkHCdvZV2PY+9IA7ni1oQIAeJcq1lkcqzQIM3M1ZSDGsEgPjHzxadFX+cBlml5z9G/eR4bA4uQz3yYoiqjgpiJEja8MCMKmwShV3z4yA9XT2kNilfh6Giuu1Rq+00ZepKrP1zDmbIXOcWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744658551; c=relaxed/simple;
	bh=3RgOoctK+/Wh7BwkqyxSNa5322j5mCM/ppxK2Xw1Yw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JaHRis6wXA55FDa75YhmRKhNZvYgLaRFX9WjABxnuzOOHD8GMidJNehMtdkhB7YvEMIL/L1v2jimByFDyQ9Q50Z5VLkcTnsgtKZ2oH2dIkm7VQwsb4vBEpMHDStnXKfS/fB5aI4+a9WsaHFqeOWHR652Pu6kJCuOu/LQZ6nZiFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=XLgRoPpr; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="XLgRoPpr"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 4PKtuHs9ZjZe54PKvu7zEI; Mon, 14 Apr 2025 20:19:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1744658358; bh=hAFNubNQqPFOGBOEuWWSk6wYTT1Q7hj4M/N/joti5Io=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XLgRoPprjhu1KpLgEyUVTJSC9cO0o8CuAB4/aH0y4QtmuzSD1QxYjtjcZ4KnKRjme
	 TIgpDwJOLUU+rV39/RU4wAp0pKlGSr5xvSJ33UXL3LG0PXPAxOGOaRi28vd608X/JP
	 XECXU9lUdj4VFP4iOZWGDZJTZ3+Cv+XYHFYh9Y7Poj7Xus3Opf3nGdEe+I17fVMPH0
	 p8zcwtu9ThsAwZBBytp0vRvAPCX+HZLqEqYWPXCZxC/wLl0Mcpf1xltwF7k1osm/AG
	 MIEY6S9I96uwgyce0sI/z8/gADgTuCe3dHiRpGezfUg2dlHaBmENbyMBoKajEm17eU
	 riz4VjeOy8vXg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UuDANPwB c=1 sm=1 tr=0 ts=67fd5fb6
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=2BRyyrYAQCg8EjViiqUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <7c5a2998-fe71-495f-8841-64e5b2ad03f2@ramsayjones.plus.com>
Date: Mon, 14 Apr 2025 20:19:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-SPAM-] Re: [PATCH v2 03/13] meson.build: only set build
 variables for non-default values
To: Patrick Steinhardt <ps@pks.im>
Cc: GIT Mailing-list <git@vger.kernel.org>, Junio C Hamano
 <gitster@pobox.com>, Adam Dinwoodie <git@dinwoodie.org>
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com>
 <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <280363cd569a8c6e870107eb219597b42911fed2.1743859985.git.ramsay@ramsayjones.plus.com>
 <a5795bfa-cc02-4c9a-b7d2-4924a94cd0db@ramsayjones.plus.com>
 <Z_y_Tp5pfJ-gZLEF@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <Z_y_Tp5pfJ-gZLEF@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGXmD6pkN7L49rPfumfqnf79iz43u864WKTWa2osne97YruY90a4XGxrlLP1ESr8DKXjqqF7+LiEwV5vszCTU/YIS6yJ1wLQWWLXCZ4+ki21nZxx0+iD
 VOhR2umgivmVuYNHo/4ShcpGcDuRepUJfKpg8Sp34qM+gspBllQjGSbpBsSO6byPdocQkFloYa2n8ErEPhwc3DAXmPfMzQfVz9o=



On 14/04/2025 08:54, Patrick Steinhardt wrote:
> On Sun, Apr 06, 2025 at 08:49:54PM +0100, Ramsay Jones wrote:
>>
>>
>> On 06/04/2025 20:38, Ramsay Jones wrote:
>> [snip]
>>> diff --git a/meson.build b/meson.build
>>> index 88a29fd043..efd0bd3319 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -693,10 +693,8 @@ endif
>>>  # These variables are used for building libgit.a.
>>>  libgit_c_args = [
>>>    '-DBINDIR="' + get_option('bindir') + '"',
>>> -  '-DDEFAULT_EDITOR="' + get_option('default_editor') + '"',
>>>    '-DDEFAULT_GIT_TEMPLATE_DIR="' + get_option('datadir') / 'git-core/templates' + '"',
>>>    '-DDEFAULT_HELP_FORMAT="' + get_option('default_help_format') + '"',
>>> -  '-DDEFAULT_PAGER="' + get_option('default_pager') + '"',
>>>    '-DETC_GITATTRIBUTES="' + get_option('gitattributes') + '"',
>>>    '-DETC_GITCONFIG="' + get_option('gitconfig') + '"',
>>>    '-DFALLBACK_RUNTIME_PREFIX="' + get_option('prefix') + '"',
>>> @@ -708,6 +706,17 @@ libgit_c_args = [
>>>    '-DPAGER_ENV="' + get_option('pager_environment') + '"',
>>>    '-DSHELL_PATH="' + fs.as_posix(shell.full_path()) + '"',
>>>  ]
>>> +
>>> +editor_opt = get_option('default_editor')
>>> +if editor_opt != '' and editor_opt != 'vi'
>>> +  libgit_c_args += '-DDEFAULT_EDITOR="' + editor_opt + '"'
>>> +endif
>>> +
>>> +pager_opt = get_option('default_pager')
>>> +if pager_opt != '' and pager_opt != 'less'
>>> +  libgit_c_args += '-DDEFAULT_PAGER="' + pager_opt + '"'
>>> +endif
>>> +
>>>  libgit_include_directories = [ '.' ]
>>>  libgit_dependencies = [ ]
>>>  
>>
>>
>> It would be somewhat remiss of me to not mention here that this does not
>> work for any but the simplest of values! :( If you set a simple single
>> 'bareword' like 'vim' or 'more' (even '~/bin/vi') then every thing works
>> just fine. However, if the value contains any of (at least) the following
>> characters: single quote, double quote or backslash, then things
>> stop working!
>>
>> [I spent one whole evening (and a bit - always something else to 'try')
>> trying to 'fix' this problem, without success]
> 
> Shouldn't it be possible to escape these values via `.replace()` [1]? I
> suspect that you already tried, but wanted to ask anyway :)

Yep. :)

I still haven't studied the meson documentation, but when I searched
for variations of 'quotes', the results showed that '... if you want
quotes, you will have to do it yourself ...'. So, I eventually found
'.replace()' in the 'string operations' section of the docs and tried
to reproduce what the Makefile does (see #2382):


  ifdef DEFAULT_EDITOR
  DEFAULT_EDITOR_CQ = "$(subst ",\",$(subst \,\\,$(DEFAULT_EDITOR)))"
  DEFAULT_EDITOR_CQ_SQ = $(subst ','\'',$(DEFAULT_EDITOR_CQ))

  BASIC_CFLAGS += -DDEFAULT_EDITOR='$(DEFAULT_EDITOR_CQ_SQ)'
  endif

which I translated into (on top of these patches):

  diff --git a/meson.build b/meson.build
  index 8f8a258064..608d665fd3 100644
  --- a/meson.build
  +++ b/meson.build
  @@ -708,7 +708,11 @@ libgit_c_args = [
 
   editor_opt = get_option('default_editor')
   if editor_opt != '' and editor_opt != 'vi'
  -  libgit_c_args += '-DDEFAULT_EDITOR="' + editor_opt + '"'
  +  editor_opt = editor_opt.replace('\\', '\\\\')
  +  editor_opt = editor_opt.replace('"', '\"')
  +  editor_opt = '"' + editor_opt + '"'
  +  editor_opt = editor_opt.replace('\'', '\\\'')
  +  libgit_c_args += '-DDEFAULT_EDITOR=' + editor_opt
   endif
 
[Actually, I think the very first attempt had:

  libgit_c_args += '-DDEFAULT_EDITOR=\'' + editor_opt + '\''

but meson, for some reason, adds a set of ' around the whole
-D argument to gcc, so I got rid of them - but it still didn't
work!]

Along with many, many, *many* such permutations! (trying to debug
this is hard work, with no help from meson).

So, just a little earlier this evening I read an email from Karthik
([PATCH v2 3/4] meson: add support for 'hdr-check') in which he
mentioned a problem with backslashes and referenced a github issue
on the mesonbuild repo [0], which is worth a read. ;)

Sorry I couldn't fix this issue, but it seems to be (in part) an issue
with meson. (Of course the example I used, which is taken directly
from the Makefile, happens to be particularly good at demonstrating
the problem!)

In any event, I think the current patch is a strict improvement, even
if it may need to be updated at a later date. I hope you agree.

Thank you for taking the time to review this series. I think this patch
was the only review comment that required a response - please let me
know, if that is not the case!

Thanks!

ATB,
Ramsay Jones

[0]: https://github.com/mesonbuild/meson/issues/1564


