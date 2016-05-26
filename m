From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [RFC/PATCH 1/2] log: add "log.showsignature" configuration variable
Date: Thu, 26 May 2016 21:36:34 +0530
Message-ID: <CA+DCAeS4gP=n2s_dfNAQyZz7G38End3U5xM6b-VKu82UNf9f7w@mail.gmail.com>
References: <20160526130647.27001-1-mehul.jain2029@gmail.com>
	<20160526130647.27001-2-mehul.jain2029@gmail.com>
	<156149583.51074.1464270131166.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<CA+DCAeSYr-q-0uSeDymJPHZwVZDZhh4yHH48peLOKodbxW1N7A@mail.gmail.com>
	<393273591.80027.1464277402819.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Austin English <austinenglish@gmail.com>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 26 18:06:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5xo2-00050t-88
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 18:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbcEZQGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 12:06:36 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36657 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbcEZQGf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 12:06:35 -0400
Received: by mail-qk0-f176.google.com with SMTP id x7so61071927qkd.3
        for <git@vger.kernel.org>; Thu, 26 May 2016 09:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=WKKnlIcOrjiVHGmVgde+8g8FA/8aP3rTMcAcWfZbQaU=;
        b=eI9o4iQeOe1t12WuC3Ihr0D8faqVWGrWXVERHTWZGMSdZsAPWMGTtt2/6rrHy2Mth2
         grSe/bFp9wE2c+539NraS1QR8+NfpBFk8+9YgipfXCU0U6AoMxJCYHYacJMkgxSTb28/
         NsKdOnO1aPZChoCSB8/YRAHdSmHgvbKI1kOmCaQgniBkRS3ladv9rUgEzjhnGxFkLCKg
         /YRjxEcXDT8wWc5+He/nYldrBizAPRBOhCt/ApgMimZiiLgju0QYPsO6jJ/dSAtbE5g/
         CTc0zypOWQLpro9Y8FynU+/Rxg2kEhFeAuAymWFJ76drHCHYcy9njJpFNKS/6KsLt2xH
         x/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=WKKnlIcOrjiVHGmVgde+8g8FA/8aP3rTMcAcWfZbQaU=;
        b=jFY66yngi4emzFCmqPDtMgtT+NQv2AUQr2tCb7wcvLXotiDvImaVrLlx8EAFSceddm
         9z8KOTLjyIJnUyedULSWwtA8muGYoEzcf9Q4W9OjvdnCVU+fSLjPgRVPzThYeirirHAu
         XN8uvOfB2Bu28P2wFLl5rH1P8tMc7m1S87rz2MWZnrpNhI5JzdmAscMGLHzDiEHjTPld
         nb2gRqdolXlmFLCmQ/dzOaIosNP82cYxJGF/2/m8yMZeRzFPFCCh7E7yGpV6HyyMJqvV
         oh2qqhSObUF0rh3TPZWnedT/MeE/6PUuoOrAoao6kbjYb7PzIH16wVw4HcFV8lZoho/6
         MrfA==
X-Gm-Message-State: ALyK8tKEvxBTQvran1i175sH1Dkkhfi5UQe+3OLyBZTKAl0fJGVPcveIHuWsoNwxA7/IZpx51NlyHVA9ei0aow==
X-Received: by 10.55.209.2 with SMTP id s2mr9661878qki.15.1464278795043; Thu,
 26 May 2016 09:06:35 -0700 (PDT)
Received: by 10.55.51.212 with HTTP; Thu, 26 May 2016 09:06:34 -0700 (PDT)
In-Reply-To: <393273591.80027.1464277402819.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295660>

On Thu, May 26, 2016 at 9:13 PM, Remi Galan Alfonso
<remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
> Sorry, I should have made explicit what went through my mind.
> "When log.showsignature set true" doesn't sound right to me, while
> "When log.showsignature is set to true" sounds better, however not
> being a native english speaker maybe it's just me being wrong.

I think "When log.showsignature is set to true" is better.
The one that I phrased does sound bit strange. I also
not being a native English speaker, have a history of making
grammatical mistakes. :)

Thanks,
Mehul
