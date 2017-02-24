Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8F59201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 23:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbdBXXge (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 18:36:34 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34371 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbdBXXgd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 18:36:33 -0500
Received: by mail-lf0-f53.google.com with SMTP id k202so1177315lfe.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 15:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=/HesYDWOsDKzrf/+o8kTrcETgZ/Jx/YqINx9OrMm+rw=;
        b=fPvReiXV3rTA1THPlzWnW92ku8iUZ17OyP5skt6pbnIStS+4vdiiLo9L21nuUe6avS
         eHFofn1K1APOqfzixUn63ziYFFxe2k8R5iDk3do0WJWEvaYPxne/h7F8fCnlfLYLHgKd
         ZmcA1vRYjqqWH1T7vSA95t4twt8/DMLbAbAy81j8YXDWRYYhkjLned4MpOSs8W943+E/
         7fiHPJf77y0qYVpbIthyTZu2ouPTIfZVPClL7ubYH68jp9ELQy5EdBv+1w9yMV9a4+KF
         gjsVjjCyLL3rOSOREmTcChUPF4oq/BQxP/JOvKEN8YhhEq6/I+KNkprhY6o0rKVtbdn7
         hPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=/HesYDWOsDKzrf/+o8kTrcETgZ/Jx/YqINx9OrMm+rw=;
        b=XmOy7RbLueNrOe2qxazymQFVYphpBD6R4JmxarVIss6yOgZpMiel+AlzzIsiedldcx
         h09atyUFe1R1H2kFPg21nlYIZ8yhZN78bs2k3qSQCKOq2rs8egQLBoeVjlRJ8mIydQeI
         T5195eSov+vlbWJDq3K50mpmFr3QGYW2HMehUpS8h0AV2ke1bLJxLQoqlDSiY3yFCSzB
         ASM3Xrsba+1bE8J1cO2xWaAwPgvPglrdJGqjBG0s27pVvbjFkzFC5h7S7n+wc7TM7c0a
         INKlwHmJbfUC1r56YGExg2VedkxPaR1jIAFxdTKa4TmW+R2ZNW5VMViQ9eZfkYCp4KAY
         yMjg==
X-Gm-Message-State: AMke39lAJksRYPnV8bemgxWP1qYrbHG1XjQhFOYTD1+GS//z3R2zMlarUxxWjijsb09DRg==
X-Received: by 10.46.84.24 with SMTP id i24mr1290173ljb.8.1487979346396;
        Fri, 24 Feb 2017 15:35:46 -0800 (PST)
Received: from [192.168.1.26] (acuy7.neoplus.adsl.tpnet.pl. [83.11.104.7])
        by smtp.googlemail.com with ESMTPSA id v21sm8974100ljd.9.2017.02.24.15.35.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Feb 2017 15:35:45 -0800 (PST)
Subject: Re: SHA1 collisions found
To:     Jeff King <peff@peff.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <9cedbfa5-4095-15d8-639c-0e3b9b98d6b9@gmail.com>
 <20170224230604.nt37uw5y3uehukfd@sigill.intra.peff.net>
Cc:     Joey Hess <id@joeyh.name>, git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <937d395f-77fe-b275-6cbe-f3477e24cd2f@gmail.com>
Date:   Sat, 25 Feb 2017 00:35:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20170224230604.nt37uw5y3uehukfd@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 25.02.2017 o 00:06, Jeff King pisze:
> On Fri, Feb 24, 2017 at 11:47:46PM +0100, Jakub Narębski wrote:
> 
>> I have just read on ArsTechnica[1] that while Git repository could be
>> corrupted (though this would require attackers to spend great amount
>> of resources creating their own collision, while as said elsewhere
>> in this thread allegedly easy to detect), putting two proof-of-concept
>> different PDFs with same size and SHA-1 actually *breaks* Subversion.
>> Repository can become corrupt, and stop accepting new commits.  
>>
>> From what I understand people tried this, and Git doesn't exhibit
>> such problem.  I wonder what assumptions SVN made that were broken...
> 
> To be clear, nobody has generated a sha1 collision in Git yet, and you
> cannot blindly use the shattered PDFs to do so. Git's notion of the
> SHA-1 of an object include the header, so somebody would have to do a
> shattered-level collision search for something that starts with the
> correct "blob 1234\0" header.

What I meant by "Git doesn't exhibit such problem" (but was not clear
enough) is that Git doesn't break by just adding SHAttered.io PDFs
(which somebody had checked), but need customized attack.

> 
> So we don't actually know how Git would behave in the face of a SHA-1
> collision. It would be pretty easy to simulate it with something like:

You are right that it would be good to know if such Git-geared customized
SHA-1 attack would break Git, or would it simply corrupt it (visibly
or not).

> 
> ---
> diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
> index 22b125cf8..1be5b5ba3 100644
> --- a/block-sha1/sha1.c
> +++ b/block-sha1/sha1.c
> @@ -231,6 +231,16 @@ void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
>  		memcpy(ctx->W, data, len);
>  }
>  
> +/* sha1 of blobs containing "foo\n" and "bar\n" */
> +static const unsigned char foo_sha1[] = {
> +	0x25, 0x7c, 0xc5, 0x64, 0x2c, 0xb1, 0xa0, 0x54, 0xf0, 0x8c,
> +	0xc8, 0x3f, 0x2d, 0x94, 0x3e, 0x56, 0xfd, 0x3e, 0xbe, 0x99
> +};
> +static const unsigned char bar_sha1[] = {
> +	0x57, 0x16, 0xca, 0x59, 0x87, 0xcb, 0xf9, 0x7d, 0x6b, 0xb5,
> +	0x49, 0x20, 0xbe, 0xa6, 0xad, 0xde, 0x24, 0x2d, 0x87, 0xe6
> +};
> +
>  void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
>  {
>  	static const unsigned char pad[64] = { 0x80 };
> @@ -248,4 +258,8 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
>  	/* Output hash */
>  	for (i = 0; i < 5; i++)
>  		put_be32(hashout + i * 4, ctx->H[i]);
> +
> +	/* pretend "foo" and "bar" collide */
> +	if (!memcmp(hashout, bar_sha1, 20))
> +		memcpy(hashout, foo_sha1, 20);
>  }
> 

