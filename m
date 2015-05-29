From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/8] Improve git-pull test coverage
Date: Fri, 29 May 2015 11:08:10 -0700
Message-ID: <xmqqk2vrcl4l.fsf@gitster.dls.corp.google.com>
References: <1432899885-25143-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 20:08:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyOhd-0003iQ-Ec
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 20:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756149AbbE2SIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 14:08:14 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37785 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882AbbE2SIM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 14:08:12 -0400
Received: by igbsb11 with SMTP id sb11so20668197igb.0
        for <git@vger.kernel.org>; Fri, 29 May 2015 11:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=I07xQkGmyaNy0nM2AKrLAKTKD6mxcsLhjqksl9dX8Xc=;
        b=AIWJJeOOd/S4hA8vajmq4IGzrI8HHWr7WWYqNF55xr0QMqLiD8sDfGvYyzIp2eX9GA
         162KJ31OBE3+hKaXP/dLi5igr7vXQaFQ8lmij6L0665YfQprfHYT0UwUKdA0Fq76luD3
         R5OugE0NxqBs9mXtIN6Kgq9fJ/gsKjI06eaoWiMEP+yapbC+8nrFhggtMC7QeHsw13yl
         y9A6aWiq+ljsNm1m+c27SmgBKO1HCpNPcuW67Hv5iqS3/+M9vaxpnysalwNxfhObI6uQ
         7dm9vOEKatkn3lZmSmGZrklogU5ODHnxjTnsFQ3U4Pm99Jve7dvlOVwSD3B8Q0Vqy6hP
         IdSA==
X-Received: by 10.42.119.83 with SMTP id a19mr16486159icr.83.1432922891939;
        Fri, 29 May 2015 11:08:11 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:89d0:c49e:8012:77d2])
        by mx.google.com with ESMTPSA id 140sm4689037ion.16.2015.05.29.11.08.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 29 May 2015 11:08:11 -0700 (PDT)
In-Reply-To: <1432899885-25143-1-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Fri, 29 May 2015 19:44:37 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270263>

Paul Tan <pyokagan@gmail.com> writes:

> This is a re-roll of [1].
>
> This patch series improves test coverage of git-pull.sh, and is part of my
> GSoC project to rewrite git-pull into a builtin. Improving test coverage
> helps to prevent regressions that could occur due to the rewrite.
>
> Thanks Junio, Johannes and Stefan for the reviews last round.
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/269236
>
> Paul Tan (8):
>   t5520: prevent field splitting in content comparisons
>   t5520: test no merge candidates cases
>   t5520: test for failure if index has unresolved entries
>   t5520: test work tree fast-forward when fetch updates head
>   t5520: test --rebase with multiple branches
>   t5520: test --rebase failure on unborn branch with index
>   t5521: test --dry-run does not make any changes
>   t5520: check reflog action in fast-forward merge
>
>  t/t5520-pull.sh         | 198 +++++++++++++++++++++++++++++++++++++++---------
>  t/t5521-pull-options.sh |  13 ++++
>  2 files changed, 175 insertions(+), 36 deletions(-)

I saw very little changes relative to the previous round, and all of
them looked sensible ones.

Thanks.
