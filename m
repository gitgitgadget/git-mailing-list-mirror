From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2015, #03; Fri, 10)
Date: Sun, 12 Jul 2015 09:38:04 -0700
Message-ID: <xmqq8ualjpqr.fsf@gitster.dls.corp.google.com>
References: <xmqqh9pbk4y5.fsf@gitster.dls.corp.google.com>
	<CAPig+cRqaHszW_zA6FQ4CCurYK-Gcd83+W-jHKWwtJTVbB0RAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 18:38:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEKGb-0006Qc-Ow
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 18:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbbGLQiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2015 12:38:08 -0400
Received: from mail-ie0-f196.google.com ([209.85.223.196]:36058 "EHLO
	mail-ie0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbbGLQiH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2015 12:38:07 -0400
Received: by iectv2 with SMTP id tv2so1072398iec.3
        for <git@vger.kernel.org>; Sun, 12 Jul 2015 09:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=fXWuOmW8/tAE6sUKqcYqq+Q5QPrV+pWcbOal6hBkcrA=;
        b=IaUkMe5a0wiw8Ea8+J/9WaTpULl0IArhRAIN8FZW+RVYCCcWr53UPqD7wnDV4cjpcE
         DIQ5X5f/1BskQkSrF2naHOkRUg0d5ZxFHs409whc2kJ/d+dwZO4L259EarqnocgxO74t
         J3yus6HAGgtBTtCEhuyTwhYVGyBGepymxdkGHd1l1McTqtNa1Ty54wwpY/mIUi4SAeZR
         ucuDHuRfJ+XI097GQi5ihir9lchKKPZV/3OwXB2ciTIrCyfQx0OuDNIhRCDx3CXVEZf5
         negqHmVZJwmzlODkmohUCuvcloAnse6agty07KbWtcpFqmWLTih8CEJqIHk4xnSXjXhk
         KgVA==
X-Received: by 10.50.18.42 with SMTP id t10mr1899876igd.0.1436719086379;
        Sun, 12 Jul 2015 09:38:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b9be:d9fd:18d2:4319])
        by smtp.gmail.com with ESMTPSA id d8sm3878594igl.19.2015.07.12.09.38.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 12 Jul 2015 09:38:05 -0700 (PDT)
In-Reply-To: <CAPig+cRqaHszW_zA6FQ4CCurYK-Gcd83+W-jHKWwtJTVbB0RAg@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 10 Jul 2015 18:58:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273896>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Did you want to drop the final patch[*1*] which retires
> --ignore-other-worktrees in favor of --force before letting this
> graduate to 'master'?

Yeah, thanks for catching it.

> By the way, v1 of the follow-on series which replaces "git checkout"
> with "git reset --hard" to populate the new worktree is ready. I
> expect to send it out shortly.

Thanks.
