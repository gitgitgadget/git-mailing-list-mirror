From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Where to report security vulnerabilities in git?
Date: Fri, 21 Aug 2015 17:16:20 -0700
Message-ID: <CAPc5daUYCyJFr_4-u60QGZavxEM=TZSWq_6O7C4E5kuG+gPy7w@mail.gmail.com>
References: <CAO5O-EKaarYDBd-cpVvKVXTWfKm10ttqd3A6wNe2cXGriGux1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Guido Vranken <guidovranken@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 02:17:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSwUY-0007v5-66
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 02:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbbHVAQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 20:16:41 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:34867 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbbHVAQl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 20:16:41 -0400
Received: by iodt126 with SMTP id t126so98785851iod.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 17:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=8uu7i2ErZzupPQpTmX7LtJX99jhZn2/IaGipubrnozA=;
        b=grGjUalQIjkaovbPosCvRv8fbG9uU0l8Tx7lV13/oA83ivjydkCxeTyZ5bMz3NtNZ1
         DMUL50zD+PtNsPlkYc8JutAHAz21QO5gHTbd6RC4eROvnMAE7Zh1fEPqaCL3v5WPR05j
         ZMH7uxEyn2fNzlE1l0YhdSvGcF+lM3OSd5ucEF8jcjgW82414l4pA73u7rhCswazFUTZ
         WV3NoxkDbeqoRbQUsF4ee78mfAIdNTULz7yuOOJDvgIlI65oWgD5pp7ugS7aRlnlWT2Y
         UzliYNkbWiMzRvJqCAhVHsQvGxYgoNMtBXLt3TzD/9U05w1EIxoizuTot1BSO3kezoLS
         dg4w==
X-Received: by 10.107.3.19 with SMTP id 19mr9806735iod.132.1440202600318; Fri,
 21 Aug 2015 17:16:40 -0700 (PDT)
Received: by 10.36.79.69 with HTTP; Fri, 21 Aug 2015 17:16:20 -0700 (PDT)
In-Reply-To: <CAO5O-EKaarYDBd-cpVvKVXTWfKm10ttqd3A6wNe2cXGriGux1A@mail.gmail.com>
X-Google-Sender-Auth: y817s6u1Bk0050_QRbe6_YOQKa0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276345>

On Fri, Aug 21, 2015 at 3:55 PM, Guido Vranken <guidovranken@gmail.com> wrote:
> germane exploitation details. I did find an older thread in the
> archive addressing this question (
> http://thread.gmane.org/gmane.comp.version-control.git/260328/ ), but
> because I'm unsure if those e-mail addresses are still relevant, I'm
> asking again.

Indeed that was an old advice. Recent releases of "A note from the
maintainer" has this paragraph:

If you think you found a security-sensitive issue and want to disclose
it to us without announcing it to wider public, please contact us at
our security mailing list <git-security@googlegroups.com>.
