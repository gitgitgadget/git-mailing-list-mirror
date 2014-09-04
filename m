From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Interactive staging not functioning properly?
Date: Thu, 4 Sep 2014 16:56:05 -0500
Message-ID: <CAHd499BtOH1LUq7P4Zghfso4Q-L=Ns_G7vNXox557X5dxRV70w@mail.gmail.com>
References: <CAHd499CdEORortwMWE5eLiKuiYV=yd=sZ4cny8gYe+HCzK4D5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 04 23:56:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPf0l-0007lL-JR
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 23:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343AbaIDV4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 17:56:06 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:65534 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbaIDV4F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 17:56:05 -0400
Received: by mail-vc0-f176.google.com with SMTP id ik5so11235222vcb.7
        for <git@vger.kernel.org>; Thu, 04 Sep 2014 14:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=92cau53AIQdZs3KB4jflFAJ7lNIeCQ3H5NgbJU5DyeY=;
        b=fh1mubErvDwyKlz6kEuxiSvYH0X9pNGWMT2usvkv6abEuicZVJ4ALoLbf/HIZFbLtl
         L4uCQJle0dzos+D5doBCF3qoDt6qGNB0tJFtDEK8MAWNGEFfIF4Y+FEQmUVHpFpYGRr/
         3Fx06aTTVqzGQSHmidQskSPWMgpdWpMfrrYWHV6ZqqFwufV+qsmM2koSOSAGB2eajzMb
         qJklQfDOw8kqvTA4UQwC5NaSN03XurBswm0lUD8DhgvwZ4jeir0dwBVIywpjC6hqSORP
         IFxPtX9xwlr85ZECbnKpkefSCiVJlJKW/XwkHZAXsgtbpM8ZW0y1RPXotXl9N2ya8K+C
         zgcA==
X-Received: by 10.52.3.40 with SMTP id 8mr5790119vdz.24.1409867765217; Thu, 04
 Sep 2014 14:56:05 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.3.200 with HTTP; Thu, 4 Sep 2014 14:56:05 -0700 (PDT)
In-Reply-To: <CAHd499CdEORortwMWE5eLiKuiYV=yd=sZ4cny8gYe+HCzK4D5w@mail.gmail.com>
X-Google-Sender-Auth: BZH8AietHRaF9JR4HDoqkipBhCI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256489>

Sorry, I just realized that when the hunks are across file boundaries,
it won't go back to it. I think this is a bit misleading, it would be
great to see it go back to the ACTUAL previous hunk, regardless of
which file it came from.

On Thu, Sep 4, 2014 at 4:54 PM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> I run the following:
>
> $ git add -p
>
> I skip the first hunk by typing "n". At the next hunk, I try "k" and
> "K". In both cases, it shows me the same hunk I'm on again and says
> "No previous hunk".
>
> Is this intended behavior? I expect to be taken back to the previous
> hunk that I did not stage.
>
> Running Git 2.1.0 on msysgit Windows.
