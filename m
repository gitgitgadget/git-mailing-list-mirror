Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F801FAA
	for <git@vger.kernel.org>; Sat,  6 Jan 2024 04:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=initialcommit.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=initialcommit.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="w9wXdXUo"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-203fb334415so206961fac.2
        for <git@vger.kernel.org>; Fri, 05 Jan 2024 20:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1704516884; x=1705121684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2LqFYFmkHhkm/2fLse20rciCRsiv/Gj9mv3pj4JC9M=;
        b=w9wXdXUoNpsnnMfQt/HUKgmfqkcH3Bw6G+EjeJofl53eJEA2Gh5IVYI1Cm399h4faX
         JILZLpihg+FWafDkmItH0WUGkekr0ytm4wbr9MjitdL6GJusktoHWzHO0ibnGJ9Uge0T
         21BfUx81XIFFLr00zv/1iXm0zRCxwqLH4Jg8j2YJ9x8IMAm1XrQ4S+wzzPptqru+p9vR
         8+nPxvLeWA0xx5MF2PzHJ45k31Y0k1n+tIgHTo/DzvHogVebeXAb1Ai4r084b1ghOZp0
         UazEPwhylzHDCZX8ttF2nLksagq8xXHSwp6YtvO5ijKIAjaguFY0nhcxoHJIN8RaLFJG
         VSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704516884; x=1705121684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2LqFYFmkHhkm/2fLse20rciCRsiv/Gj9mv3pj4JC9M=;
        b=OJoZ0Lpjabv62uWkdaLMl/fNcbNqIxlWHRszkDmNQH/SSC5v52FWbdLKeYyH3VWCI7
         b4FXyxu0omDiG5ZeN1UGHqaiKMz0qBxOaYepUBI8YP1pjHQqy+5dNSvOYNQhaVrHOEVL
         6Up5EDbebMXc7iV+t1bzioWHSmPjYWL8d54zOEEeA9v9WcTQLI3F3lXQDGqq0neapw2w
         /fWn21yB3tHWxiLxyIk57vJjPagBxL6hy+y7cy6hD/HXp9/ywsuX2aOmhDiCG7PVqzgQ
         OTHjBnqfxbdldYOaINnQjGRYL4zNI0OmRd5eSfWybXAdk/hsOAk8n0RD9+GUhpcBcCxo
         FJ6w==
X-Gm-Message-State: AOJu0Yz1HgAu45Dipfi9rkloh6nrCzYuxzeV9/ptTOgPE+BV7bsvKnbc
	tmqWoX4NEete1LKw7cQPkTatwvCtk5WtgQ==
X-Google-Smtp-Source: AGHT+IHphVmPrFlpyJlqFX6GZ9Gn73ku80xm/ZX2oR4YOLtJtYqBmIWeFZVjr1zWu1dDHjavLW8Vbw==
X-Received: by 2002:a05:6870:ae01:b0:204:2d8a:bb8a with SMTP id uu1-20020a056870ae0100b002042d8abb8amr591758oab.27.1704516884723;
        Fri, 05 Jan 2024 20:54:44 -0800 (PST)
Received: from initialcommit.io (ip68-8-188-127.sd.sd.cox.net. [68.8.188.127])
        by smtp.gmail.com with ESMTPSA id e34-20020a635022000000b005cd8ada89e5sm2189475pgb.70.2024.01.05.20.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 20:54:44 -0800 (PST)
Date: Fri, 5 Jan 2024 20:54:41 -0800
From: Jacob Stopak <jacob@initialcommit.io>
To: Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] bugreport: include +i in outfile suffix as needed
Message-ID: <ZZjdEXb0ed4UTjiF.jacob@initialcommit.io>
References: <20231015034238.100675-2-jacob@initialcommit.io>
 <20231016214045.146862-1-jacob@initialcommit.io>
 <20231016214045.146862-2-jacob@initialcommit.io>
 <ZTrX4PMYtbVT-tUu@google.com>
 <ZTtZ5CbIGETy1ucV.jacob@initialcommit.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTtZ5CbIGETy1ucV.jacob@initialcommit.io>

Hey Emily!

Hope you had a great holiday!

I think this thread might have gotten lost in the shuffle.

I had replied to your feedback a couple months ago with a few questions.

It would be great to get your further input before I continue working on
this one.

Best,
Jack
