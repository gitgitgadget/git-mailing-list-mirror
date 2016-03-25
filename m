From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 3/3] commit: add a commit.verbose config variable
Date: Thu, 24 Mar 2016 20:05:55 -0400
Message-ID: <CAPig+cQ3TnKV1GcViq9Qwtq8bkp19jqvQRzBT_v5-MSfSfXgZA@mail.gmail.com>
References: <01020153a7ba4e07-f326395b-63df-4f8a-b378-8f387b02d0bd-000000@eu-west-1.amazonses.com>
	<01020153a7ba4ec2-1fb668c3-9dc6-4137-8d92-c6a5825a156c-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 01:06:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajFGL-0006QQ-Jy
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 01:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbcCYAF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 20:05:58 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:32985 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbcCYAF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 20:05:56 -0400
Received: by mail-vk0-f65.google.com with SMTP id a62so6139574vkh.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 17:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=pQRBk3LZa8fw/ZeG3/ncCq4Jp1pv7T5USaOZlzOaAwM=;
        b=gc5/Reshohu5zQQHbFPdarCx9I/UC9p1TMn/XCDr1WQwxC/gfVic/mwod1Cuze7RVJ
         9YnrsNquOk9bB3CAGt7v2qIhYS5IQwlacIDui+RoApV+ptuuDq09wupY92hRyxnyf+QM
         z5aTrtFO7VaILMra8HQz3/DLRdgbHkt4jHH7EELgcJ/FjaflTXxUtPBb8wHNnJJ5KCd2
         Yj2H6tCKxctWSh+SulgM5v2C64rvDJvNZqjKdDnCRKbU87KFHCdvLNkXk9E9tD2UWpDV
         xxp2wCD709t957Ydlm28ZnQdlpHTTxxT39ZeO3kc0rJ693bmXpwcMaIsg0h3JNCYpU78
         ILUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=pQRBk3LZa8fw/ZeG3/ncCq4Jp1pv7T5USaOZlzOaAwM=;
        b=YlhUNKKiOf6USTKY3q3R4XWF0RvAbtM8I1u69SEm3dELWGH7n5klwr86yYohHUt4O+
         KaRH76JeXQi8WhflyATrhckprQ520PfsbtPf/MY9Zx5aMFG+JIXHIqdlAd4mqJ8WTiHX
         qJgCVi0Jddx+DXZxbVqdCBstKsq1ZQXHCXRWQuQMbvT4oqrsFJnn+TmBU30oPmtSI6sg
         imBwd5f5HHpF4MJYgPpgXwjdLQfeHvuAXuxBsCo05RQ7QUXaP6KlyFE8GlFCECke3cLF
         iMZZDGrsyJv/tQ8PHx/upJHs0Cy5l16OBu6NWliESPSY7YUyBk/QTpXqR3E8aqZhFMkV
         X3Xw==
X-Gm-Message-State: AD7BkJIu3rm8O+/2LHEgc7sNv3g+YEhfQQaGTnavANaZ3B4zZ+449T2aYJIzM6nBRL/yiGiKsfTRqNG0c5qu1Q==
X-Received: by 10.176.6.193 with SMTP id g59mr5612790uag.67.1458864355530;
 Thu, 24 Mar 2016 17:05:55 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 24 Mar 2016 17:05:55 -0700 (PDT)
In-Reply-To: <01020153a7ba4ec2-1fb668c3-9dc6-4137-8d92-c6a5825a156c-000000@eu-west-1.amazonses.com>
X-Google-Sender-Auth: aSeO8xzI0b5Y67Pesyhvhuy0jiI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289833>

On Thu, Mar 24, 2016 at 4:25 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Add commit.verbose configuration variable as a convenience for those
> who always prefer --verbose.

The implementation looks better in this version. A couple comments
below about the test script...

> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> @@ -9,6 +9,12 @@ test $(wc -l <out) = 1
>  EOF
>  chmod +x check-for-diff

Mentioned in patch 2/3 review, this patch (3/3) is where you should
update 'check-for-diff' to also check the line count, and the commit
message should explain the reason for doing so (and don't forget to
mention that it won't harm existing clients of 'check-for-diff').

> +write_script "check-for-double-diff" <<-\EOF &&
> +grep '# Changes not staged for commit' "$1" >out &&
> +test $(wc -l <out) = 2
> +EOF
> +chmod +x check-for-double-diff

Also mentioned in patch 2/3 review: drop 'chmod'; write_script() does
it for you.
