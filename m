Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD664239F
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ajou.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b="LGZJVIym"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dafe04717baso1998294276.1
        for <git@vger.kernel.org>; Mon, 18 Dec 2023 05:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google; t=1702905137; x=1703509937; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VEKUajckjQ0su0c1TtsZUzf5m7XUVMWMfY3OelRnzNo=;
        b=LGZJVIym59fWd6upZmJbzO+0YScAFgCtuhq5yevUu44c0+k/ElGAVZfDTToB+KVubL
         9IR/KgNaNuWqledqtS41e5/kumnqE1JU2rniQjnJ/byVrJFshetFRezYLXWH7d6qJydn
         rORELqf1nSAvfMOBDlyevTejjV+Tbp5ZPRXxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702905137; x=1703509937;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VEKUajckjQ0su0c1TtsZUzf5m7XUVMWMfY3OelRnzNo=;
        b=OHRc+jrltgaZ6JBqLUxWUITFF2SnL+HNe1dSZIGqUa+ZyJS1JFPbPuklcrvhENuU8l
         TNsY6zEn5p69v7SZe3n+RIiNGwoQiVXx1ZWxf+OURGRCBD73U0cBdeBkITOG3WC97Uun
         fn1wKbFQO6m6ONqgYt+QuA1LMTpqNYrxJlCPOOeuxduyimWqOF1uq73z0iYKTYKafWh8
         540inp+cuadv5LQ31JuUglZ99TxUdm8RHfujdqCGfSPPeHXoA4u/CeQa76Oqsb8zNpbH
         a7p3NJDtPunCftJ9Go9maYC1LG/Ix2BYzCwIEq5xyvqcvDZ1ikV9sxPyiNLQOJbwrFTz
         yunA==
X-Gm-Message-State: AOJu0Yy5onefZtSRG8/HJpQPVb0ftDCVbuGf06U9Ab8PsyDzAhnEZShk
	/d7K3OCHil2r9SwJqUWwuVDpkTmaa24mgDLQ1j+WPZWr5KwhILcEQbc=
X-Google-Smtp-Source: AGHT+IGjJBmh0Ex763XUUUNbxB37tYX08isa3oXBcnjvRDeZD1ktrN9WS3Go835M1C3K7EggN8Y3sQgDGvL2VSWEXiA=
X-Received: by 2002:a25:938f:0:b0:dbd:24b1:76bb with SMTP id
 a15-20020a25938f000000b00dbd24b176bbmr669531ybm.114.1702905137042; Mon, 18
 Dec 2023 05:12:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?6rmA66+87KeA?= <cleinblue@ajou.ac.kr>
Date: Mon, 18 Dec 2023 22:12:06 +0900
Message-ID: <CAM02FXVD09wGGDUEuBU6FsE===bro9fwbkLrEWhtw2T4f2gBoA@mail.gmail.com>
Subject: Subtitles for git scm documentation video
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, I am a college student attending Ajou University in South Korea.
My major is Cyber Security, and I recently discovered this site
(https://git-scm.com/doc) while studying open-source software,
including git.
While watching the video posted here, I found that there were no
Korean subtitles.
I'd like to work on adding Korean subtitles to the four videos posted
here so that other Koreans can study more easily, is it possible?
And if it is possible, I would really appreciate it if you could let
me know how to work on it.
Have a great day. Minji
