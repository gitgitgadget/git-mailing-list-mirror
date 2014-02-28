From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 09/11] reflog-walk.c: use ALLOC_GROW() instead of
 inline code
Date: Fri, 28 Feb 2014 19:39:12 +0700
Message-ID: <CACsJy8DKXYJc2k6Zsqd0ruF_Jex=FH8rWzmhax2Co8z_oa+7zw@mail.gmail.com>
References: <530FA3E7.8020200@yandex.ru> <531056E7.3010305@yandex.ru> <53105AF2.3070301@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
X-From: git-owner@vger.kernel.org Fri Feb 28 13:39:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJMjF-0002II-IB
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 13:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbaB1Mjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 07:39:45 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:33685 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbaB1Mjo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 07:39:44 -0500
Received: by mail-qa0-f46.google.com with SMTP id i13so556759qae.19
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 04:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bLENn/+Lo/6Xnj/Hw/8y85Tfg4Rl9c5ZO8DP9lELv64=;
        b=s2DqdFonLaLjEuwpo9x4Ki6QiLvBSBF7Xlya5HrQz3/7h2FuEJBK3V5trlo/TCF2HQ
         MOEmjFDKJVpclpoQGJlHlR33MdgQn7MtVMEiONJkBuDYDhJ2blpKgUCuuOrIgtWVfRKH
         mc3gFRyssvSufQwB4+whGbSJGJ9iSoPM9fwSTAg8cM8cdxj0ftesrVX14P10ByknWNqR
         wp7VbDgonKn9adyUfjSJeW6LNgOc/yrJzrt/DFsi3jTU6ibrTlgSMIclyFy+5VRPbRZ1
         7HOQ8Klt2i6jB1DI8PYfLkoArMRuLFH3Y42FMhziavJqAJEZfbucnOhewGisAAPEmRfF
         MMMw==
X-Received: by 10.229.98.135 with SMTP id q7mr3272925qcn.12.1393591182387;
 Fri, 28 Feb 2014 04:39:42 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Fri, 28 Feb 2014 04:39:12 -0800 (PST)
In-Reply-To: <53105AF2.3070301@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242949>

On Fri, Feb 28, 2014 at 4:46 PM, Dmitry S. Dolzhenko
<dmitrys.dolzhenko@yandex.ru> wrote:
> Affected functions: read_one_reflog(), add_commit_info()

We can usually see this from @@ line so it's not really needed to
describe. Same comment for a few other patches.
-- 
Duy
