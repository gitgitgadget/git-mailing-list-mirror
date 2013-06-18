From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH mz/rebase-tests] rebase topology tests: fix commit names
 on case-insensitive file systems
Date: Tue, 18 Jun 2013 08:53:10 -0700
Message-ID: <CANiSa6gWkaC62U8oxo0mRc-G-m3UJJSjq8YSuywBh-omtHO=zQ@mail.gmail.com>
References: <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
	<1370585503-11374-1-git-send-email-martinvonz@gmail.com>
	<51C00C07.6080600@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jun 18 17:53:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoyDc-00063f-Gr
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 17:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755099Ab3FRPxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 11:53:12 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:53333 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064Ab3FRPxL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 11:53:11 -0400
Received: by mail-we0-f170.google.com with SMTP id w57so3599671wes.15
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 08:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RS+MQ+7FaLX0Vr1LLRV05PyDI1cxtwGlSf7M60uGb7c=;
        b=uqyZhL6UfGtGT+RfduhTeH09vbAH1RhygyWhN0rTfnT0d34G2ABa3/Qc42e0tx+3Lh
         c/zcyQcj/gyxaBqUxZ82RbAs8Fj5ua3sV6B3CwMBU0lTOqEc+doUp6S9mVaJlM0rQvCy
         RkPzCVtu8vZBfTPA4A4ZUKiJvojRy+NknMEhj+9CUZiBB2HvU+2i+syT4jKU/T+YVs6t
         1cnL1ub/o8UrzjQIM48klawFoDogpc1rY8iIuTkfELGZiklZ7dpLoWnPLN89U92YOlmn
         eFL+TJfvM+NHE6rCjeyvmWhPCAiC5t+dstzQl1xXw5sP1RWFH5Cyyv1ouGOU0WVJL/Yf
         HDOg==
X-Received: by 10.194.78.110 with SMTP id a14mr8878186wjx.84.1371570790490;
 Tue, 18 Jun 2013 08:53:10 -0700 (PDT)
Received: by 10.180.7.99 with HTTP; Tue, 18 Jun 2013 08:53:10 -0700 (PDT)
In-Reply-To: <51C00C07.6080600@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228257>

On Tue, Jun 18, 2013 at 12:28 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>
> The recently introduced tests used uppercase letters to denote
> cherry-picks of commits having the corresponding lowercase letter names.
> The helper functions also set up tags with the names of the commits.
>
> But this constellation fails on case-insensitive file systems because
> there cannot be distinct tags with names that differ only in case.
>
> Use a less subtle convention for the names of cherry-picked commits.

Makes sense, and the patch looks good. Thanks.

>  Knowing that the tests would take their time to complete on Windows,

I'm curious just how slow it is. Are we talking minutes?
