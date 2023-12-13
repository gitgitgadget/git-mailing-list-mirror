Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C00FRWAS"
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F3AD0
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 20:17:20 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-28ad7a26f4aso834478a91.0
        for <git@vger.kernel.org>; Tue, 12 Dec 2023 20:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702441040; x=1703045840; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4pGDoL5r2bhMVRGKoxghGklBDBycvViqmlej0wdiTeI=;
        b=C00FRWASNCQgzdR8pilSqiPqwHZBM6h7RhKrBpx9YoFVI4ka26TOaT/q2Dl3sqssHU
         oIqSOUF384LBvr+0lhWm4ys31pzqze6Cqoo/1tw8v+PUij4mkH2e46PZuFxKMd8tJEPD
         g9HvLappvZjWixW8/q45FtjpYCZFKRtU3pkaa/i2LbRLyHzmJ1EKG13FcP/qpDg9N7/P
         iP/Uqg0/Z1catQW5OgTFHBu5HiDA2/0Y7lcb9LnU3mbn8tQlpOSwa7tDvHwY2iXn8DyM
         5mq0hraf96VZAnbMq1nocvGZHkV9yIKbgKO3ewkKNWamGmBwSmdXhu9WtTO436BfLqg2
         ffjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702441040; x=1703045840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4pGDoL5r2bhMVRGKoxghGklBDBycvViqmlej0wdiTeI=;
        b=ai0d/biyjs1eCCsxLhxMtSyzQxKr2W1L/Picz1BcbJD+yZ/ncdyppWwJRQHpJnIARs
         JAyl9lDUNGKwA8B94noavuw4pPKeCcJW4qk8yN+piw0APgcmMDLzqnxMLWpcvfyOctc3
         1z8kXQ86xxJpoEXmxZbIndi59cVHBZlLfkScyqZQjIu0RMVv0V7aHwq1CJjDpzJ20sEV
         2oEF23PkLZ+32XFvFHeWVSQ7eupUGITrkG8UXu7TyRWbrwPcYIs0rRsjd6VpH32pUXg4
         oXvvuWPiK/H6+6i5GFgpcTU3U8RgfFOBVfSMiG0Rxc8OBEESDcMDQc9mykSreQQR6fQD
         FRbQ==
X-Gm-Message-State: AOJu0YxSEG1/T5b8/Yd1W5WD4CT80wBwIQgmz8V3pmnUqXE/+kZJhmeU
	Lwk2DCpznUxbNd11a/EfI2Gu7iWS+IE=
X-Google-Smtp-Source: AGHT+IGxWIqFPEN6XnzA4I9i7tPaG2XWx/arIRLcz+RUUwaXijUNTRrslw66dkJ1gEplBtMyBUCeBQ==
X-Received: by 2002:a17:90a:be06:b0:286:bb92:196c with SMTP id a6-20020a17090abe0600b00286bb92196cmr5811485pjs.18.1702441039994;
        Tue, 12 Dec 2023 20:17:19 -0800 (PST)
Received: from localhost ([14.191.94.177])
        by smtp.gmail.com with ESMTPSA id px6-20020a17090b270600b002609cadc56esm9992867pjb.11.2023.12.12.20.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 20:17:19 -0800 (PST)
Date: Wed, 13 Dec 2023 11:17:17 +0700
From: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
To: Haritha D <Harithamma.D@ibm.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Propose a change in open for passing in the file type.
Message-ID: <ZXkwTYD9nmPYn9UW@danh.dev>
References: <E1D54D98-3836-41CA-84B5-32AEAF7642D8@ibm.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1D54D98-3836-41CA-84B5-32AEAF7642D8@ibm.com>

On 2023-12-12 14:46:04+0000, Haritha D <Harithamma.D@ibm.com> wrote:
> Hi Everyone,
>  
> Am working on porting git to z/OS. For reference, the pull request am working on https://github.com/git/git/pull/1537.
>  
> On z/OS there is a notion of file tag attributes. Files can be
> tagged as binary, ASCII, UTF8, EBCDIC, etc. z/OS uses these
> attributes to determine if auto-conversion is necessary. It was
> recommended in PR that we add logic directly to xopen . In order for
> me to do this in xopen , I have to pass an extra parameter to xopen
> that specifies the file type. 
>  
> Ex: 
> xopen(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
>  
> To :
> xopen(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0666, BINARY);
>  
> BINARY: would be an enum value.

Would it work if you always open the file as BINARY? And let's all the
conversion done by git via some configs (core.encoding?)?

-- 
Danh
