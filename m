From: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
Subject: Re: [PATCH] commit: add commit.signoff config option
Date: Thu, 25 Jun 2015 11:57:13 -0300
Message-ID: <CADstYCZ6cXrA-3a-NX1GANQ+tjL69D-V37Y0FGbs9dpF4Oa7rg@mail.gmail.com>
References: <1435217454-5718-1-git-send-email-cmarcelo@gmail.com>
	<20150625082059.GA9937@alex-host>
	<1228200928.789773.1435221179871.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 25 16:57:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z88ac-0002Wq-M7
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 16:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbbFYO5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 10:57:14 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:33955 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbbFYO5N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 10:57:13 -0400
Received: by yhnv31 with SMTP id v31so30859946yhn.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 07:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zFZdMMdl2v0ZQ7yPU83SB1UQA97+gGDax8fYHN6N9dY=;
        b=rrxGzbYl7cntAcOJ3VHRC2gCXg485IXGki3QyRyZyE8smrSHiFYHYz6DCeaEd5Rj2g
         2J6JCHfmTcZldYepamh+LSqJZRY4MxzeZSRGNzQGEaA1bmJvBr5ZvPamFAYucqp+cAEJ
         C1MAqQFe/Sd2FVxI4erPyjW0H1l1OY+3Q3falY+8JYUkbUCITzBGc+jQoBIbQJNAMJoU
         IkE+wDFqYXROPcjD1vxjK5DwdPU4OoPEyqeKKezymi6SwEaElL5y1hb5Y+dwapcscsih
         HEpDmjl31dR7j9v3w1hoq1NzRUjasjt5h8ChJS/stEsIsaEy1FR6bUwOxFQDwlLAX8VW
         Wusw==
X-Received: by 10.170.93.11 with SMTP id k11mr56419191yka.79.1435244233171;
 Thu, 25 Jun 2015 07:57:13 -0700 (PDT)
Received: by 10.13.213.142 with HTTP; Thu, 25 Jun 2015 07:57:13 -0700 (PDT)
In-Reply-To: <1228200928.789773.1435221179871.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272681>

> In both tests, you should probably use 'test_config' instead of 'git
> config [...] git config --unset', it takes care of it for you (also
> should prevent the case where the config is not unset when your test
> fails in the middle).

Posted a v2 with this improvement and the bash completion.
Thanks for the review.


-- 
Caio Marcelo de Oliveira Filho
