Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-ware.de header.i=@cs-ware.de header.b="IonfrYBE"
X-Greylist: delayed 76640 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Nov 2023 00:40:13 PST
Received: from srv1.79p.de (srv1.79p.de [213.239.234.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214589D
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 00:40:13 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPV6:2001:9e8:2bf4:7300:783b:600d:72e6:ec24] (unknown [IPv6:2001:9e8:2bf4:7300:783b:600d:72e6:ec24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id CB36B600094;
	Tue, 28 Nov 2023 09:40:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
	s=mail2023; t=1701160809;
	bh=Fl89Yy7bd8+vDD7IkYjV4Ypy1HkNRtSC891PBmV3ZoE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IonfrYBEHcA5+Z7eS0etx/4aRWjp2N9acLk9Q8Z0w8qmMVddb406aSM5HqpelkQU4
	 iKMjX/f0/VT3EXXVUZRE7yNHgS/+vxZQCyJByoSwtYt7b3Q/HOrwel5/XYHukcLoLf
	 Eqi2a8zDQ/ndvELm67RxGDMAWYu7M3jczyu7wzCx/8SPgukOLetTlzPyYhBtoao9Hn
	 alDn2MxmnQ05s1zwIOIV1NK9vmx/pAWOT0AIRdSgvUpPtatcOFUumpE3t2JJnyTHuf
	 5WBLC1DkVzsKGj6J/Wayf7poYs6pHaeTsfIjx2noTBgXMriHOdB7is1qSFwUNp+3e+
	 JFOI5VvHgFhgA==
Message-ID: <ab14260c-d515-425e-8ef6-5739d3d6ca4e@cs-ware.de>
Date: Tue, 28 Nov 2023 09:40:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: --end-of-options inconsistently available?!
Content-Language: en-US
To: Jeff King <peff@peff.net>
Cc: git <git@vger.kernel.org>
References: <4d944fe3-d31d-4859-8ed2-6c1da64410fe@cs-ware.de>
 <20231127212254.GA87495@coredump.intra.peff.net>
From: Sven Strickroth <sven@cs-ware.de>
Autocrypt: addr=sven@cs-ware.de; keydata=
 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
In-Reply-To: <20231127212254.GA87495@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 27.11.2023 um 22:22 schrieb Jeff King:
>> $ git rev-parse --symbolic-full-name --end-of-options master
>> --end-of-options
>> refs/heads/master
>>
>> Here, the output also contains "--end-of-options" as if it is a reference
>> (same for "--")
> 
> This one is intentional. rev-parse in its default mode is not just
> spitting out revisions, but also options that are meant to be passed
> along to the revision machinery via other commands (like rev-list). So
> for example:
> 
>    $ git rev-parse --foo HEAD
>    --foo
>    564d0252ca632e0264ed670534a51d18a689ef5d
> 
> And it does understand end-of-options explicitly, so:
> 
>    $ git rev-parse --end-of-options --foo --
>    --end-of-options
>    fatal: bad revision '--foo'
> 
> If you just want to parse a name robustly, use --verify.

I would expect that -- and --end-of-options are handled in a special way 
here so that rev-parse can also be used in scripts. I need to check 
whether --verify works for me (from the manual I thought I need to 
specify full reference names).

>> $ git checkout -f --end-of-options HEAD~1 -- afile.txt
>> fatal: only one reference expected, 2 given.
> 
> I think this is the same KEEP_DASHDASH problem as with git-reset.

I also found another problem:
$ git format-patch --end-of-options -1
fatal: option '-1' must come before non-option arguments

Where -1 is the number of commits here...

Best,
  Sven

