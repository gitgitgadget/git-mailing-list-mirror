Received: from mail.comstyle.com (speedy.comstyle.com [206.51.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773D32F4321
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 04:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.51.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749701610; cv=none; b=qX4sCCpZzwxVDVjgvKm/SLR/3mdfyZyeIqj3xPZP7MSxsGpwX1Etlu2qEWEyPb7iPkx0s/w70DoGNzgT7cjVr2i7QZrFmagTSDg3h93yxjH4uZPWQSud7voCk2cWfPPkCwIIJYLDwvDldCtNzKe/r5ij4cTo/J39gWLs6CXS+s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749701610; c=relaxed/simple;
	bh=nVsZcLg6IOkipqF6W2Tx5QdBkTDb+YaIo8lLUTgzYSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUkkjPfh8wn/pcI+sSrIlz2G7Yp1v/WMA+iNHLEhEiwl1Bwhwkm8jalI0gXPdv2btY8HdWYOEdm6y4ylyl4ay7/g5Jxf/WgoLdYLvfYGRc+YooR5MPFnB/mpldw4kukqAOoQjAVVD2/chhFZubJPbDQEI0WA407ENkfnEjhIjzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com; spf=pass smtp.mailfrom=comstyle.com; dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b=XNjJjbk1; arc=none smtp.client-ip=206.51.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comstyle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="XNjJjbk1"
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 4bHpzq2nvCz8PbP;
	Thu, 12 Jun 2025 00:13:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=default;
	 bh=nVsZcLg6IOkipqF6W2Tx5QdBkTDb+YaIo8lLUTgzYSA=; b=XNjJjbk1WNOM
	ES9KuyY8N7HMYcv96yIjAczLNKF4QeAIRgM4I0g889WAc2aOLnnX0iDJFeQDVVs1
	npVoXac39T3Qr8k9ivdD/8/WauV+1c0S0xOrHilBW73NFxV35GG+IGKPi+vzHYZW
	r4VWkNTAba4Txg3uobz2s2jzvjiSBS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
	:date:mime-version:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=default; b=q9U
	Uz0FEBJXCnyll/9NKaH2lRQ33gBlrfqDm19QpdzIg941lRbAeA1cNYuDU0K/yK+9
	cdHblsf8YgqoCR+ULXMfFJGl2BPX5+ZvlvmUYFCOYUrB8AS70K9GtPFS43H9Byxl
	81HQWfQ8aLJIVy3C50HeAmZ+EM9UR8tIFAlDa9p8=
Received: from [IPV6:2001:470:b050:6:142d:4b81:8fea:90b2] (unknown [IPv6:2001:470:b050:6:142d:4b81:8fea:90b2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 4bHpzq00b8z8PbN;
	Thu, 12 Jun 2025 00:13:26 -0400 (EDT)
Message-ID: <caaa5d54-d32d-40b3-9bf3-0f322e7c4316@comstyle.com>
Date: Thu, 12 Jun 2025 00:13:25 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Solaris sed
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <09f954b8-d9c3-418f-ad4b-9cb9b063f4ae@comstyle.com>
 <xmqqo6utfvxu.fsf@gitster.g>
Content-Language: en-US
From: Brad Smith <brad@comstyle.com>
In-Reply-To: <xmqqo6utfvxu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2025-06-12 12:03 a.m., Junio C Hamano wrote:
> Brad Smith <brad@comstyle.com> writes:
>
>> Building on Solaris I noticed the following two issues with Solaris se=
d.
>>
>>  =C2=A0=C2=A0=C2=A0 GEN version-def.h
>> sed: Missing newline at end of file standard input.
> Perhaps it is this input line it is complaining about.  sed works on
> text files, and a file that ends in incomplete line was not quite
> text.
>
> -REPLACED=3D$(printf "%s" "$INPUT" | sed -e "s|@GIT_VERSION@|$GIT_VERSI=
ON|" \
> +REPLACED=3D$(printf "%s\n" "$INPUT" | sed -e "s|@GIT_VERSION@|$GIT_VER=
SION|" \
>   	-e "s|@GIT_MAJOR_VERSION@|$GIT_MAJOR_VERSION|" \
>   	-e "s|@GIT_MINOR_VERSION@|$GIT_MINOR_VERSION|" \
>   	-e "s|@GIT_MICRO_VERSION@|$GIT_MICRO_VERSION|" \
>
>>  =C2=A0=C2=A0=C2=A0 GEN config-list.h
>> sed: illegal option -- E
>> Usage:=C2=A0 sed [-n] script [file...]
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sed [-n] [-e script]...[-f=
 script_file]...[file...]
> This is a bit trickier but should be doable.  It does not like the
> -E option to use ERE (as opposed to BRE) for pattern matching used
> in generate-configlist.sh script.
>
> 	sed -E '
> 	/^`?[a-zA-Z].*\..*`?::$/ {
> 	/deprecated/d;
> 	s/::$//;
> 	s/`//g;
> 	s/^.*$/	"&",/;
> 	p;};
> 	d'
>
> I think the only problematic one is the first address, whose BRE
> equivalent I think is
>
> 	/^`\{0,1\}[a-zA-Z].*\..*`\{0,1\}::$/
>
> In practice, I suspect \{0,1\} is unnecessarily strict and using
> something looser like
>
> 	/^`*[a-zA-Z].*\..*`*::$/
>
> may be sufficient.  Replace the address expression associated with
> the {editing command} and drop "-E", and use "-e" for readability,
> perhaps?
>
> Totally untested patch follows.
>
>   GIT-VERSION-GEN        | 2 +-
>   generate-configlist.sh | 8 ++++----
>   2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git c/GIT-VERSION-GEN w/GIT-VERSION-GEN
> index 208e91a17f..de989657fb 100755
> --- c/GIT-VERSION-GEN
> +++ w/GIT-VERSION-GEN
> @@ -82,7 +82,7 @@ read GIT_MAJOR_VERSION GIT_MINOR_VERSION GIT_MICRO_VE=
RSION GIT_PATCH_LEVEL trail
>   $(echo "$GIT_VERSION" 0 0 0 0 | tr '.a-zA-Z-' ' ')
>   EOF
>  =20
> -REPLACED=3D$(printf "%s" "$INPUT" | sed -e "s|@GIT_VERSION@|$GIT_VERSI=
ON|" \
> +REPLACED=3D$(printf "%s\n" "$INPUT" | sed -e "s|@GIT_VERSION@|$GIT_VER=
SION|" \
>   	-e "s|@GIT_MAJOR_VERSION@|$GIT_MAJOR_VERSION|" \
>   	-e "s|@GIT_MINOR_VERSION@|$GIT_MINOR_VERSION|" \
>   	-e "s|@GIT_MICRO_VERSION@|$GIT_MICRO_VERSION|" \
> diff --git c/generate-configlist.sh w/generate-configlist.sh
> index 9d2ad6165d..75c39ade20 100755
> --- c/generate-configlist.sh
> +++ w/generate-configlist.sh
> @@ -13,16 +13,16 @@ print_config_list () {
>   	cat <<EOF
>   static const char *config_name_list[] =3D {
>   EOF
> -	sed -E '
> -/^`?[a-zA-Z].*\..*`?::$/ {
> +	sed -e '
> +	/^`*[a-zA-Z].*\..*`*::$/ {
>   	/deprecated/d;
>   	s/::$//;
>   	s/`//g;
>   	s/^.*$/	"&",/;
>   	p;};
> -d' \
> +	d' \
>   	    "$SOURCE_DIR"/Documentation/*config.adoc \
> -	    "$SOURCE_DIR"/Documentation/config/*.adoc|
> +	    "$SOURCE_DIR"/Documentation/config/*.adoc |
>   	sort
>   	cat <<EOF
>   	NULL,


No errors or warnings after this is applied.

