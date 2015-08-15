From: Duy Nguyen <pclouds@gmail.com>
Subject: Re:
Date: Sat, 15 Aug 2015 16:19:28 +0700
Message-ID: <CACsJy8Be-kY49CxAJTx2R2XG-c_WeuU=yLFT8-XSoaDkTScPGg@mail.gmail.com>
References: <349031438778845@web22j.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Ivan Chernyavsky <camposer@yandex.ru>
X-From: git-owner@vger.kernel.org Sat Aug 15 11:20:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQXdM-0003V5-C9
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 11:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbbHOJUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2015 05:20:03 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:36023 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485AbbHOJT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2015 05:19:58 -0400
Received: by iodv127 with SMTP id v127so91234194iod.3
        for <git@vger.kernel.org>; Sat, 15 Aug 2015 02:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zppmhYDzydQO3beoMy6hsVmomF7Sm1eEMdlKpssb9oI=;
        b=sy3UOD1a60v1D+Ji1PikmEo+WgbT3xC0gmqxQCYlBcz6zTVDyRLAqe6LnG1xihHGBg
         Fdo79F81RoK9/yZBcu21Rtt4QFgo3ySWL47c4io4aN9Ds+BIXLePaNYuYanHy1HKdv0K
         Ui/aT27lzlB29txQOPOzuvGAY4b+CiI+7N0ODoso/nZYj1qIpdOfLsCdalgY/svGeUTX
         vkPEAF+gcFkKSQl+pVw6XOps2+QCxU7h7eOLtRmWO253SHSfvYdTdwvOUJCPZrvsjeUL
         Oy1cd6Crz89/FOA36TLI2sajQ991+7AelMWgT1UgsIgHaMG8q20uEt4k2xc3zas4wrWU
         Mnug==
X-Received: by 10.107.4.1 with SMTP id 1mr46650962ioe.10.1439630397788; Sat,
 15 Aug 2015 02:19:57 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Sat, 15 Aug 2015 02:19:28 -0700 (PDT)
In-Reply-To: <349031438778845@web22j.yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275988>

On Wed, Aug 5, 2015 at 7:47 PM, Ivan Chernyavsky <camposer@yandex.ru> wrote:
> Dear community,
>
> For some time I'm wondering why there's no "--grep" option to the "git branch" command, which would request to print only branches having specified string/regexp in their history.

Probably because nobody is interested and steps up to do it. The lack
of response to you mail is a sign. Maybe you can try make a patch? I
imagine it would not be so different from current --contains code, but
this time we need to look into commits, not just commit id.

> So for example:
>
>     $ git branch -r --grep=BUG12345
>
> should be roughly equivalent to following expression I'm using now for the same task:
>
>     $ for r in `git rev-list --grep=BUG12345 --remotes=origin`; do git branch -r --list --contains=$r 'origin/*'; done | sort -u
>
> Am I missing something, is there some smarter/simpler way to do this?
>
> Thanks a lot in advance!
>
> --
>   Ivan
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Duy
