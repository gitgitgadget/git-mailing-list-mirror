Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVTqqDP2"
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E08A9B
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 10:46:12 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77ba6d5123fso101919985a.0
        for <git@vger.kernel.org>; Wed, 15 Nov 2023 10:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700073971; x=1700678771; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cGE0Am7AOXF2E7jPWfkBILo/pqdj3lIdA5CFBlfs1gY=;
        b=DVTqqDP2b1GVHJQWnxUb1+L/1RnGJsYaRNRxn7FUeN5gepajB02Ar9pSGxYboA9uBD
         vvGUcOz7kozAj9bogXQM3n6Wy8AnwzVIkXAob0YM5owoEcOEFrzuYO1RKsgSl8Y6iSw+
         4fMcpBQhQ2VUIKV0sMhhuIeGphUm9THsHKu/E7HlXmTJg38MFU4P3mEzC5WZTxY5dihj
         xAP+/VDFGXGMomgvALhQT2c4k1nL34AzDR3zFqsBkl4SQc0UGEUEML3uF8eAvaK3/aRy
         5hmn6dYULBqui0S1GJ/l6ier6uzo0C4BQ4819gNfN+gn5WWQlLB6dlBDTt/GnIbf/sVl
         RURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700073971; x=1700678771;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGE0Am7AOXF2E7jPWfkBILo/pqdj3lIdA5CFBlfs1gY=;
        b=BsftxrntwzW946PcRe/OrqQPslIN8yGLe5nFlDXImBp1zigmfR4NjsDJL8VlHSlO6i
         psTcVxV4XOaIe6I1c8VEEQYWEH7JY5HK7HENCOaIS4DGmaVEq3bGk6nKpy9/OTMEbkCG
         hQgACGC7OcHMF4hHIOMFCzegxLSxXDXqx98BF1yXUAET6lxinBSGT6SwpllOX2UA+/f8
         kRpsONNyuAiMLnwFX4KV0HX2L2KkXTw9FcWFFbN92bbl6mrLMVokzHxFnP8r0sb1Paqs
         4f07LqF4UvUzJvkt+ZPs2PQfd40FLrC5yLpzeVXrYCHgYvaaMCEMdURuz4SxDyaveNis
         ILeQ==
X-Gm-Message-State: AOJu0YxxLcOKRCtjUoOwavRdzYpjwudnvLMHGiv+RLfK3tj+0f12m6fX
	cl76ixdpWy1HygnAnZH0q0CdCDixU70=
X-Google-Smtp-Source: AGHT+IHWZFjswpgAyZUT/zXwKyVNgJk824aZuc3ljDLnMPwOwY7wffGBJMF3uaDgkfsDTwTxHg2PkA==
X-Received: by 2002:a05:620a:4001:b0:779:cf70:8495 with SMTP id h1-20020a05620a400100b00779cf708495mr9140397qko.22.1700073971251;
        Wed, 15 Nov 2023 10:46:11 -0800 (PST)
Received: from ?IPv6:2601:199:880:938:680f:5a1c:baeb:d73f? ([2601:199:880:938:680f:5a1c:baeb:d73f])
        by smtp.gmail.com with ESMTPSA id o1-20020a05620a2a0100b007778503ebf4sm3650640qkp.16.2023.11.15.10.46.10
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 10:46:10 -0800 (PST)
Message-ID: <4e76dda1009a8365a1d66d9594865a4af31ab418.camel@gmail.com>
Subject: Bug: "Received" misspelled in remote message
From: Alan Dove <alan.dove@gmail.com>
To: git@vger.kernel.org
Date: Wed, 15 Nov 2023 13:46:10 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello:

Using Git 2.40.1 on a private server, I see this message whenever I
push a commit:

"remote: Recieved update on checked-out branch, queueing deployment."

"Received" is misspelled.=20

I realize this is a very minor issue, but it should also be very easy
to correct. As someone who suffers from Proofreader's Eye, this error
deals psychic damage to me on a daily basis.

Thanks.

--=20
 --Alan

Alan Dove, Ph.D.
alandove.com
917.273.0544


