Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460B0604A7
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708971151; cv=none; b=PALXJFS6Uk6cGu2Ww962XReX4z5xejYGKvXSb3SDAwGEzHEkLW+HY2jF/84m/24PTNLrye8Vr2aBdyDDLktnsOFqSrblVtaSARyZ/Ym48WtwolNe63zSYgf+bf9Y20Y+TRgG+ZwaiZ19THc72KcOV4/X3IUnYph3H7iDVhWmHRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708971151; c=relaxed/simple;
	bh=aSffjlyoXGxAovvSxNt4LgOYNdQNNhlEOZ/dyrZo3Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q1NyOFuhOfBNfn5QpUNCGydQfSKhj5W2CER+hZG1LmvgFong+RycckpCeb/K3X1rSUJW/zpk0O/GunGWvuHh4rU8h+leqZbxJIfyqbEbyz9KpkTHqz5MZ2tmLKrb8EIXpoix6MiFKd81YmlV1MeRMzwIMmFtAxYRD6E77xXdy0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6869233d472so19311706d6.2
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 10:12:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708971148; x=1709575948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSffjlyoXGxAovvSxNt4LgOYNdQNNhlEOZ/dyrZo3Ec=;
        b=N15vaW7M43G9+/0Fr6JRxoc+pa4UNgVzEeOlTw2FXV4FW5qGdYudnU0MK+Ia73AKl1
         MTymtVs2u5lTLqk9Wl+bvXFB1/N1UNY5ZH0tosCol2zQleOEOas1oWYlZU6sTbL3+Exb
         JV24jzqTiACJKCHcptOu8ksJ09MdYJWY0XxPZ9lQ/4vYHX7bRgPo8ctkt/HCOmx2RfEE
         Bc4G5+VhtGqcux9WlWaoTd2oM6rOiLDln1EWxNQpAy26MIBbIvUTwSZrNiBfdq+D51go
         Oiyv/wjr+L8mM9qYw8y1gZo+C1b3EPxQrchBcx/4gZNWhqtsNTbNtS7NUe60B3GTwDlY
         bkcA==
X-Gm-Message-State: AOJu0YwIfXTRAl0Nwud6QGPdBKhEYbiGbvYS8QqRRPCc53e7lQPyZ8O0
	wYjuhxvRvtrnW7lbdu8qfB0qH3OPsup9QJQrvrM0wbPbbaBZZ2yOPWQeN2nIGWlAn37aGueYhbx
	rT138JIIiVXgcVhc8bOvIkuW6MB53pWzpSLk=
X-Google-Smtp-Source: AGHT+IHphNbYsUsNiApRPXXbZAM7U+AAAT9fYtHAni55fLlKexKh4vu8byni9qYYN34SdoMbZmT91vxDKm5fNi9VP+I=
X-Received: by 2002:a0c:f006:0:b0:68f:f74f:508a with SMTP id
 z6-20020a0cf006000000b0068ff74f508amr6097473qvk.7.1708971148158; Mon, 26 Feb
 2024 10:12:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MW4PR10MB6324B0F27AE4025F111E2547CE5A2@MW4PR10MB6324.namprd10.prod.outlook.com>
In-Reply-To: <MW4PR10MB6324B0F27AE4025F111E2547CE5A2@MW4PR10MB6324.namprd10.prod.outlook.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 26 Feb 2024 13:12:17 -0500
Message-ID: <CAPig+cTtcJMukv=cyR0owZkDbOK2heA3WBS_Xq-PFyQfhXjYaA@mail.gmail.com>
Subject: Re: Git For Windows, not installing right
To: Chaython Meredith <chaython@live.ca>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 4:39=E2=80=AFAM Chaython Meredith <chaython@live.ca=
> wrote:
> Git for windows, is not setting environmental variables, despite being as=
ked to during installation.
> After setting up environmental variables, errors still occur.

Git-for-Windows and the Git-for-Windows installer are maintained and
produced by gitforwindows.org which has a dedicated bug tracker[*] for
Windows-specific issues. Submitting this report to the Git-for-Windows
bug tracker will likely lead to a more timely response.

[*] https://github.com/git-for-windows/git/issues
