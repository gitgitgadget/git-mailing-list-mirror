Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hh015N5n"
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5E88E
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 08:44:51 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3ba00fe4e94so4220040b6e.1
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 08:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702572290; x=1703177090; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+U1ig27Pu/KO/nKF7gIMLDVVF4o+6dlInPGfbZ5wbsE=;
        b=hh015N5n2XOYkX6sOSVHgjj+UhYskkpEl+REOclmRYy0mRZ+3gTaVwzXbTJzXM1WZL
         9x/OTVoSAL2I+u3/mDMkWMczgO1cP1kgUOEkq3St5FX8shdN7bNYl7n/3RxmbDXTvFxv
         6mDsqMwbP20d0WVG41AiHSi92bN5pHakCqrWgAjLSXy7OxsbS7fnOFn7LtsRSGhE2jrm
         tuN7tm2zmk7Ifjegb+tRWpDTAuDpUZgBDH+nVS4FSPjAw/jl04oQfaJyeulzcrZN0Xzu
         RQ5JgCU8k0k/zMy6nSg0PlBp5lCiA7uiRsIJs4YAxlhCWzcueyYqTUFKF5dqbdpD4Z96
         dsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572290; x=1703177090;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+U1ig27Pu/KO/nKF7gIMLDVVF4o+6dlInPGfbZ5wbsE=;
        b=Xgj7W2lpyA3m1tQbpvVlzZetlTb9O4riUcOTh6SHEU7kP2jO0tDbJ7hZj5Hl066Z9g
         HIJaJpHzohNkTb37axVwqchncrPgijXuZmUsHUy5vYy43F6BvJH6zm+7bFTAydDd8BHq
         XkaBdEbdunsQd2zPcFP+vFiEzpBHqSy3PjF7GOhxa0roBSlDkLDftzdMmCffSzLkxnTP
         Af5u1rD/038h+9gTKSvMxi5dp7mNvfMitLvufb/xkSbwcr+hq8MFBO01uBBQssXkq9Yc
         7mu8wLxcp63crUYuoTROqyhscPEwKr3VaKvtT98RRmJJu6Mjn9Jg0TXhBBX0JlhVHphj
         ZNXg==
X-Gm-Message-State: AOJu0YyWME8l90EZHQ1hmn0/OisDVVkloT8c75yi5Fw803tpupR5Qw+I
	CFPAttDoenk546b7GhShyqE8GLXj/gcwc7qtL+kmCRtfofU=
X-Google-Smtp-Source: AGHT+IEhoKHq+XJv5VX7LpwuQUf5YHjs/1v1XyMz6rN8WdCQ/cZfLMaj386JTXJhNjsjdc5KRY7jWOqtHHfiyIkpyJk=
X-Received: by 2002:a05:6808:209e:b0:3b9:e153:a610 with SMTP id
 s30-20020a056808209e00b003b9e153a610mr12577924oiw.59.1702572290307; Thu, 14
 Dec 2023 08:44:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andreas Scholz <andr3asr@gmail.com>
Date: Thu, 14 Dec 2023 17:44:41 +0100
Message-ID: <CAHDWvZyHDbjOnnCYCkfMY+HPWobrcgP6c1kkWFrRgWV4fHED=w@mail.gmail.com>
Subject: Question regarding Git updater
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

I hope you can help me with answering my question regarding the update
mechanism for Git after it has been installed.

1) Does the updater autonomously figure out if there is a newer
version than the current one that is installed?

2) Or does the updater only ask, when the user actively uses a command
to ask Git to check for a newer version?

3) In both cases, what information about the user/system is sent with
the request? Is this information stored on a server or database etc.?

BR

Andreas
