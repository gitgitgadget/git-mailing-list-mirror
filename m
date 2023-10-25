Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68AF30CE5
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfAHhrSI"
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081BA92
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 15:24:56 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c87a85332bso1666235ad.2
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 15:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698272695; x=1698877495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=motNA5jn9hY/hKLzKeESxZU3Qr7VyBlJelwuQ6/vcjQ=;
        b=PfAHhrSIhw3z0CWXFB4HEaY0gqKdCX5LK6676jIar3LdUM6oSEEVH9eAY01UqND266
         HeYHUdUpvzlosgUGgwGZEDr9hjOTKpcBhPru5JZW19XkzDNK8k+cPef5elPLVov3need
         cHKD+fZ/rCveKSNZs+WDZ5gAPoI7GAUn7gvtC8aYcgYaikujtsT3czz5QnmTpYzesxl0
         fc5W7F/zxgJtcVegFtJQ7scxGQ2rSfFsFRwXVTx2f3Qy9zg9+RyAwx1BVJUOpVjiPPTL
         Y8grsS9HVKSyYEVic9u6Yjdd1UIWelall1ZDIuIZhjKLJWd1h9/EV9mT2ccsLVUdd0I5
         b+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698272695; x=1698877495;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=motNA5jn9hY/hKLzKeESxZU3Qr7VyBlJelwuQ6/vcjQ=;
        b=JiIQ5L92fpKE+DJZDeM2wyOLvBJb6Kt8a1MvpdhczJiahZtza731ts9uVV3c7nwNMd
         1VsbCyN2l0jGwJ9MCyB7Z0zmnuhTvELflvzrqldx4CUpcxjlFIefnF+6lJSDjdM7Odq9
         O2eykPwRMiYa0A/c3LvMID0LbtQqj8fSB3NLTJS9do7KNOvAFEwxVOaQYLw3In/nOEB0
         N4HUfnYJySSlm+1c5b3M1eMjGWFX6SYjdJLTkRce4gVdjHbELCRzXNrboOkeyTEpw5/Z
         DJs8f4jGkPwLZ8RthaS5tOJxfn5vIk785RsZ3LQ1Vw3Mi0Rk4WeqXimNE8deK5I0B5Nn
         24KA==
X-Gm-Message-State: AOJu0Yyt/gAT8n0p0hduKakXP5vIEQu5xayQ7rt6MJYb+r33YhDiO/6X
	xplhgcBh5OhbFAv/I0kVLIH1OAYQa+s=
X-Google-Smtp-Source: AGHT+IEYP7Jcsn1B6nIpaRWbRbPbBBjSsuGN3/RwCQdQ96TDxcJz89TSHacAzqiuINsDcCl6zw5iiw==
X-Received: by 2002:a17:903:1383:b0:1ca:8e79:538f with SMTP id jx3-20020a170903138300b001ca8e79538fmr13749068plb.25.1698272695431;
        Wed, 25 Oct 2023 15:24:55 -0700 (PDT)
Received: from ?IPV6:2001:8003:3cef:4901:beb7:1ccc:62ea:5ce9? ([2001:8003:3cef:4901:beb7:1ccc:62ea:5ce9])
        by smtp.gmail.com with ESMTPSA id e13-20020a170902d38d00b001bb9d6b1baasm9721254pld.198.2023.10.25.15.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 15:24:54 -0700 (PDT)
Message-ID: <b73d2634-3a86-4aac-8eb0-98d7a990970b@gmail.com>
Date: Thu, 26 Oct 2023 09:24:52 +1100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: sahibzone@gmail.com
Cc: git@vger.kernel.org
References: <39e013af-69c7-4185-99ae-1e8fe5edef5c@gmail.com>
Subject: Re: Cloning new bare repository using ssh does not respect bare
 repository --initial-branch
Content-Language: en-US
From: Sheik <sahibzone@gmail.com>
In-Reply-To: <39e013af-69c7-4185-99ae-1e8fe5edef5c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Maintainers,


Sorry thought this wouldn't make it through due to html, please 
disregard this and see latest posted here 
https://lore.kernel.org/git/63eb269e-72b9-4830-98fc-aeef8b8180d7@gmail.com/


Thanks

Sheik


