Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D746A48
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 06:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="MfaTTVdf"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6E8112
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 23:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1697957557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XukDMB439NBYH2JFHapGwHyxOzPFiaE/gwldWcTgHzA=;
	b=MfaTTVdfv73HaiHWMQXTgLJgiuQZg9KR8UPO2NjvHlXnCoRcw90ASbXHZZ4nUmDciOiWvp
	OAuzlx9HxHTb1b/xY28saRHaDjOhOUvtd6ul/waOg50YXSjb/1B9uK22q3ODJCdYtGIFOe
	jERI9kI3nnbRTNcLDMhEtYJfT9wMCEKUxyAzbihimZiZkTPCFBJt4E8OUcEGHQxuuTYj5j
	uYv0DcouOrD8d7Sk908RbTWtNiEOwBylYTDKNyNkWZAjkZauMxQPRBjO5PXTGyeUySni+O
	ka5xpRyaHhosW9uM/UiBiBIz7s6xb5swAaUuqO2dD4HlByIWStKpHA5vFIYSvw==
Date: Sun, 22 Oct 2023 08:52:36 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jacob Stopak <jacob@initialcommit.io>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
In-Reply-To: <ZTS7YsxSE8UA+n4G.jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <fd26df85661d554ced9d8e0445f75952@manjaro.org>
 <ZTL1wJIIK/5YWQK5.jacob@initialcommit.io>
 <d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org> <xmqqwmvgoovg.fsf@gitster.g>
 <ZTS7YsxSE8UA+n4G.jacob@initialcommit.io>
Message-ID: <d6c06aec7313b8078382e16065d04282@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-22 08:04, Jacob Stopak wrote:
> On Fri, Oct 20, 2023 at 04:28:19PM -0700, Junio C Hamano wrote:
>> 
>> You are not alone in feeling the impedance mismatch between the
>> intended audience the patch(es) try to help (pointy-clicky GUI
>> users)
> 
> I'm sure there's overlap with "pointy-clicky GUI users" but my point
> isn't to directly cater to them. I find it intersting to think about
> how visual (and ok fine even gui) tools can be used as bridge tools
> that can be discarded one the important concepts are solidified, and
> maybe resurrected in a moment of stupidity or strife.
> 
> It's like yes use the crutch if you need it, but then do it the real
> way once you get it.

Quite frankly, that would be like starting to learn how to drive a car 
by playing GTA 5, or whichever version of GTA it currently popular.  I 
don't think that would work out well for the vast majority of student 
drivers.

> And altho this is a visual helper feature, it keeps the user within the
> terminal, close to the Git cli and may help some subset stay there.

Even if that would work out for some people, it would require the 
formatting into tables to be the default for git, which frankly I'd 
never support.
