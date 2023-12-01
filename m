Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzxicJ0k"
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E66FAD
	for <git@vger.kernel.org>; Fri,  1 Dec 2023 14:44:21 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a1a2615e909so154839166b.3
        for <git@vger.kernel.org>; Fri, 01 Dec 2023 14:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701470659; x=1702075459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i42EX5VDJtAGRY2WYHzmKoELbM9ACd2wk18uPOKKm6o=;
        b=MzxicJ0kE3/8gD2n9NXSRV0H8iIoH6W37KzEgIamrYrSKfrgaSfaL4NUImxb6MULeV
         iu4mET2JuWR4srYqGDeWrkUBQFkCPkEu1YH6xeRik7Mpk9oPPmfGLdybw6ohzVM2R26V
         JkxDIHdkQrqKUM+kJFNMgTIku/Fc25dI3QT9/GyJZqiMVkjYGOfioznAJwu+fPnFSQka
         q8+MT/LrsRcDCEzkKwR12V9vOYGrS4Sfz8EZwX40Y7zSsxq1xah4zQJA50ok4smwkver
         QLo+3GHidBqWnDtxcQQxe6Hvs6AQg6znGX7xvtqt2wBfN8OVXEGto9iLWzPVeAVHD/JF
         Sm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701470659; x=1702075459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i42EX5VDJtAGRY2WYHzmKoELbM9ACd2wk18uPOKKm6o=;
        b=fGNyIeV3HTGWsuipvVCvcqHMWzx0bwMIwF/UFqIrPApM4GbHGTFDrSisBlHhQdfUvM
         FdYBHmqWcQAAsdVEg/HL6cO5C4apWgitQoqG0ihpWn1MQNS1zfsr1qvP9AZ1f+atWuAn
         ULz05sBmZ3VPiOceuTEQzk7y2s+9K0tcAXEvik7dTnoF9wwtdjPPkVoSUnI1z0U35VKs
         nYRNgxN0WgFCeJT45Po4EpmYbXLiXPOWrHIkBvACfLWWzIqSLA5Ld8EorqbKPxYcDPpN
         G80mBrrM6LGWalW5OoQ+u1wsF3sHJdiKEK/FFDSe197tGRn4+6woy1EXT+rKFOM22zaL
         DpAw==
X-Gm-Message-State: AOJu0YyQhW94iJvh7J+6Gqk5iPZnAPlY7UiXj8aT9jJ4ZvEyBWEyLWDA
	gB7OmjoXL0YLIe31Mn5KyE88dU6S9K3sI19I6t9Unggp4oY=
X-Google-Smtp-Source: AGHT+IFRaTXKJwD3iTPF4B9UNVPZlv0O1Rln8/9FfWM7udv+1lto/jCLFRO6C2AKqsl/SJgnufrQfinjCa9V0uDtTzs=
X-Received: by 2002:a17:906:af79:b0:a19:a19b:420f with SMTP id
 os25-20020a170906af7900b00a19a19b420fmr919560ejb.122.1701470658939; Fri, 01
 Dec 2023 14:44:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 1 Dec 2023 23:44:06 +0100
Message-ID: <CAP8UFD0ys6gz4M0t+FPJeh_KLoG0GteoYUvB4B_XqeDXDnoCNA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 105
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Bruno Brito <bruno@git-tower.com>, Alexander Shopov <ash@kambanaria.org>, 
	Luca Milanesio <luca.milanesio@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>, 
	Philip Oakley <philipoakley@iee.email>, Jeff King <peff@peff.net>, 
	Jason Hatton <jhatton@globalfinishing.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Eric Sunshine <sunshine@sunshineco.com>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 105th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2023/11/30/edition-105/

Thanks a lot to Alexander Shopov, Luca Milanesio, Bruno Brito, and
=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/675
