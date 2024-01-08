Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F332C12B71
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="jfd8Ywf3"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1704706857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XRfU+jGFsnz9tudNSimWbnAgaqY5STbjgKVevKxIJs=;
	b=jfd8Ywf3iIZ9rChA9Hex14u+fEgicpb/SQYwZk7a8TG/F9NfSV6mqsOPfuDen6h71ckD2b
	mXFihQMe5ImKUxfVkcuRLqNJncH6gbAlxKq6xkdgJXVsdADRIAKG5YAYA40nxZsWU7K1c2
	b9+P3AbqeGlpcN2oieG9bAU91ID4HvyinHQq1jQPSbR2fJsROAJolTa7+i+WgwFu+TyIFr
	KNahn9Uc4o3/KHVU7APueYhTSARj/AjsOsSRGHCQk9dAZkFEoviYDxuPkF+d+zj62IG0co
	3V8nwz4QyXo/Paxsl0fvB0OxmC6lNqFr4ZVocucLz64YA0Rb+yTpCgaCeEPHjw==
Date: Mon, 08 Jan 2024 10:40:56 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Britton Leo Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/1] completion: send-email: don't complete revs when
 --no-format-patch
In-Reply-To: <9627364b-c0c9-4b85-a81a-ba1ef0735c9a@smtp-relay.sendinblue.com>
References: <9627364b-c0c9-4b85-a81a-ba1ef0735c9a@smtp-relay.sendinblue.com>
Message-ID: <0e8a1572100faae72db54becefe19f6b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-08 10:36, Britton Leo Kerin wrote:
> Along the way I taught __git_find_last_on_cmdline to understand '--', 
> which
> isn't stricly necessary but I think reads more clearly at the call 
> sites.
> __git_find_on_cmdline could be changed to work the same, or this part 
> dropped
> if people don't like it.

If I may suggest, there's no need for a cover letter for a single patch. 
  If you want to include some notes in the patch submission, which aren't 
supposed to be part of the commit summary, you can do that in the patch 
itself.

> Britton Leo Kerin (1):
>   completion: don't comp revs when --no-format-patch
> 
>  contrib/completion/git-completion.bash | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> 
> base-commit: e79552d19784ee7f4bbce278fe25f93fbda196fa
> --
> 2.43.0
