Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBC51D2B2F
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 22:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116499; cv=none; b=pa9C+N5DQMS+hcTOgNxeJQ+QcEtqbiXutnlT1NhKnwQTMTYS3pBWQRq4jCGrId+QWxnsp7kVB5bIfG/Re7i+C1uGST+QSYBVesgczMxL2EM2Udu4ilnrGeGbpJ3QEQCMha6jK/gybeckSAGFERkBCMlVa00IZiXzuCpN4vkH57Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116499; c=relaxed/simple;
	bh=UIgfAFYuE4gJqWrTCh5KesmW5LY6sAhLNzrKZWnSifk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lprrBQdrsNygFH5zo3AzRe9ytghAz6e2e9ofYnWl+VBRAn6jpk1CR3qdeQOAKqMyYvAepx0qKOgsX+az3qyuX2oGvhO6ISH8pcGggBKpQIfSVJqTybX+jRAZrVGRfGvAZUmFRnn6wGhIy+vR5lGo62Oz//qw7rZgVlFNgs3y3io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cbdd42bdf3so363466d6.1
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 15:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729116496; x=1729721296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ze9x3IXniGr9cKtOFw4tjzEreA5V4zvzKct5Zp0odc=;
        b=cBM5NgMmi33K2jr4+HFNvO8bUsXEp4vnImXzvWaUZEYwsm1DDbGxjik3yaPow78zDU
         lvxODg9YFFmakpWe3zv5FqwUnK66FNeXi/69ZwFfTcMDlraIwrxx2XGC4qkVGNe1TqTt
         dlgfpU/yXjj2kBLIAYyIeOekzcGmyS8eqyUj30kS0HBWdD1KSVp+7906xVR07MuApTUF
         pe90g19nNEAx5WFg7BOiBHnmWYazU3hDj2584LSe2Z7QxmENhloKRV+z26WfIFZDvRCz
         5R8FStbDtnQ2MJ2T0RRkFQaWUmyEGuZZc76d4vV73AKuUWVFQ2TnOFQ0eFzIn0nZV/Gt
         KA7w==
X-Forwarded-Encrypted: i=1; AJvYcCWupdpuE8X30WueUQvKE9jY+db8rsOba8vyW30CuEOkFQn0dXrSxlzzEX/VvLr9zGfRDOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeiBmZWDYX6joQmBSTAzeb6Qgoy0+HQLQ1pMByxrJByqxhkZFy
	Ji8Sj+7cmSp0cViPYDGDif6h3t/4qaBf13BnBVyoOVCaYAvmuGOrToMX78KdSfqgbngrfRp7p0G
	07SKsOumcOE6Ay6ZKwAeJPUcIJ0I=
X-Google-Smtp-Source: AGHT+IEiUaOLZsSTmiyMBnAeaGOGqHdSptkydByQHm5Hu3/i9+fOOSCj/2yy9Y+JbPLGlmvCEr1CM/yRdFDRMmBiXCo=
X-Received: by 2002:a05:6214:1bcb:b0:6c3:5dbd:449c with SMTP id
 6a1803df08f44-6cc37a2fae0mr6873126d6.1.1729116496635; Wed, 16 Oct 2024
 15:08:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com>
 <cover.1729017728.git.code@khaugsbakk.name> <ad9ee00a2a971522968f95dd413deae24839ef71.1729017728.git.code@khaugsbakk.name>
 <ZxAmBsZzwBuEGN3N@nand.local>
In-Reply-To: <ZxAmBsZzwBuEGN3N@nand.local>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 16 Oct 2024 18:08:05 -0400
Message-ID: <CAPig+cSuQwu4YeZ5cs-g0oAnhCf1LMS1SSywyPc_vBExh85ahw@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzZdIGRvYzogdXBkYXRlLXJlZjogZHJvcCDigJxmbGFn4oCd?=
To: Taylor Blau <me@ttaylorr.com>
Cc: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, phillip.wood@dunelm.org.uk, gitster@pobox.com, 
	bence@ferdinandy.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 4:46=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
> On Tue, Oct 15, 2024 at 09:03:10PM +0200, kristofferhaugsbakk@fastmail.co=
m wrote:
> > -With `-d` flag, it deletes the named <ref> after verifying it
> > +With `-d`, it deletes the named <ref> after verifying it
> >  still contains <old-oid>.
>
> It looks like we may want to re-wrap this paragraph after tweaking the
> wording on the first line.

I think we typically avoid rewrapping after minor edits like this
since rewrapping introduces unnecessary noise which makes it more
difficult for reviewers to identify the important (actual) change.
