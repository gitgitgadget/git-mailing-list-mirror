Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D51D1365
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 02:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="weQBw7d1"
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F35F3A8D
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 18:09:26 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-5875e24c749so776480eaf.1
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 18:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699582165; x=1700186965; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4tSwyKxPn6bljYRHS+2PTvOJ3Wz8YIquDPa/HZ56nOg=;
        b=weQBw7d1VQPTdyX5QKJ/Qqjz3qUYQrmfGKL7WLmJYkE6k6Mps2Mx7WJpon73fuKVPZ
         Fy/WY+hWcWYluclkBPSjC3o0eBzNHtutn9+6CguPm9bGN6HmUlcWO4lieYZ5mn1jowgt
         RNOgFoWF5W703wC9Zv5KuyDnUDcmpFlPH1H3f7XmMycX+QxUej2FdzbxwSKKm37QL1S5
         FskCLRWrJ6Vmo0cK177cqpYTNXeC0lvnMoSzlSNrXQlFczpax5/+b6BzRHaJVnKoW8bA
         PQ5/fUmpuZf+e0FA0fyN3ELbSvQf4tFlLBfYNiucaC0V9ZJLQZpprMIyxw7GshPhrUm4
         O+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699582165; x=1700186965;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4tSwyKxPn6bljYRHS+2PTvOJ3Wz8YIquDPa/HZ56nOg=;
        b=Cj6eITKYMfXPgQK/LQNJmx1uEvXH8KxCA+uMINhdhIcw1/lTXp9wLhZsaQUlrInZHX
         2FLUoNN+aOWnLR+fMdqOPh/UX/BhygDAMsbIdW7NE00wTgCNbptzLS5dUr4Gi568pc7P
         Eg1hIu4U1yYddKePC2CNO64d3dvtNAdMq6mWft64lpYncQVRqgIGSlT/l+UEXzD9d/Z9
         9JhRyAvHGB6RnW4WKQvPJPnSKv9p8VSv7XTEWIA3YV/BywG1GyxiNKR63nioSHbnGicp
         ra7Vwgz916AwtpCglt4xdx37aknbqfBOdUIt1ryHnSsuMhbmPaxFNFG4JJSdrfjr6rE7
         2cqQ==
X-Gm-Message-State: AOJu0Yw8Blx+0vM0KRuQJagiGk3vGp2M6FHmWNalbBKd6DIAEoQZf5JP
	owIdt9gECPgn8Hm3BjwuqeGnw75LIyXNEusWxlhruA==
X-Google-Smtp-Source: AGHT+IFFiRjJn18Lbtn0PWf6/t+dMzTs08PRg0Yw7FXv9P5EzZGSVaaOCGI6TaSrSgebfSJsG2otq0cL9iM/l6GwN5c=
X-Received: by 2002:a05:6870:ad93:b0:1ef:b8c2:5541 with SMTP id
 ut19-20020a056870ad9300b001efb8c25541mr7366568oab.47.1699582165298; Thu, 09
 Nov 2023 18:09:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Joanna Wang <jojwang@google.com>
Date: Thu, 9 Nov 2023 21:09:14 -0500
Message-ID: <CAMmZTi99+HO8zbxrmx2CVoC5ZdUU_qBwZaDB7S5urOjhhs4omg@mail.gmail.com>
Subject: Re: [PATCH 1/1] attr: enable attr pathspec magic for git-add and git-stash
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Joanna Wang <jojwang@google.com>
Content-Type: text/plain; charset="UTF-8"

whoops no comments. thank you for the review and making the fixes!
