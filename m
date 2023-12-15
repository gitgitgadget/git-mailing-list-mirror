Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75D82C69A
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5f+fU+u"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4b3203cdc78so188167e0c.2
        for <git@vger.kernel.org>; Fri, 15 Dec 2023 04:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702643911; x=1703248711; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y1n4Jx0F90KkiirXugCLU/cFzlYHbCkBwu7b52Fnk20=;
        b=W5f+fU+uB6ycF0OpJEs67S3lyqBB1HSmcJEubzEO52U7pl0n58vAliEiJMZ+LCmk9D
         Ghi5If1GuKkyFTkOy4JM2QitUYtIZ6BoBKJsM1ejP44vawTWTC+HiiYXJdSU0ftEnqyv
         2JeAdF7HrsVI31xgVlCzl45gxDsO5+rKjw1KVOBf6SmFgN+NW5tTJXpf0DtWHkUxkGGL
         IHpflQjC2+UcxUUWTXyWJH/DmheL/s879ZTkrGkZlA3Y4O+YP+kann8Ly5dzqMCrxjhe
         lxIw3XbkZUXvPAj0TIZB6IIWqwiNShQgPYE+RPMNhQ19vQg/kn/w4gp/+/sJWe4KXa4a
         0+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702643911; x=1703248711;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y1n4Jx0F90KkiirXugCLU/cFzlYHbCkBwu7b52Fnk20=;
        b=gUTXouAM5/nu1ofyBgGZXuBvdHkouTzL+mEwMasIyrYbUjk5sKFim68MbH+wPTmysX
         DeDZimpup2rtBJ5BXuq1bhnCSpzuoJf8riF6tU+UGI2Vv9P6RGv30TL6btb2dbVPvaj8
         xxY+cNZGlI6YhS3irSkCf2uMRJPj/JiAwLbPetqQdHYlCTlkrMuWFDIZA2HYIv480JTC
         Xpm9vIkJC0FZngGCKdpvLRcfidO0YAaW5zPXhKU6d5CpQOrghCyMMWeY5+m+RjxF/xHR
         74gtT1K5TMpBZm0gHeW2WuVVF2brDnJYnjR27Vv8B3CTTdq1ANyfZiAHb3GN5jnJzfof
         vQcg==
X-Gm-Message-State: AOJu0YwOYOMUb0CA2q00L8f9ON8cRjtZl1bp9RzztD2h0LJXXPjapcwl
	O8h3ZKBDiT6K0yfRRuAwCOOyOUUV4qVtpSCgeZOGsTFuWhA=
X-Google-Smtp-Source: AGHT+IGGxfkErxRdl+gQ4RhcBXy8cLsX6OkNiBGmkZPFQSg64aD3ntekukGyRMxQMLeZoTJ8WizQq6Hy+GyR07Z6Vhw=
X-Received: by 2002:a1f:738e:0:b0:4b2:dbb5:bc58 with SMTP id
 o136-20020a1f738e000000b004b2dbb5bc58mr9947320vkc.29.1702643911483; Fri, 15
 Dec 2023 04:38:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Benjamin Lehmann <ben.lehmann@gmail.com>
Date: Fri, 15 Dec 2023 12:38:20 +0000
Message-ID: <CAM=w4Pn46nTcWA1e=n4Rms76gCx7iqbRmOWf3=vRmKgtbhqQmA@mail.gmail.com>
Subject: Bug | Documentation | git add -all | Synopsis has minor mistake
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey.

The mistake can be found in the synopsis here:
https://git-scm.com/docs/git-add#Documentation/git-add.txt--A

In the synopsys, the options -all currently reads:

[--[no-]all | --[no-]ignore-removal |

You can see that there is no mention of -A, which is the main way that
people would use -all perhaps, so it really ought to be included
correctly in the synopsis. In addition, the closing square-bracket is
missing.

Hope this was the right place to report this - seemed to be the only option.

Ben
