Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862D444CAC2
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480921; cv=none; b=prvH7BD8BS0OpYQTDaI8wa1/Vl9RFIHbyp0LYqwbJy6wx983TAifHYluD/Pfs4CdGEw6CFRUbzfVB6rQy2bE5I3yLxfm3MXournRy0gSASE1S8OepKAhcV7ciVMS/5B7MY1JpQMMQmxouyw4tk7Yv0qYMJMQ9aWqlQH4i5N9Z3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480921; c=relaxed/simple;
	bh=Fd9wesE+3WCzTzZmktUMcySZwGArlMqBoZi/rI2tbqo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cieged/kLjzXfcZqG5uxwNVJgbRwlcoZJ6f+nZpExCzavl1zvDRxhP3cHoUESxL592T/GVRbHGdqkg3fnxav+cU/2Omr+FOJkXnzgFF4Bw0Gy4lERra6t2BNQIPY9yv7zbDgDuyvjA2BkhP6mVeQxzU+2AnG98G163yoLC4Mcg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=DRl17Na8; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="DRl17Na8"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 653A1kRL020445-653A1kRN020445
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 3 Jun 2026 13:01:46 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wUiPy-000IUH-Ff;
	Wed, 03 Jun 2026 13:01:46 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 3 Jun
 2026 13:01:46 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 60b0eaa4;
	Wed, 3 Jun 2026 10:01:45 +0000 (UTC)
Date: Wed, 3 Jun 2026 13:01:45 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Patrick Steinhardt <ps@pks.im>
CC: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, Weijie Yuan
	<wy@wyuan.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 1/3] Documentation/MyFirstContribution: recommend
 shallow threading
Message-ID: <20260603100145.7iym5%taahol@utu.fi>
In-Reply-To: <20260603-pks-b4-v2-1-a8aea0aa2c23@pks.im>
References: <20260603-pks-b4-v2-0-a8aea0aa2c23@pks.im>
 <20260603-pks-b4-v2-1-a8aea0aa2c23@pks.im>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-02.utu.fi (130.232.247.42) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsH
 BUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIXUhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhRSBgbKBgDG0YB
 BUhYSFpfSBoJBRsJESgaCQUbCRECBwYNG0YYBB0bRgsHBUhYSFlaSB8RKB8RHQkGRgcaD0hY
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=kOMNkfRLfBkol8QCOOwR/IAEGnH7SAsdoUB8wkQxZyA=;
 b=DRl17Na8eNj2HQwruHCrKAn/76jA4F/1ZOWslPmw02+TMHTPAyow6+AeMWnWRULZC5t07fJ840Af
	YhFMTZAROTT5EAIXHqKLmDVNOvQygoc1PTY+wK9kP5HBu/30YKC0zVotQdX9scKDBaO2ReMerfY4
	TssdKtbDir6y2Hlt2doBfSja977mOALXeNpJAotULfhYPpXteV1f8XaxoccvL+GB9sM5sB+gUIhv
	wFStYzeSDJveqQngxL5XkxZK+zw6sZuqQ5f92WGdOrE82gDC0VUdL0howYv7eLsL5qvl5E48hFUM
	QW10rXYEl7OUlfm1nb6ULRdTIlf1Wm1HP+8cGw==

Patrick Steinhardt <ps@pks.im> wrote:

> The "MyFirstContribution" document recommends the use of deep threading:
> every cover letter of subsequent iterations shall be linked to the cover
> letter of the preceding version. The result of this is that eventually,
> threads with many versions are getting nested so deep that it becomes
> hard to follow.
> 
> Adapt the recommendation to instead propose shallow threading: instead
> of linking the cover letter to the previous cover letter, the user is
> supposed to always link it to the first cover letter. This still makes
> it easy to follow the iterations, but has the benefit of nesting to a
> much shallower level.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/MyFirstContribution.adoc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index b9fdefce02..069020196c 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -1227,8 +1227,8 @@ Message-ID: <foo.12345.author@example.com>
>  
>  Your Message-ID is `<foo.12345.author@example.com>`. This example will be used
>  below as well; make sure to replace it with the correct Message-ID for your
> -**previous cover letter** - that is, if you're sending v2, use the Message-ID
> -from v1; if you're sending v3, use the Message-ID from v2.
> +**first cover letter** - that is, for any subsequent version that you send,
> +always use the Message-ID from v1.
>  
>  While you're looking at the email, you should also note who is CC'd, as it's
>  common practice in the mailing list to keep all CCs on a thread. You can add
> 
> -- 
> 2.54.0.1064.gd145956f57.dirty

If we adapt this change to the guidance, let's fix also other places of the
document that talk about replying to the previous cover letter.

-----8<-----

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 069020196c..bf64a211bd 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -790,7 +790,7 @@ We can note a few things:
   v3", etc. in place of "PATCH". For example, "[PATCH v2 1/3]" would be the first of
   three patches in the second iteration. Each iteration is sent with a new cover
   letter (like "[PATCH v2 0/3]" above), itself a reply to the cover letter of the
-  previous iteration (more on that below).
+  first iteration (more on that below).
 
 NOTE: A single-patch topic is sent with "[PATCH]", "[PATCH v2]", etc. without
 _i_/_n_ numbering (in the above thread overview, no single-patch topic appears,
@@ -1214,7 +1214,7 @@ between your last version and now, if it's something significant. You do not
 need the exact same body in your second cover letter; focus on explaining to
 reviewers the changes you've made that may not be as visible.
 
-You will also need to go and find the Message-ID of your previous cover letter.
+You will also need to go and find the Message-ID of your original cover letter.
 You can either note it when you send the first series, from the output of `git
 send-email`, or you can look it up on the
 https://lore.kernel.org/git[mailing list]. Find your cover letter in the
