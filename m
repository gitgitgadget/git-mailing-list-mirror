From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5] worktree: add: introduce --checkout option
Date: Wed, 30 Mar 2016 13:59:27 -0400
Message-ID: <CAPig+cR6pNwrpABHX_4TNtKUSUR8gqACm4=a6gCphjQRkL8XDQ@mail.gmail.com>
References: <01020153bcda5e6c-2bae9b68-6669-4f29-a512-136c42722001-000000@eu-west-1.amazonses.com>
	<01020153c1dae323-b918e73f-f116-4760-9747-9aa8cafb2db5-000000@eu-west-1.amazonses.com>
	<CAPig+cRimDGFDk7A2p2rKpJ2GR27_R=BJdpyPK4xeyDU1TruWQ@mail.gmail.com>
	<CABEEbiArWe+Tq2CYMw+54PkeOAnHqU+tw6iLDW2wRuGHJ964EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Zhang Lei <zhanglei002@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 19:59:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alKP0-0005Wj-4y
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 19:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbcC3R73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 13:59:29 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33693 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794AbcC3R72 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 13:59:28 -0400
Received: by mail-vk0-f67.google.com with SMTP id a62so7904134vkh.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Y7igDVBPoyk/MDhaBA9NSH84hqXXZazYoavxvUmjI/4=;
        b=Kvp+BLi+v+eiqVe+7QLi4RJbgrb9IoKYu8CdK1HKCacwuIQzl9Aw8E6b9TuQdO12r2
         Je27YkCNTkOWpzOqu/tZDoKKB+XZywrPo5KRhvUVz+cge59I01okNeTFG8joJljZ3ENa
         xU+QwraJbajFXlVYdsjxe7zhgxGBTr6sv8oABLBrOP1nswPxWKLc8qpYYlzc9jW59ccd
         UZRUov4lt30VzuKqroeRvskEY26ZI8lUhcsd9CL4XYFPA2PgNRuc7oVPKovUaXnFcQF/
         326l7hvLiomebMEbYF/cRMs4CjFiB4FrJxETjM6FVdkBTfGa7QTUrBOD0qWYBJrBPEJS
         XTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Y7igDVBPoyk/MDhaBA9NSH84hqXXZazYoavxvUmjI/4=;
        b=S0TakSGUSHMdDYSVxhv99bCVCad7JUtRcoT3vlPylPeFiYJK/btnStrF9swjWp3Fty
         bHC8Fd9UZQfIcv9hjUUx9Qk3cc4EbmJ7VENrt2ApFHka3oycaLQzH6reNASKN8Ugi3zK
         6pCnVpjfIezj3q4wLHKhMkF+WiyN3U6jzy7qmKdM1VtyUtlnM3f3n5FOqtDweL+blV36
         8cF/GNHyIx2/U00Ip78imkmB1MU6YdtLOLRAbwjJXG/htPHypKstYyzCF65dIjYwck4j
         kZQyD4JX7X+GaMLMf6XE/OaYjspK5DbOOu6VlkPfa7Iyz6Hlbm6H+5yKe1NL2tK79Z3g
         kwMw==
X-Gm-Message-State: AD7BkJINXPQwlcDkdMgrYZbpZve4z5agVogWqtHfOrUPE0yK48hVaSw8re1YsVbvRIq0KDt3wGvRrB/VhCcS/w==
X-Received: by 10.176.1.54 with SMTP id 51mr1712614uak.123.1459360767680; Wed,
 30 Mar 2016 10:59:27 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Wed, 30 Mar 2016 10:59:27 -0700 (PDT)
In-Reply-To: <CABEEbiArWe+Tq2CYMw+54PkeOAnHqU+tw6iLDW2wRuGHJ964EQ@mail.gmail.com>
X-Google-Sender-Auth: dSavctvKS-69CQwmNem96zT_Yg4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290333>

[please don't top-post]

On Tue, Mar 29, 2016 at 11:11 PM, Zhang Lei <zhanglei002@gmail.com> wrote:
> Thanks for the review.
> Sorry for the patch churn, I wasn't quite familiar with working with
> mailing list.

No need to apologize. Reviewers understand what it is like being a
newcomer and provide additional review comments to help get up to
speed. Thanks for working on this enhancement.
