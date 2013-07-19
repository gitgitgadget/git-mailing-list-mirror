From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC] checkout --rebase
Date: Fri, 19 Jul 2013 16:40:41 +0530
Message-ID: <CALkWK0nM4fkCPNJo_c3Rpwh1azsGRdGvM3S80vcuRiRXDT0vOQ@mail.gmail.com>
References: <CALkWK0m-ZpVvvgAB_yzooah0=veeNDudahs=4ur2YHN03h-h4g@mail.gmail.com>
 <CA+xP2SbHD+MU4K0JBbZdA6bWQFQerBi5mWA+7G9=tBksjp+LXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Sebastian Staudt <koraktor@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 13:11:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V08as-00005L-Eh
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 13:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491Ab3GSLLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 07:11:22 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:39415 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955Ab3GSLLW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 07:11:22 -0400
Received: by mail-ie0-f172.google.com with SMTP id 17so931384iea.31
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 04:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=v3Jg4xdz3neH8huyybw9z9eiC7gC7yfiJrOqIhOZQGQ=;
        b=loMXwxFxMJnrJggy5sry4WsXWNwVTQPS3WNqEx043O9Wzrzluudg5llV445TlhFbvZ
         uHhmah4k3ip/ki1aFa940elaheujlgY6RDyoqkMREp+mV2XfrHrrufbITRap+Jpbgb/D
         VUOY9ONMRBSbE2Y6wAHaBYB2Qyy6uZhBnqIunWxl9C3IKo1AFZ3q5dJPuZCpx5gk3p/p
         9GNZOUUEaGv/ySLMmLzLQy9p8FwAKL6C9sr3zKcbZH4JA651zllC6MhyCnQtR9HuV1V0
         g4+Zj4xd9QMsa31IpSBn9o2hrd2BO92kxAU1r74yoU3xaaFTBPlhMhmtRQYrhI7ZSVMx
         fIJQ==
X-Received: by 10.43.15.68 with SMTP id pt4mr9711838icb.35.1374232281622; Fri,
 19 Jul 2013 04:11:21 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Fri, 19 Jul 2013 04:10:41 -0700 (PDT)
In-Reply-To: <CA+xP2SbHD+MU4K0JBbZdA6bWQFQerBi5mWA+7G9=tBksjp+LXw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230791>

Sebastian Staudt wrote:
> Isn't this what you want?
>
>  $ git rebase master um-build

Ha, yes.  Sorry about the stupidity.
