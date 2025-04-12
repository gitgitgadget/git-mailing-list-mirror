Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DB82367A0
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744448754; cv=none; b=dj358Qxg+bbsSJqgIxfpP3pJhIvPU143m8E+VLDnf6cLlvLvpBCsZoQYKkF5HfENDSavn97Wwm9H7yTzyt1lYaSTYt+mPrtTiHyypP2i677QUloSJIRkSukcoUCqMLjYZVnmYfAJ5TV2sWJX+tPaHUzbTeCoK8+k9BYko8pmqVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744448754; c=relaxed/simple;
	bh=qUeni7GdWJSXG4rJcNY96PW9mlnpYN0TpPiLiZI+aOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IojXUQY4m12UyrORXtYkPc8F/wQyL1jQEF11UXW0d06cafj59SM1k3iiZ3ilwb5MwMR8M0uU99fZ3U181MYE+smi8hlZ8guOuXNyHyAu7ga9J7M811lQJeZS++POqkwlkHOKPKlq0nWc9LAxLcuTbAsYVLPQgH8rTgN5BMSwj5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=seHVgb7o; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="seHVgb7o"
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 46D6CDF88CA
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 10:58:53 +0200 (CEST)
Received: from [198.18.194.9] (unknown [172.96.141.172])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id CDA4013F8C0;
	Sat, 12 Apr 2025 10:58:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1744448324;
	bh=qUeni7GdWJSXG4rJcNY96PW9mlnpYN0TpPiLiZI+aOU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=seHVgb7oUpc4ZaIhHH3FMeE5f0F/nC21Vdd6ENdOLcYVXWFtUFdMHQg65JjRwkIci
	 CKtD5e9x5+drnWLhikCoqEw4dBHSpBX3fZ3UzldWC5f5jgv7Cm3NP8TZpE12gPQqyB
	 jVI447UcTN3s3+Mn2XupFwsNXkBvLtYQLF9bQ2YHkTHvF8SnD1lxLEX8oLNo5XyTMn
	 +hEcE6zUjqMN7SAgn00NLlC2ct+8B7MQlsIrQPbD79CthUXTOoyvguuj2Tmq3htA7e
	 dELTR6W93Y82NQOhAYDI11kcBPE/f0kOPTD0ZYA6LCmB6oX/o2Tl+9tosi0IexfmiL
	 RQu9QcfhBlAww==
Message-ID: <0846bdd8-f2a6-43d9-83d1-73d9a5b04005@free.fr>
Date: Sat, 12 Apr 2025 16:58:37 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] doc: fix synopsis analysis logic
To: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1896.git.1743354964.gitgitgadget@gmail.com>
 <6206e65ac4d50e174ad7e3dbafaa590b632f214b.1743354964.git.gitgitgadget@gmail.com>
 <CAN0heSrfQMZ8=pFNuaqn_0bpLxhMtGiO8Vg2hXTo6aqq3rF4yQ@mail.gmail.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <CAN0heSrfQMZ8=pFNuaqn_0bpLxhMtGiO8Vg2hXTo6aqq3rF4yQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 05/04/2025 à 00:39, Martin Ågren a écrit :
> On Sun, 30 Mar 2025 at 19:16, Jean-Noël Avila via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> The synopsis analysis logic was not able to handle backslashes and stars
>> which are used in the synopsis of the git-rm command. This patch fixes the
>> issue by updating the regular expression used to match the keywords.
> 
>> --- a/Documentation/asciidoctor-extensions.rb.in
>> +++ b/Documentation/asciidoctor-extensions.rb.in
>> @@ -50,7 +50,7 @@ module Git
>>        def process parent, reader, attrs
>>          outlines = reader.lines.map do |l|
>>            l.gsub(/(\.\.\.?)([^\]$.])/, '`\1`\2')
>> -           .gsub(%r{([\[\] |()>]|^)([-a-zA-Z0-9:+=~@,/_^\$]+)}, '\1{empty}`\2`{empty}')
>> +           .gsub(%r{([\[\] |()>]|^)([-a-zA-Z0-9:+=~@,/_^\$\\\*]+)}, '\1{empty}`\2`{empty}')
>>             .gsub(/(<[-a-zA-Z0-9.]+>)/, '__\\1__')
>>             .gsub(']', ']{empty}')
>>          end
>> @@ -72,7 +72,7 @@ module Git
>>            %(<inlineequation><alt><![CDATA[#{equation = node.text}]]></alt><mathphrase><![CDATA[#{equation}]]></mathphrase></inlineequation>)
>>          elsif type == :monospaced
>>            node.text.gsub(/(\.\.\.?)([^\]$.])/, '<literal>\1</literal>\2')
>> -              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$]+\.{0,2})+)}, '\1<literal>\2</literal>')
>> +              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$\\\*]+\.{0,2})+)}, '\1<literal>\2</literal>')
>>                .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<emphasis>\1</emphasis>')
>>          else
>>            open, close, supports_phrase = QUOTE_TAGS[type]
>> @@ -100,7 +100,7 @@ module Git
>>        def convert_inline_quoted node
>>          if node.type == :monospaced
>>            node.text.gsub(/(\.\.\.?)([^\]$.])/, '<code>\1</code>\2')
>> -              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$]+\.{0,2})+)}, '\1<code>\2</code>')
>> +              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$\\\*]+\.{0,2})+)}, '\1<code>\2</code>')
>>                .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<em>\1</em>')
> 
> This seems to introduce some extra spacing in the rendered man pages, e.g.,
> "The bundle.*  keys" or "Fileglobs (e.g.  *.c)". (Asciidoctor 2.0.18.) I
> haven't dug into the regexes so see what might be the cause.
> 

The xml regex seems ok for this. The docbook output is as follows:

(...)
pairs in this list are in the <literal>bundle.*</literal> namespace (see
(...)

The manpage output seems also correct:

(...)
would accept (with the
\fB\-\-file\fR
option)\&. The key\-value pairs in this list are in the
\fBbundle\&.*\fR
namespace (see
(...)

Strangely, the --file above is rendered correctly, but the bundle.*
below not. I do not know TROFF to assess what is going on. Has '*' a
special behavior in a bold span?

JN

