From: Joe Lencioni <joe.lencioni@gmail.com>
Subject: Config for git-blame flags -w, -M, and -C?
Date: Sat, 7 May 2016 10:03:36 -0700
Message-ID: <CAJzkHHf-B0FK=Ow=B49GjSWyHJ6+fdnSvyGphDrEdkCGy1TOAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 19:05:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1az5fE-0007Hi-Pm
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 19:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbcEGRD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2016 13:03:57 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:33711 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbcEGRD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 13:03:56 -0400
Received: by mail-yw0-f174.google.com with SMTP id t10so248998058ywa.0
        for <git@vger.kernel.org>; Sat, 07 May 2016 10:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=keq8QJTwNQqDfT5RJTomM/VU6tLlagHcKzk6s+uv/c0=;
        b=JO5nKEkKYPfAk2mf/C8/TYmgSeUSTYTvLkTcv0yCAykQOGYMMXRq0rQO9y5pRTJrj/
         xTFzGvmF/kX/8j/QRvmVFOQoJjlZXNBSvavqYAgImvfBpMHV1VQOd27PLJkKMq84U75d
         0/8YZqYb4ZV9HTMQakG2vTvt1GR3EfBuY1B6MskLySUexlBy6f+RUo10qHpNedNuf3kv
         5MJBom+C64ayAYTnyA+AZ/RO5Y7IsiKSr9wqBzbbZ+/Sxyrautba3NQ0hOrDk0dD4ZE9
         Gkv0kcvIx0ogohZqg9/muUGzBoLLnwQ/KuiNkUQKURGhw839NqDzQGX7XRWQ5NNhTeQi
         oupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=keq8QJTwNQqDfT5RJTomM/VU6tLlagHcKzk6s+uv/c0=;
        b=kipKhvh/79UUBfbNbK4rzHKr9r42rZYpvWqycLZWGXXI/hTpDMhEN19EPm5eEHzlbf
         fYiqrmmoDNLX8kchrUtrP0L1bB6sSyY2hoWHnBpJZowbrx8Jz5jUN7CXyYLarhPhJIps
         D5Nv1z3bKD598hZtzBuHp1Edu7akcwS3bkWqUhZR34d9YmWQHmrJIMHwfhg3LOgl5TDG
         azIZDpPuEA5l6sNRf19k9EZTXrlgbu+a4ZEsTzdQ+QTxztYL2PCTWh9gO+bBBtqUlOVj
         /lY419Gkw57FXCQQNcyC/Jq0BAYJyYj4v5fbPWO4RByjcM/DoBJWwIp7sTFfHuVJeTEk
         Bdxw==
X-Gm-Message-State: AOPr4FWvbUVy0/8nYeUwTI/Ge8yLyyK/IIjruPyBUX6/dUQjO1wxZDK3o6BPn5ENVQ31ZBuSm8MxgthvVm5K5w==
X-Received: by 10.13.224.5 with SMTP id j5mr15654939ywe.195.1462640635587;
 Sat, 07 May 2016 10:03:55 -0700 (PDT)
Received: by 10.129.162.144 with HTTP; Sat, 7 May 2016 10:03:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293903>

git-blame has a few options are useful when working with commits that
only modify whitespace (-w), move code within the file (-M), or move
code between files (-C). It would be nice if there was a way to
configure git so these options could be enabled by default when
running `git blame`.

I suppose this would also require the addition of the inverse options,
or perhaps arguments for the options, to disable them if needed.

Thoughts?

/Joe
