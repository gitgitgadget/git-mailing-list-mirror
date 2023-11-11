Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691C7184F
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 00:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtAhSAF6"
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448B44680
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 16:17:46 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c834c52b5aso12150481fa.1
        for <git@vger.kernel.org>; Fri, 10 Nov 2023 16:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699661864; x=1700266664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHCYZbLBZ6WFBMiYw157LdhVISHDwcEDBliV327DK8M=;
        b=EtAhSAF6swDp3a3y7P/1HRoE+xx7bkXPXIoQLDrYx8LGi8G208YFEl1bqbq9F4vKKt
         fbTjtBdpJcQU6Jp9XGLg+GsIoO9l781ZWwYjeF8+uMA/6tpy0zWiYddPzsdY6m5FYWMZ
         cGSglpGnlcmbOswuKZgoOoF34arK6wq+FO2n/Oc/uUwSmewwOA2r21z7ggxoZoBUkRXC
         allJWwH1jGjmKg/pvOtK8Q5t5Vu9MXmtsZ5K3esMjtCuQgUBP55kpKpY7KK90bUHL/fw
         acDfete2N7qGZxdWNieeVUuLGdIA9dzU424OuZMq0mDNR1aCjAc7Xx1wN31RnJDCpdIP
         ePsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699661864; x=1700266664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHCYZbLBZ6WFBMiYw157LdhVISHDwcEDBliV327DK8M=;
        b=Sac1zstnZ0IRfEESlaj0GUs8Ir0Rxkv2yojy55fsTz9AhlgGWsSy+xuL0OzyMW8vBL
         ribTNuipi2gV/mgH8zY7HW7IMSeHdOO2sHZ1ThVvFXckWXm2P0S0okcvjPKjKep1H4X6
         YUvkDqwKwaaNKkZjDhf9Gtjjp82MUHxXYyJSAWAKmT5U3Pk1hs2jPQIOzMDPXoIOmWx6
         aGPrhqb4rPDtDquL0jl9NF2eZJAYIglR3U/oBlgtGRQCwibEnQt9JsfJPq3K/Tm8/G9Q
         XZISWFWSSZay4UfCmnFzfNXNgeM6nLF0TZi8yrEL+o0/0gQokR/wUL/PZDHFOUPor0hw
         0Cyg==
X-Gm-Message-State: AOJu0YzfAcyYPAE/L76vH7jdVHAIyLmKzy/cmYK8gtO5AqqBYBAu5TA8
	RB+NS6lNL3BS2lfp40nljOlT+6dNkvXmtGMPpbzEvpOG79A=
X-Google-Smtp-Source: AGHT+IFtHM8G67DqfWvA3DRhZfPf4gHD1v9LcrGqptjI9xfqdG2qfqKOhmDYg+2a1G+CNiHgzMmVWrIwvW4Wx4HBmVo=
X-Received: by 2002:a2e:a309:0:b0:2bf:f6f6:9fd9 with SMTP id
 l9-20020a2ea309000000b002bff6f69fd9mr584447lje.0.1699661864208; Fri, 10 Nov
 2023 16:17:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697736516.git.me@ttaylorr.com> <cover.1698101088.git.me@ttaylorr.com>
 <d8cf8e4395375f88fe4e1ade2b79a3be6ce5fb12.1698101088.git.me@ttaylorr.com>
 <ZTjKjkRMkmCuxDU1@tanuki> <ZTk3zoncT6nvV3aQ@nand.local> <CAPig+cTjQe6FWo98LxvDS=s3dOs33SUUJa=x-bkyWHNBMx+XFw@mail.gmail.com>
In-Reply-To: <CAPig+cTjQe6FWo98LxvDS=s3dOs33SUUJa=x-bkyWHNBMx+XFw@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 10 Nov 2023 16:17:32 -0800
Message-ID: <CABPp-BH8+VopU45GOC6+BS3fLWbhZM0sKB2K7G_koobZwY_8rw@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] bulk-checkin: introduce `index_blob_bulk_checkin_incore()`
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 10:22=E2=80=AFAM Eric Sunshine <sunshine@sunshineco=
.com> wrote:
>
> On Wed, Oct 25, 2023 at 11:44=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wr=
ote:
> > On Wed, Oct 25, 2023 at 09:58:06AM +0200, Patrick Steinhardt wrote:
> > > On Mon, Oct 23, 2023 at 06:45:01PM -0400, Taylor Blau wrote:
> > > > In order to support streaming from a location in memory, we must
> > > > implement a new kind of bulk_checkin_source that does just that. Th=
ese
> > > > implementation in spread out across:
> > >
>
> Perhaps:
>
>     s/implementation in/implementations are/

Was just about to comment with the same suggestion; I had a hard time
parsing the commit message as well because of this.
