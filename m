From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: v3 [PATCH 2/2] status:introduce status.branch to enable --branch
 by default
Date: Tue, 11 Jun 2013 13:00:45 +0530
Message-ID: <CALkWK0mQ9e1nR1jBgZKB6hgV+ptEXr225MchsVoM6514-KdqPg@mail.gmail.com>
References: <51b5ede3.41a42a0a.02a1.3464SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: y@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Tue Jun 11 09:31:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmJ3C-0001aT-1M
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 09:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079Ab3FKHb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 03:31:26 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:35882 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab3FKHbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 03:31:25 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so10595459ieb.10
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 00:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dnX6fJg0HX86N3JmAJ5Vc/doOwjodb0j0SpE/xwTpV4=;
        b=Z6Aq2oFBYVDZgEM64C3kfA5AnD31Ah5T2rgee+TaGP0UcEZXy4OqvimvO3nvf+0frG
         8pRPilp3rytzo/blktQUTqM4YEkx08JcRoctaGWMcXIDRhOPqd56S20qxCSD7nUl9ikx
         Wv/4aJfmzXHW+QjkBzRQ5zTxoHwdDjgHiQ+J1O6MZn+yTbCLOwaVufe2fczkLpIK+R+y
         5DnK9Raz9lii0ZuqFvEeZiUQY3MDtw6PBXY9q6J1B4BduVZYno2iyb95zNu8upSOhrPr
         nw1OgeyYfW28grFGfIN8LXuEuK/BnV85iR6A0G8/gI2zHJcfyqhomCew3kI9tqGseZl4
         8Vow==
X-Received: by 10.43.53.211 with SMTP id vr19mr5227653icb.33.1370935885234;
 Tue, 11 Jun 2013 00:31:25 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 11 Jun 2013 00:30:45 -0700 (PDT)
In-Reply-To: <51b5ede3.41a42a0a.02a1.3464SMTPIN_ADDED_BROKEN@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227421>

<y@ensimag.imag.fr> wrote:
> [...]

Good change.

> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> index 9a07f15..958617a 100755
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh

I expected one test.  Two, at most.  This is a bit overzealous.  I
don't mind leaving it as it is, but as a note for the future: this
kind of overkill is not necessarily a good thing; it makes it hard to
add/remove tests, multiple tests fail when one tiny feature doesn't
work as expected, and the testsuite takes longer to run.
