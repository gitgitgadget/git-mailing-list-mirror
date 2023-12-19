Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E00711725
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d47Iq/V6"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d190df5d0so24802825e9.3
        for <git@vger.kernel.org>; Tue, 19 Dec 2023 00:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702975322; x=1703580122; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZ+mRYR4ZuIXNnMs9/cNBaByPR4a4sdcF8Ik2YtQRXM=;
        b=d47Iq/V6P31+nUVDnnXuQ3iLl+DSwRO7V5DqpjedMImcztg8fy7S+meRP3iUAIygWm
         cYjaMC1PwpF+145czgNV2K3G7mkf+eRkYslzdtuKUEC6Rc1tsyokwGzj1NyIDVwRnHCX
         BWxPp/xsrT5+7+lZv1AXJvNR/DOrkZHK26ZDr7Bp1wj52QZrAnDZ1K0o1o3bVcTg+Oi6
         8amZn4gXuIDrVmnEwzTJax/Jyt15lP+UnSyBSbOOqgcokBgNe3/B9iYOB1jSBG0+0pS6
         +AQurXpsaqwitX0fjXYWfZkgD/bnB9pcB1/NB5VJPbdmRAt9TeHz3+rJaezW304MMJab
         0VGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702975322; x=1703580122;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZ+mRYR4ZuIXNnMs9/cNBaByPR4a4sdcF8Ik2YtQRXM=;
        b=ijMCaJsixwHuvs4q8vf6qoSUllG6FAk8afxXR54+oVOgvEcyH2lWgCZKnIouNbXr3D
         cYVB5GgHV5L3Z/OXK0IH8TzpWyLo6M3q9omY0hTNf634B7Qyp5Kye7lkvqsQR66DvFDO
         i5Iu054yoKwqIwQrYj604U5jhO4n2MWEdYzmETLUrWwtbEkpHlown4Sphb90XJ0nhl44
         oFAbXhIHGMiYN2ulDt09CLfN6PiZLIoVgrvl5DNDDSeWbRRCoxFV0JHl9SufGLqqkm5M
         p8sw9yfAjdNXdUMLXIB00WLNCMdcR4aNYRUOvw/qLDjaE6cUPmPwer7RM5nhIvW2/qtz
         2ilQ==
X-Gm-Message-State: AOJu0YxG8Hhy13ltDVsfankQvUKGpqSov3T9dEU/iPUWx6OOcknBfYqH
	/WB9D2lFAsRIueDkkXlLo47pFVpiBNA=
X-Google-Smtp-Source: AGHT+IHB5GSStbJWfrSeYCgQZ2nFDNcwp4T1kx+4mm9qwuHV5CCZUNS5Ph+oa1LeIHhobIXYickXSQ==
X-Received: by 2002:a05:600c:5487:b0:40c:6e33:c1e8 with SMTP id iv7-20020a05600c548700b0040c6e33c1e8mr3349329wmb.168.1702975322307;
        Tue, 19 Dec 2023 00:42:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m26-20020a05600c3b1a00b0040b2b38a1fasm1779447wms.4.2023.12.19.00.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 00:42:01 -0800 (PST)
Message-ID: <c0db8336e519cb43767effbe842dc8b97f914a4b.1702975319.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 Dec 2023 08:41:53 +0000
Subject: [PATCH 2/8] CodingGuidelines: write punctuation marks
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Josh Soref <jsoref@gmail.com>,
    Josh Soref <jsoref@gmail.com>

From: Josh Soref <jsoref@gmail.com>

- Match style in Release Notes

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 Documentation/CodingGuidelines | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index af94ed3a75d..578587a4715 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -578,7 +578,7 @@ Externally Visible Names
    . The variable name describes the effect of tweaking this knob.
 
    The section and variable names that consist of multiple words are
-   formed by concatenating the words without punctuations (e.g. `-`),
+   formed by concatenating the words without punctuation marks (e.g. `-`),
    and are broken using bumpyCaps in documentation as a hint to the
    reader.
 
-- 
gitgitgadget

