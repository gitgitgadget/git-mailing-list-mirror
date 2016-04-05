From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: Feature request: config option for default git commit -v
Date: Tue, 5 Apr 2016 20:17:15 +0530
Message-ID: <CAFZEwPMq3hwM91URzoJ7WQV1QcY++KqRENNtChb8z+s4YAi4vA@mail.gmail.com>
References: <5703CDE0.7010007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jacek Wielemborek <d33tah@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 16:47:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anSGH-0005u2-89
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 16:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091AbcDEOrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 10:47:17 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:32933 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbcDEOrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 10:47:16 -0400
Received: by mail-yw0-f177.google.com with SMTP id t10so19181974ywa.0
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 07:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=al6gPnR5nxj3JcfVPDOlrUl83tgNgQEz11s4Q2joqYQ=;
        b=zP4f6beaXoixyFIdDJ1qgilc3Y1FO07VWXmS4NhLEWM9i2I3mdvkzgw9kpH11rT4XN
         hf17GJ7Dz/fjIxamP04ZlMrVZZ0bJIgAU6HXmtjbXWF27ALG/VEhJxdYmXZVLf58pdwp
         YXrr8NtaTwpdi5fbnHr/BSTt500nV1de+AnjGezpAoI4PITf9GlulYCyxTr/YFagwVo+
         6iVxUvWO+nendOVpPqMbcVcWcPi06eB3FPrponWBHzxhFnfaiMx1GPrs1nt2YyhGJxxm
         mz1mlkW2YNSYgM612QzZ5Kxo8bv8tUfouj7VhUq8JiCT9uMcrxB7QQdc5AE/N3TVeDSu
         Aotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=al6gPnR5nxj3JcfVPDOlrUl83tgNgQEz11s4Q2joqYQ=;
        b=RxDQjRzJDIvdZCTc5Q41SpPwspP+n4EKN4uWsBr9qOS0zKvq/Hjx1an6Mf3oZh/WE4
         lPIkxS8qYzcPRl6ztLFuP4DD9C/n0nEXB7DUeqm4xIoiM4Dv+sTZQTFhiS8ZgmRHahkL
         733GoS8hDw2HAofMcaoIFS/KdDnkjnPemCILoSWD1nBsnz3begOkambNJHScaORMRIDq
         Z6NTAUoWtuyZ1mcMB+AC62jq+u38NkBLCplf7kjULWevqwKeH+36YxQNJ5p8BfEleam9
         k6huHaFJCmgBbWDrBU0VOPT3IyqxlSQqW3IuEc8O8fa4/ffttUwKEI9L3IuzKV+YjObj
         Ziww==
X-Gm-Message-State: AD7BkJJVffyebQErfhRDl+PPiyAQ1c8Bs4/KqKY3kCOSwEsFZ7EBCGiMaCZCbaeXFhR2OVdanBfplNClgUKJtw==
X-Received: by 10.37.87.135 with SMTP id l129mr2174254ybb.7.1459867635851;
 Tue, 05 Apr 2016 07:47:15 -0700 (PDT)
Received: by 10.13.219.81 with HTTP; Tue, 5 Apr 2016 07:47:15 -0700 (PDT)
In-Reply-To: <5703CDE0.7010007@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290784>

On Tue, Apr 5, 2016 at 8:08 PM, Jacek Wielemborek <d33tah@gmail.com> wrote:
> Hello,
>
> I'm asking for this one because there's quite a lot of interest
> (including me) in this feature and there is no convenient walkaround:
>
> https://stackoverflow.com/questions/5875275/git-commit-v-by-default
>
> Cheers,
> d33tah

This is currently under progress. I am the one who is working on it.
One of the patches is currently on the pu branch. I am still polishing
it to include some more stuff. You can track its status by reading the
git.git messages by the git maintainer. The latest revision of the
patch is at http://thread.gmane.org/gmane.comp.version-control.git/288820

Thanks,
Pranit Bauva
