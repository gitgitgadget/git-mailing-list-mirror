Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AADEC6
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 02:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYnTsUsR"
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE6CF3
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 19:38:31 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5ab2cb900fcso3326886a12.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 19:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698719911; x=1699324711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whnGfUwq6TmLT7xxOVIJOterRQ1M4hIB+srydLRFLRw=;
        b=jYnTsUsRtjdDq0QyQPJdU53nBsD2m2XM4gklLXMQBRcmQdUiFDvVVfB+77sPuFBn3s
         rc5EtgLfYXI3Al7KI3KtqNMQWeLwNjxED6yg1+CDRclAGltBLwPfFVI4QKLqqoStGbPq
         7D4TUpfrVd0ZfmZjCeWPCTNLaVVfn5t9Y1Y9XGHSQZhuq8qLH0xzGIonmBxTtfn5ElU/
         aBr07Jveyr6cBra27xfLKZM7r42BOTShGjiTnnI0BsfukhZJzqlbrrBnkSvJDRSUZKvr
         p0mlsJLaagTFNDDdbhohvktQUS0TdV3mRrR1647BOxZfi6UiTS7vxrkHr9s46XcfwVBU
         NS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698719911; x=1699324711;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=whnGfUwq6TmLT7xxOVIJOterRQ1M4hIB+srydLRFLRw=;
        b=J1G0AL/9roqkXWc+bo9MdN9x9QnqjL0xsR5rwyEfAyca+nsh/Me8yOMJggr5N0wBuK
         /X0/O3OIXWJtYUm7E9fTAiNV+3T58+dIvKp8IaaG/DW02w7Y9O2SpliAbem5qVBNkZsM
         Rp2+ksMxYtfRm6kD0apNUmGWc4RrBk+6gXGap47qE1PiA93+pQx9GbPahjf6DtGa5fb+
         nE6P7a9iIkdny0J8zeFx63bJzX/ivXnJZkS6WEtGmTboAg+jyK1xLk4kD5QGC3YBajb7
         EihGxt/QVUqaymDvkGMunJwQsp76xfH+IClHYUNlUOZD9+CmuoLr+oPSmS/yvdOrsHny
         KV0w==
X-Gm-Message-State: AOJu0YwtzBJ6h8ET9+0m5mHVrLz/7c5wD9cMyBVl714DciUe5qkP2tK+
	kzOa3H0GcmySk+jd8JXIZr8=
X-Google-Smtp-Source: AGHT+IHXcI1YRmqkM06dPaE4DFV1qTIsiKv8245OIlk9OjtdFSBADAwbpezQXmG0ZOGyKNrdJ07wHw==
X-Received: by 2002:a05:6a21:32aa:b0:15f:b5:bfee with SMTP id yt42-20020a056a2132aa00b0015f00b5bfeemr11722544pzb.5.1698719910925;
        Mon, 30 Oct 2023 19:38:30 -0700 (PDT)
Received: from ?IPV6:2001:8003:3cef:4901:beb7:1ccc:62ea:5ce9? ([2001:8003:3cef:4901:beb7:1ccc:62ea:5ce9])
        by smtp.gmail.com with ESMTPSA id jb21-20020a170903259500b001bc930d4517sm185965plb.42.2023.10.30.19.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 19:38:30 -0700 (PDT)
Message-ID: <b7feb821-d041-47bd-9058-2f393499f62c@gmail.com>
Date: Tue, 31 Oct 2023 13:38:27 +1100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: sahibzone@gmail.com
Cc: git@vger.kernel.org, peff@peff.net
References: <9cec7307-a875-4b8c-9abe-81c8879d698b@gmail.com>
Subject: Re: Repository cloned using SSH does not respect bare repository
 initial branch
Content-Language: en-US
From: Sheik <sahibzone@gmail.com>
In-Reply-To: <9cec7307-a875-4b8c-9abe-81c8879d698b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Wondering whether a link to the protocol documentation should be added 
in "git init --initial-branch" to make this more obvious.

 1. https://git-scm.com/docs/git-init#Documentation/git-init.txt---initial-branchltbranch-namegt
 2. https://git-scm.com/docs/gitprotocol-v2


Thanks

Sheik

