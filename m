From: Igor Korot <ikorot01@gmail.com>
Subject: Is it possible to give specific PR number
Date: Wed, 16 Mar 2016 11:20:27 -0400
Message-ID: <CA+FnnTzo=D+dUdpBvPumd48vH667FAOSupBLwR4WTJy7S-TDkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 16:20:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agDFS-0006Pu-AW
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 16:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935058AbcCPPU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 11:20:29 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:35239 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932331AbcCPPU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 11:20:29 -0400
Received: by mail-vk0-f43.google.com with SMTP id e6so65827063vkh.2
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 08:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=Qp/zIqK1X6JuuYE+MYUvbOWexsVjFgY1lgqyHxtqaCg=;
        b=KzAYPWY8JA9/7K+9JofI82h/eBgH0iQMtpuSe1nGjjz/5Q7pr0vOi62p3C64MWeiZf
         Z6hu4lSO7O6ULQgH3J+b7S+xHC1ZdGmoLFou+vq6/uNgSLXmq2mCFVWJmJMR0BLvOUi+
         XLsgYDJlPqsQDZ2uaZMxFdV7lVE/Fsp4c26UsuI6RxoNSk0txYY+ZswDJS1DHvLH4EGA
         ZkyEGtLcVj24jPF2sz7N5d+p1qbwEdCn470VUDkV45ILIOIOSWRLoFlbIsZErjGWgfqS
         854QuROSIOIR1yJF9HkhXihvHv1E2FZNmxcKlAetbWHqKz+7ra49XPkao5KQAWHLgLvv
         /qWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Qp/zIqK1X6JuuYE+MYUvbOWexsVjFgY1lgqyHxtqaCg=;
        b=dVbB4aWSNir09fu0Ot5vj0tZmDIh2Ho28ZwBe+TN85eOidTQT8tR6iniPg733Cw8OE
         5OhGPtJEHiKkRsQ3Zhzrsztf3SjakTbsG5vDhHE21NpJugmPegIyCqVr06I+oFffoQ2W
         Tw+LoqmUvSQtUwFOgdW/Io5VawoQcl4+MAQn3fqTORAIvPYDGKHz7bJuQohXwKdvSOxH
         7L4dTa1HDpb9vicgTiE6XWHQrMFVXO7eJ4Zezk7OiR2b1FL/nShCD4bPnem4FZJWfGh/
         4wyGVLyUo6dLBtN61vckb60l2Tj/3BPLKBAVUjJaksU1iWqFZn8We64s1iTbU0QEREwM
         U+9A==
X-Gm-Message-State: AD7BkJJSfgmQAQ2StIkbxbz7e38v8808bhJd0fDStq/b6f3+czpAVBgidXnvfDFA/drHqzBAG0unZ0P3scUQ0g==
X-Received: by 10.31.52.73 with SMTP id b70mr4633808vka.16.1458141627848; Wed,
 16 Mar 2016 08:20:27 -0700 (PDT)
Received: by 10.31.206.4 with HTTP; Wed, 16 Mar 2016 08:20:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288980>

 Hi,
Is it possible to tell Git to have a PR with a specific number?
If yes, is there an API for that?
If no, would it be possible to add?

Thank you.
