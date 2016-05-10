From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: What's cooking in git.git (May 2016, #02; Fri, 6)
Date: Tue, 10 May 2016 08:27:28 +0200
Message-ID: <B50A244E-05FE-48FF-9C9B-ED7AE35C5C7C@gmail.com>
References: <xmqqeg9e24ay.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 08:27:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b018p-000150-Fz
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 08:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbcEJG1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 02:27:31 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36831 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbcEJG1b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 02:27:31 -0400
Received: by mail-wm0-f52.google.com with SMTP id n129so163893073wmn.1
        for <git@vger.kernel.org>; Mon, 09 May 2016 23:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=m5CR5wZ+rCH/bcTNwF0//UPI10LL758V67cgYnCB7e4=;
        b=uYP4uGFOvK9EyqjPmWCVneXJ2s3v6p0iFLvf0E0kOmPpasADC5Np/ep4pGvjHo6h8t
         Fcr4BSnykqekB0SCLr3hhBWrxGEcrUCa9ITQpdE09ANWvGnvg7WdZZQgxFqE1kPux2h4
         7xEhmRqrl2+yIO0ly/QoFTTqUbdqEbFsvevtPz2t7YC3mQDm/xTXQy/ivZOUqSyqiLSU
         4feRJpQw7aExZPlZn+lpHqyxjL7XSOyXiv0lgaIJik67Fac9fUOVpVFSDmugpCJ/c543
         fYh1MhLwQkEAhBLf7LlhldDS+y6A/r33cf0PwFZKYPKRevlWbEUXj1eUpoNzR4A9uHPn
         PKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=m5CR5wZ+rCH/bcTNwF0//UPI10LL758V67cgYnCB7e4=;
        b=Nfs/5Ui4mrf8ymsWDDNPVUSQkI3rCNS42aN1kwPl0ZE9d+/ri93dn1wnTHVZqatcHn
         Bx5UiEOTBpxbyDMKjgm4cEL2M1na9wmOHV+lxg0LOEnhf0s8fsLoOw6mUCnIppfaN7l5
         X5kw1M7OzqFFr1m5qhkz5wdBupn2/P9uoQfhe57cICSNgsIn1xgHU/R6fNO4hTKGbVcm
         Fpmlbkzve0OYHZBPUKQa9zrN1xxYtkRIcL2qSWtEYfZEj6/9mAX9EBCM6qgEdES+qI44
         StlAPfRnTfmwSw8JivvsscaFKKv6nOKIXBqHVWicLFbyJBelX7Q2j7vcf5Q5wfFsXSAk
         IHJw==
X-Gm-Message-State: AOPr4FWoRxAlAdA5QGkeYOWcX7ph3Mq2pyt+I67pcXRXccAAaMr95cwWFkp9kbn/U6Cd4Q==
X-Received: by 10.28.169.11 with SMTP id s11mr15676317wme.62.1462861649397;
        Mon, 09 May 2016 23:27:29 -0700 (PDT)
Received: from [10.32.249.146] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id xt9sm661509wjb.17.2016.05.09.23.27.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 May 2016 23:27:28 -0700 (PDT)
In-Reply-To: <xmqqeg9e24ay.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294099>


> On 07 May 2016, at 00:46, Junio C Hamano <gitster@pobox.com> wrote:
> 
> [...]
> 
> 
> * jc/doc-lint (2016-05-04) 2 commits
> - Documentation: fix linkgit references
> - ci: validate "gitlink:" in documentation

The first patch "Documentation: fix linkgit references" seems not
to be on the jc/doc-lint branch?

A version with at least one section error is here:
http://article.gmane.org/gmane.comp.version-control.git/293521
Should I fix and reroll this patch?

The Travis-CI documentation check build step did not make it in:
http://article.gmane.org/gmane.comp.version-control.git/293523
Is there something I can improve?

This is how it looks like:
https://travis-ci.org/larsxschneider/git/jobs/127733001

Thanks,
Lars
