From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.8.0-rc0
Date: Sat, 27 Feb 2016 12:10:08 +0100
Message-ID: <CAP8UFD0XF=tx0RAu+uH20UpGm45HPrcxSBJZEGKc4xiOro1jvA@mail.gmail.com>
References: <xmqqmvqnhwf4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 12:10:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZclO-0005UZ-P8
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 12:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756244AbcB0LKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 06:10:12 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35327 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756176AbcB0LKK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 06:10:10 -0500
Received: by mail-lb0-f178.google.com with SMTP id bc4so58696136lbc.2
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 03:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=u7LeeRZ98oE0Kkhs36rb2ZGGxlEQhQVi/hY90WoKBrU=;
        b=vEx5IKaq/k64KJSJzlHsXd3ua0aqPDmEoUdGrpDO9fQtoUIro9Flg9k3g6qNvWlRP6
         w41x+CvB9KHWQt2VKavxToz3r65vIO1bpxEQcmI6q0IB/k/OLOvQslKy77AoThpfoYoh
         Zzgte5ecjPwi3sXKox/TMiUtwDAFsGXjUK3WT1QcCUyXtBJVJWq9JPMSDFeJxvR7IzFq
         x6rE/2tEQS7/Z6+nrP20MkiKQUyRWCf/HpTFn6A5/tpBSYdSDYS1Xh2Du8AqnPfySWz3
         GM3w6445r/oG/HAEG4z9zJUSHGK3/s26MJyFNaDyxv0UMEoGdFlVj1hPxX9sFXv0t2FB
         MCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=u7LeeRZ98oE0Kkhs36rb2ZGGxlEQhQVi/hY90WoKBrU=;
        b=ZG9X3Ri5PEEgiR2AyKiNxxajT33pp7tWDTIlg18s3cS6O0dwmTIgTzSSjTlPGJvVjD
         v074ldbUzutfaI99wLzExR/HRipZ/T6gWv+g3nDEENjjPh/eIBwnj+QOlWLEDX83yzIm
         AQJ3qFgkv1LLOVTKDaxNOMlZ5Y2clxNd9W7SmW1BfLV9or5s2gP1/2ixcxkFf+tXZgP5
         /ioLjDWx0bBaCqockt8FNLzaG6/D/o04hNlrJdaua8uMnMcC+pUMwFFsYT293xwngs48
         /JylDLwCFeKpXr9ohUfsMzu6+HF0SX4m6CtfG+J/h/H4u8Z3M+ozCwJzaTIOqY0xn38j
         IsXA==
X-Gm-Message-State: AD7BkJJyR95ZwMdooKUDVAKDbIneC2bHrgQKhsbU6/52zt0mOr6uiWNRroMJ0JZG+4494goPs1cRlZ608SJi8Q==
X-Received: by 10.112.182.42 with SMTP id eb10mr2241553lbc.132.1456571408845;
 Sat, 27 Feb 2016 03:10:08 -0800 (PST)
Received: by 10.25.152.199 with HTTP; Sat, 27 Feb 2016 03:10:08 -0800 (PST)
In-Reply-To: <xmqqmvqnhwf4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287692>

On Sat, Feb 27, 2016 at 12:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Git 2.8 Release Notes (draft)
> =============================
>
> Backward compatibility note
> ---------------------------
>
> The rsync:// transport has been removed.

We may want to add something about untracked cache changes here, maybe
something like:

    The untracked cache subsystem has been updated and its primary UI
has been changed
    from "git update-index" to "git config" with some small backward
incompatibilities.

> Updates since v2.7
> ------------------
...
