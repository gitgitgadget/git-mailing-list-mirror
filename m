Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="4135NrQN"
X-Greylist: delayed 588 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Nov 2023 11:35:50 PST
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788AA9E
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 11:35:50 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E6941F406;
	Wed, 15 Nov 2023 19:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1700076362;
	bh=Ih08R5vmkZ7Pegcy3SVzLstxTF3sQq8X6Oz0yL2ANpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=4135NrQNeSaaPbnVPuYlQG88OnvedmsaIllYQS3hGj8rQWKPSJWKQQkM0VdlVHudz
	 HWuk8J9Ux6/hzlIHczKrDqgvIVNfVKWsIVPvi+G9B4JM2ywHx8xtUNiaKEqRUcybuB
	 KARhbW9c/YdGzYt/MaY8TXB4hcd4n3PE9DNBdLRs=
Date: Wed, 15 Nov 2023 19:26:02 +0000
From: Eric Wong <e@80x24.org>
To: Alan Dove <alan.dove@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Bug: "Received" misspelled in remote message
Message-ID: <20231115192602.M277588@dcvr>
References: <4e76dda1009a8365a1d66d9594865a4af31ab418.camel@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e76dda1009a8365a1d66d9594865a4af31ab418.camel@gmail.com>

Alan Dove <alan.dove@gmail.com> wrote:
> Hello:
> 
> Using Git 2.40.1 on a private server, I see this message whenever I
> push a commit:
> 
> "remote: Recieved update on checked-out branch, queueing deployment."

Hi Alan, that's likely from a hook on the server itself.
Those phrases aren't a part of git at all.
