Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C638556B6A
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705694573; cv=none; b=ggW3Al3c/hgizWDBlDagI/6AxRBySPIn274pH2X099DA2EfFzvILKy2R6XCHXr7ohlEg9LzdTvB6BFTJwRFZIPAuwRGQoWHK8kmMcZ9msCn1SEN2LpQaVw4dXYqAqrV8CoR5nVGUXg6X+9kA2e1IfvLcLknD0M0dpoQhMvjKRX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705694573; c=relaxed/simple;
	bh=Hgfah+T8gvVWy8ty9celRgLufycB+Pr3YEtqAbDMGT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mi7vQ9gkX30e7LP2noMMiq+ZL+GTF+y8v79mQP7T/6P0RHEin/35guHggVCL07C4ndpZGx9rFs4ZeeU1Hehwqnu92+hXmJcrAJE/wEGRgUKrw47+78tWoEnq2jKwsQwEfY+2Z3FsbdcCc5yZrxhQsoU2E/mUHMJ421FBUUev33c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu; spf=pass smtp.mailfrom=delpeuch.eu; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delpeuch.eu
Received: from [192.168.178.189] ([79.246.90.92]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1McIYO-1qqUO80LkK-00ckPI; Fri, 19 Jan 2024 21:02:36 +0100
Message-ID: <386c0318-0138-47c9-9e7f-d1004277226c@delpeuch.eu>
Date: Fri, 19 Jan 2024 21:02:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] merge-ll: expose revision names to custom drivers
Content-Language: en-US
To: Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
References: <pull.1648.v2.git.git.1705592581272.gitgitgadget@gmail.com>
 <pull.1648.v3.git.git.1705615794307.gitgitgadget@gmail.com>
From: Antonin Delpeuch <antonin@delpeuch.eu>
In-Reply-To: <pull.1648.v3.git.git.1705615794307.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:SusTAYsjCzvEbV4i5AIoQy2hUIY3r0mFrwLIC7nIHWzG69WpYAd
 a8Ko/yyJSfHfwXOCN7dyt3Nv4oRihXaRodCBZpDIUpqPZ6Ovw7ZbIU0USup7lJfkG1p5ejJ
 aNuRRtGqzopYtBo+d182bxgu0XhGvvxZzsJPgcT9G0ZZJi0qQu0ghp/ZGqv4Sct75+lhuOJ
 c/vU34UarcXRgB4dHIlhw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Doc1/Mn4KWo=;CaZfspSNsqTnPxDcSpq7RGOg6FB
 86uI2I2+kOVcykRcYym/CmgCKzcIxO9HkWOgqJwvfJQaSwLf89ysyRA2fj5++MsNE+f7PJdo5
 3VNO0BHvR3XhrSbVMcJYA/itUkdag1A5jSZtZget/Lh+EgERAyL3PJc8jKXcrmJBR71gnlFzt
 84vYEBJv5hS63qlh1BPds2/dJK8BZ/NQaQUoftIs1k1q43s5JN/f8PGdiIyhGwD5UVWVUmJ+8
 Ftjo48zTPR02u9g/+jJzEG9e8iEUUa83KBd0q5kEmxD4qr3ndkv5G34BvBf7GkhH/CL0kua7e
 z+w8u+fMMoLUdhNMQrjjrULOcwGWdnGl6h4bvFaaILqkjIvloQsBy1RDDYNuf7d4Zow6DKdBy
 9QDT7nOEUnDYVUIB8DRTsev7PktMtQk0SqtT4zLisQ55QO0h7dqaVBzWr3SfUpfkqyY/iEGID
 VZ3oaClipx5sU2x8/UsK1ILOXFXqkoXhRFHZ/U52nEaF8oWijKas/foEChph49X6t/9XB+l7+
 1TJLkA3LaQrG8tnYPljh5FVCZvmExxMbHJZXFGGvzGMwv+nHPM1rT0vCU1V2Lx9x7FLR5jE9x
 cE5f3Eqf4t/KqbZeuMSoMNM8y/INyV4jmZ8hK46/0DDcuDpKW/A3PTGUZmCjAQFuDqJnCAioE
 zP2N9PfRtJZ6TIXbcCXhdJii76mD4MDalPYxxUVDiuYR3uaVciPzaAdrVPl4BU3jfxPY3KPLU
 ZXssiuPC0iJ1z8IwY47IQ6DYxILUXaMtX2MCz+LbeP6a2Qx61NZQLisFlQyXa2bgP2ZqvU2hw
 rH5Cu20+fOcU82/mxB/HFyfhBeniqErq3QvpTb1KpIKwfGHvfydBD4v5Do0PYB8/8d/ylz9KK
 IbExLk1WdSdl/kQ==

Hi Junio,

After more testing (combining custom merge drivers with rerere) I 
realized that my patch can lead to a segmentation error. Many apologies 
for not having caught that earlier!

On 18/01/2024 23:09, Antonin Delpeuch via GitGitGadget wrote:
> @@ -222,6 +222,12 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
>   			strbuf_addf(&cmd, "%d", marker_size);
>   		else if (skip_prefix(format, "P", &format))
>   			sq_quote_buf(&cmd, path);
> +		else if (skip_prefix(format, "S", &format))
> +			sq_quote_buf(&cmd, orig_name);
> +		else if (skip_prefix(format, "X", &format))
> +			sq_quote_buf(&cmd, name1);
> +		else if (skip_prefix(format, "Y", &format))
> +			sq_quote_buf(&cmd, name2);

The "orig_name", "name1" and "name2" pointers can be NULL at this stage. 
This can happen when the merge is invoked from rerere, to resolve a 
conflict using a previous resolution.

I wonder what the appropriate fallback would be in such a case. I am 
tempted to use the temporary filenames of the files to merge instead, so 
that the merge driver can rely on those names being non-empty and being 
the best string to use to identify the files. Passing an empty string 
seems dangerous to me, as it is likely to change the index of arguments 
passed to the merge driver. Passing fixed strings such as "base", "ours" 
and "theirs" could perhaps work too.

Let me know if you have any preference about this.

Best,

Antonin


