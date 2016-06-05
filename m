From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Creating empty commits with --intent-to-add
Date: Sun, 5 Jun 2016 10:15:52 +0700
Message-ID: <CACsJy8A8-RgpYxYsJBaLrMia7D3DfQPr4cxASNsaLyCnmgm3ZQ@mail.gmail.com>
References: <fdf86f73-0885-7191-2932-f10feba0bdfc@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Sun Jun 05 05:16:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9OY6-0007WM-L2
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 05:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbcFEDQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jun 2016 23:16:23 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:38138 "EHLO
	mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbcFEDQW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2016 23:16:22 -0400
Received: by mail-it0-f43.google.com with SMTP id i65so12377188ith.1
        for <git@vger.kernel.org>; Sat, 04 Jun 2016 20:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zw3k/dgLhpS/GJYJhvV7TDV6GImnlgowtGoX3YBWWFA=;
        b=zNZMe9aCmKcsgeswsOhoWvKDHgmwcksW9xxp/On0vPf4mIEaTKdL98FGCuhcvwI8BP
         AIh7VNcuoIFLjXLyMnGYMZ0kNHVE/a0nrWhPxYRExbFF0NPXb6UGZvomUiUoqSUGgW22
         KnTNio535Ibq70BbiFmJkVD7SqPZZklWJ1/uBXJ9+NpKnVnmEEP5RyHJE2kWaky6dX9P
         hIJSwBcdoMg2eEe+5bR+3QOlnq76k/Z5rwaycVKMXz0qK9z9xdQhp406uwqtsQGTRmFo
         JJ6gOLYkItE1RbsrE9Q/W4qGZhhejtsxjLsqwbo+cn+Kr7cT9rPcY7brAkpivx7bGaQx
         UAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zw3k/dgLhpS/GJYJhvV7TDV6GImnlgowtGoX3YBWWFA=;
        b=GBkMbqhCt90kHhJlXWoiZINSvGtBgU67EiKIAPtHX6LQHUK53hMHucQNbMk69L8mG1
         2mhAmhjQZoWkisIjIQIYyIyh1Amcj9mmY4gwBZyBGLtDqdMcqDBQPv7mnzXRB62WRx9A
         lY3WMlj8mSs+dIzg6ahYwdL18tVJy2fJqcaDq6GxXA+iZe0Qze5rNvf9dq4Jx+VmfXo3
         nNToVxVKSYzJfihjCosulflCho2eWuY1QG+mudvoAmuz3wvH41gEpO1CVgGMTkXM1fzC
         JlbLfyHfVQsdQyHViFcapcRErH9+/y2rxcl3r5P7dioVHhaK3n7wZMoIGxespo3NuYci
         PhKw==
X-Gm-Message-State: ALyK8tKTjYMg689cE/Bjf1QLNzs78NVij7vFseHnvCPT274dYhevPA4aFXAHvp39DQz0YYouM9y5e0ZbQFIUfA==
X-Received: by 10.36.43.200 with SMTP id h191mr6304148ita.57.1465096581614;
 Sat, 04 Jun 2016 20:16:21 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Sat, 4 Jun 2016 20:15:52 -0700 (PDT)
In-Reply-To: <fdf86f73-0885-7191-2932-f10feba0bdfc@virtuell-zuhause.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296459>

On Sun, Jun 5, 2016 at 12:54 AM, Thomas Braun
<thomas.braun@virtuell-zuhause.de> wrote:
> Hi,
>
> the following procedure
>
> mkdir test
> cd test
> git init
> echo 1 >file
> git add --intent-to-add file
> git commit -m "blurb"
>
> results in a commit. I would have expected that git commit complains,
> as I have not pased the --allow-empty option.
>
> Is that intended behaviour?

It's a bug. I'll get to it very soon.
-- 
Duy
