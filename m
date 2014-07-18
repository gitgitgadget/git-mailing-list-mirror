From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH] checkout: indicate when a detached head is checked out
 for a branch
Date: Fri, 18 Jul 2014 17:13:29 +0300
Message-ID: <CAF7_NFRdDi_dgsooX8o9J12h39yGamoKUW4djZ0=arMrxBZbdg@mail.gmail.com>
References: <35dbe7e3f3e4566d775bea19d816adc44db8ed5c.1405676303.git.git@drmicha.warpmail.net>
	<CACsJy8CG17tzWWO27Pv2c+CjDyYiYATzgBSFfMBaugYgQfZQ5g@mail.gmail.com>
	<53C920D6.80104@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 16:13:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X88un-000051-UN
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 16:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934936AbaGRONd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 10:13:33 -0400
Received: from mail-vc0-f169.google.com ([209.85.220.169]:40649 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934792AbaGRONc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 10:13:32 -0400
Received: by mail-vc0-f169.google.com with SMTP id hu12so7531320vcb.0
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 07:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XfJnzbYss/Spq79O5vmETuhh2m3l6M0DLahEicjQsjY=;
        b=f3K0CkXHWqd3lmrcAvJe0IpM0WoRVt9lSbwZ4IjHsEOQpVewnd875A0oid/iGd82CE
         jdLA2kKwbRpWTl5aDtCQuYYw0NTsnZABUCpxCacYsbUW39WUcp9a0gUMucR3Wx/IRVFJ
         1Y5yiAbhXjDTunBV8z3KkRLOR+NrQfUMysyyPibmHxHMGWYW69hxmO0K/7MxUhocte0j
         0Z/ApxupsVK/EyDx+lHI7FPvaEncsatm1sO1OxKFZtKTEgJY0XQMfzO0Ng7Z9C+nNxSE
         UFVYJxqAYhobAOgXGn5pgVfythjoaWHajzo/KPQlJfWoOMSbnGDsQrKeUD31UAYOMg+n
         vlHg==
X-Received: by 10.52.244.138 with SMTP id xg10mr5299415vdc.40.1405692810003;
 Fri, 18 Jul 2014 07:13:30 -0700 (PDT)
Received: by 10.58.234.194 with HTTP; Fri, 18 Jul 2014 07:13:29 -0700 (PDT)
In-Reply-To: <53C920D6.80104@drmicha.warpmail.net>
X-Google-Sender-Auth: COBAYA-O71toD-bWu518QkEWmac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253819>

Hi.

On Fri, Jul 18, 2014 at 4:27 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Duy Nguyen venit, vidit, dixit 18.07.2014 12:58:
>> This is what this series needs, user's opinions (bad or good).

Actually, if options "-b branch" works with the "--to" (does it?), then user
probably shouldn't need to create detached checkouts (I need them
only for scripts), so this action is probably a mistake. And when user
does want to create detached checkout he can use the "--detach" option.

So I would say checkout of already checked out branch should fail, suggesting
using "-b" or "--detach" options.

-- 
Max
