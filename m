From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Parallel checkout (Was Re: 0 bot for Git)
Date: Tue, 26 Apr 2016 18:35:50 +0700
Message-ID: <CACsJy8Ab=q0mbdcXn9O7=dKHaOuhUCNk4g6BU5kZHdPM+z7yng@mail.gmail.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
 <CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
 <CACsJy8DiCw_yZNp7st-qVA7zYEHww=ae5Q=uKVzBhAfU8akR7Q@mail.gmail.com>
 <CAGZ79kZzdioQRFEmgTGOOdLQ-Ov-tWmgi1dLhHPDVzDb+Py2RQ@mail.gmail.com>
 <CAP8UFD3xWUkCFZMN1N6t36KKwcfnkLsFznAc7j7yF89PbYaqfg@mail.gmail.com> <20160415095139.GA3985@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 13:36:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av1I2-0008D7-Q8
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 13:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbcDZLgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 07:36:22 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33152 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbcDZLgV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 07:36:21 -0400
Received: by mail-lf0-f50.google.com with SMTP id y84so12613310lfc.0
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 04:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nriodug8TnBjlDoiPQjuXT+kjp66ZEIOnopPFWcMUb4=;
        b=EMOk/GK30zrOUB2SYRh8mzKCYUeQIOuL6hjDYO3ZwpZAMt3DokkHBFrEeUjKspL6ji
         F+03k/8aie6WgyUGnju7gvOsTJJvaLECa8R/cccpzgOjfeMI/JXU7tEjGLy9NywtbhpO
         xXU4jBfHbpUQRzlQw3gq12Bot7RgSqzLbnzizKemCniNWt64OtUcF2GcRlB2KPDqpcKU
         kntHvA2vwwnNCMVFjD6oUDZESXTTGd1Dur+jL7Zbx3tsWK3OHsW82BHU1EulbXGoCZVJ
         01VxWXAWnKq4qfe6+HH3me/ttHCjtF6XPz9y0X8GlCIQuFefD8rFIn1bbeE8DHz3xhyV
         w4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nriodug8TnBjlDoiPQjuXT+kjp66ZEIOnopPFWcMUb4=;
        b=OH1E3DyXJQLYfGqQLKaodXdiSWihvCTf7hHFfFqurOvYMxzrdhA9quVWhSgY4IdzIl
         zxWXAr+6f+RNo0x9gReMAf9IU+VrOMV272Ln6AsbsxyyU8BGB8yHYjdbnlTtJBDj6r4R
         7mLo16o5Hg7JDPLxvMQc1xC89+ZU2tPJA3z7WptsHxc9/2HXpMDLzeJM58BJ7NPkTqS+
         kKACfyRXF/QfhL4BsoKjVHqrITq1K8SKHB5ruIVFB4PWlhniyINrvPStuffM3Bk6BamS
         YFN3RIf2Uvs3NwFH7RFxmkIONTCLApYJ1Cuwgm//rb262gIXBj/1lF8Sd85OOCdXewoC
         1LGQ==
X-Gm-Message-State: AOPr4FXBM6kk6Rp7HrxVykymd+Jsq99vsxPstgFqB7wVGHw2TF09hNAzTYh3W6OMpeVIyu3L5VK1se31/4QLyQ==
X-Received: by 10.112.157.105 with SMTP id wl9mr1073732lbb.137.1461670579773;
 Tue, 26 Apr 2016 04:36:19 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 26 Apr 2016 04:35:50 -0700 (PDT)
In-Reply-To: <20160415095139.GA3985@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292598>

On Fri, Apr 15, 2016 at 4:51 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> Numbers are encouraging though. On linux-2.6 repo running on linux and
> ext4 filesystem, checkout_paths() would dominate "git checkout :/".
> Unmodified git takes about 31s.
>
>
> 16:26:00.114029 builtin/checkout.c:1299 performance: 31.184973659 s: checkout_paths
> 16:26:00.114225 trace.c:420             performance: 31.256412935 s: git command: 'git' 'checkout' '.'
>
> When doing write_entry() on 8 processes, it takes 22s (shortened by ~30%)

I continued to develop it into a series. This same laptop now reduces
checkout time closer to 50% on linux-2.6. However my other laptop
gives me the opposite result, parallel checkout takes longer time to
complete. I suspect that only with fast enough disks that CPU may
become temporary bottleneck. This is where parallel checkout shines
because it spreads the load out and quickly moves the bottleneck back
to I/O (after a while I/O queues should be fully populated again). On
systems with slower disks like mine, I/O is always the bottleneck and
spreading I/O over many processes just makes it worse (probably
confuse I/O scheduler more).

Since it's not doing anything for _me_, I'm dropping this. Anybody
interested can check it out and maybe try it from parallel-checkout
branch [1]. It probably can build on windows (epoll is gone). And it
probably help improve performance when smudge filter is used (because
that can potentially add more load to cpu). More notes in commit
8fe9b5c (entry.c: parallel checkout support - 2016-04-18)

[1] https://github.com/pclouds/git/commits/parallel-checkout
-- 
Duy
