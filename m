From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: push not resolving commit-ish?
Date: Thu, 23 May 2013 05:56:57 -0500
Message-ID: <CAMP44s18KCYEZaMTn_S2znocyr-WDCT5ciuzLoYaSHPQFc4XCw@mail.gmail.com>
References: <20130523105310.GA17361@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu May 23 12:57:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfTCi-0006Um-Lh
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 12:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758252Ab3EWK5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 06:57:00 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:62743 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758158Ab3EWK47 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 06:56:59 -0400
Received: by mail-la0-f53.google.com with SMTP id ea20so3022992lab.26
        for <git@vger.kernel.org>; Thu, 23 May 2013 03:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vZQwAXxmsdt7ZhrMoiD1MZZ5h29E/0Ajepemr08l02I=;
        b=UyC7yZc0ZZ/8BWgG4USWt8tegVnvirzpPzy6GfHKBzKKFbVqDNDUC6qqq+lJveZZ6N
         JIgaLIwXwWCe/YcUpA8BwxdXEmmbmGxD9Maj1Z+CFpEYryDQvbYLS/lvpbZMbi8EVITT
         L79gqjvLBFHDpfPHH1K3ak717QAFKzQrrxQ3Jq+0oGUpsHN17jJ7cdqDFjGyAz2FwKoV
         VMSSvb0xMatqnudnRyQG2jeTGvhRJkdlFwxjm4R10WPRGscWCYjpHW2pbRMIotr0tQbz
         +Vjtc0qjWxcEdutEkI9DdOA40inB1NWktxZ0Wr8F2yGC8s3bMx/YUl91daGt2DydYIHq
         SKWg==
X-Received: by 10.152.45.33 with SMTP id j1mr6162947lam.29.1369306618003; Thu,
 23 May 2013 03:56:58 -0700 (PDT)
Received: by 10.114.174.170 with HTTP; Thu, 23 May 2013 03:56:57 -0700 (PDT)
In-Reply-To: <20130523105310.GA17361@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225238>

On Thu, May 23, 2013 at 5:53 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> Looks like push can't resolve tags to commits.
> Why is that?
>
> linux$ git push -f $PWD v3.10-rc2:refs/heads/vhost-next

Perhaps v3.10-rc2^{}. Yeah, totally and completely not-user-friendly,
I already complained about it to no avail.

-- 
Felipe Contreras
