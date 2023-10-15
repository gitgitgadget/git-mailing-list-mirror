Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD41110A
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 03:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="LiWNpCQX"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A360D9
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 20:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1697339581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+VwjAhlDOmngpJS0LnYAPrxVh8WgMqQyPmQx2K9BvO4=;
	b=LiWNpCQXjCFUQPDcJKmtkV3Nb+6xCs1k50ZhWMg2MjuCUva9OKOjJdpEZU0atm/9TrybTE
	ymnzZRRZWYlwRyM/IjQTwUH5KJU1ZpLWDhmSnZNhbAnDa6kbEHCLuCsLgkmO/T6lqhTxXd
	YXer1B+MqLyCZMO99s5VMICZN8g669QXw0zJpm71ZFqllL9qdIDa3dXrEcTOn08S7f+od7
	M6ZnubMv13GRFts2bRsqHBJPep78qivStW1MqdIGoUlNq811uZhSodmNQGqMjp/FBxV33N
	eEBPDXxCXzpO16sF9W7iCkvwpsM2L7jAmPb9P9ZfygmsrAlZssPVaGU3C5mt9w==
Date: Sun, 15 Oct 2023 05:13:00 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jacob Stopak <jacob@initialcommit.io>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] bugreport: add 'seconds' to default outfile name
In-Reply-To: <ZStXbjgFTlO11Pp7.jacob@initialcommit.io>
References: <20231014040101.8333-1-jacob@initialcommit.io>
 <xmqq4jitw4nk.fsf@gitster.g> <833da2d05d4b1dfa8e561aa638a927b0@manjaro.org>
 <xmqqa5slt7wa.fsf@gitster.g> <438a5edf1a17ffac201436a950ce50fa@manjaro.org>
 <ZStXbjgFTlO11Pp7.jacob@initialcommit.io>
Message-ID: <d0e4d8f24a0d7a9bada2b05631a836a6@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-15 05:07, Jacob Stopak wrote:
> On Sat, Oct 14, 2023 at 07:52:32PM +0200, Dragan Simic wrote:
>> 
>> Speaking in general, I somehow find "20220712" a bit more readable 
>> than
>> "2022-07-12" as part of a filename, but that's of course just my 
>> personal
>> preference.
> 
> It's funny how we all have our own preferences for this kind of thing.
> Mine happens to be separating the date part from the rest of the
> filename with an underscore, but using a hyphen to separate individual
> date components like:
> 
> filename_2022-07-12.ext

Yes, it's quite funny.  I gave it some thought, and I think that my 
preference is a result of dealing with many PDF files containing 
schematics, for which some kind of a defacto standard is the "-20220712" 
naming convention.
