From: Chris Rorvick <chris@rorvick.com>
Subject: Re: git push tags
Date: Fri, 26 Oct 2012 08:59:58 -0500
Message-ID: <CAEUsAPZC80aSwnS0sBTt9nEu0HgyPp0BD2TWjSBb7tS7=i=VhQ@mail.gmail.com>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
	<CAM9Z-nkxCOyrtJ8vCF=00vrA_1eFr2-Fk7PXjYEx0HbVt0GPkQ@mail.gmail.com>
	<CAB9Jk9A95YrrtH8ue-CJ6Mqe9Z+3nfo=tjurLZjmecfiMFijvg@mail.gmail.com>
	<CAM9Z-nkosbe1NXYnu7x6v4seLqCnMBWg-jrdH2eJ9RetaZBTyQ@mail.gmail.com>
	<CAB9Jk9ApdbN+4Yk-6+u4Nje9+tbESSGGVj95iof1jnfG4Ga7GA@mail.gmail.com>
	<CAM9Z-n=+YeF3BaF-5UB5f2GBHYw7WDZEFDVT72RGSsDBaH4PJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 16:00:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRkSO-0000On-Iy
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 16:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933023Ab2JZOAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 10:00:01 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:64679 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932529Ab2JZOAA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 10:00:00 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so2424662lag.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=UBw2MYqOV5uTb1QbCtwLv0irvkFamqqHccK2AHZLt44=;
        b=HkwfaqwtYsWVHruwQDBhZjua+XiZI8AF0j9eyS35c3fq5D06BDL3bYsPAnrhT87mVk
         CzNkkRW/Qt5OQYxKWugRjjcn+cl7aKAwb8K8mwX9MFMH6F5CdK/IN55rLfZbbXlkZPtg
         +z476y1ZYzBFUSigI5KzPsmbqbLgwR/ffQS8YWFleQasWHedR6eU1OkFw40h6sgYquxP
         Cev7hnBoPpHjpl8uoqeW2YBDnTgj0W0UOCot3P8ky18MJTDjxeBrVTlnM43IU1UvsRsB
         rJuhoxZRBGbsqlXw1JOuqJo2Aff4a4BuBa1fvVTFg4oe6yPFeVrZku0vIhPJ9f9Kfdr9
         mS8w==
Received: by 10.112.14.107 with SMTP id o11mr8977221lbc.98.1351259998436; Fri,
 26 Oct 2012 06:59:58 -0700 (PDT)
Received: by 10.114.2.45 with HTTP; Fri, 26 Oct 2012 06:59:58 -0700 (PDT)
In-Reply-To: <CAM9Z-n=+YeF3BaF-5UB5f2GBHYw7WDZEFDVT72RGSsDBaH4PJA@mail.gmail.com>
X-Google-Sender-Auth: BZUdLESXpqATog5HmjU9w-Y18-A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208447>

On Fri, Oct 26, 2012 at 8:37 AM, Drew Northup <n1xim.email@gmail.com> wrote:
> (As for deleting the current branch, you can't really do that on a
> proper bare remote anyway as there is no such thing as a "current
> branch" in that context.)

Really?  When I clone a bare repository I see a HEAD, and Git doesn't
want me to delete it with a push from a remote repo.  So is this not a
"proper" bare repository?
