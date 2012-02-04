From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] t: mailmap: add 'git blame -e' tests
Date: Sat, 4 Feb 2012 14:10:27 -0600
Message-ID: <20120204201027.GE22928@burratino>
References: <1328385024-6955-1-git-send-email-felipe.contreras@gmail.com>
 <1328385024-6955-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <marius@trolltech.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 21:11:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rtlwp-0005LI-Fk
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 21:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605Ab2BDUKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 15:10:55 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50599 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175Ab2BDUKy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 15:10:54 -0500
Received: by iacb35 with SMTP id b35so6444983iac.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 12:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=cAncebwUKUJFFND1Ih/lRP67X6vD5iMlxr/HeWk7tIc=;
        b=i6kcCYcXThzmTOJ2X7PnKjFFtAbXScu5iSoFkYn8wyqYSk3hNR1pofACS2TbXWoQlP
         MbPqkwt+T/Wrap3hdMYlrSOba7CgatJkF32Uh86Lb5hK+ctuWRCJx8Y22kF4Itz7NjTT
         +ePUxOAuMFHS1FaUCWVi2uZ6zRMqYDm8MD13Y=
Received: by 10.42.135.138 with SMTP id p10mr11238230ict.25.1328386254257;
        Sat, 04 Feb 2012 12:10:54 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id h9sm17929339ibh.11.2012.02.04.12.10.53
        (version=SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 12:10:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1328385024-6955-3-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189904>

Felipe Contreras wrote:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

Thanks for writing tests.  I think there is room for a few lines of
explanation above.

[...]
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -255,4 +255,22 @@ test_expect_success 'Blame output (complex mapping)' '
>  	test_cmp expect actual.fuzz
>  '
>  
> +# git blame
> +cat >expect <<\EOF
> +^OBJI (<author@example.com>       DATE 1) one
> +OBJID (<some@dude.xx>             DATE 2) two
> +OBJID (<other@author.xx>          DATE 3) three
> +OBJID (<other@author.xx>          DATE 4) four
> +OBJID (<santa.claus@northpole.xx> DATE 5) five
> +OBJID (<santa.claus@northpole.xx> DATE 6) six
> +OBJID (<cto@company.xx>           DATE 7) seven
> +EOF
> +test_expect_success 'Blame output (complex mapping)' '

Since I didn't receive a copy of the cover letter or patch 1, I don't
know what this is intended to test _for_.  Good --- I can more easily
convey the reaction of future readers who do not necessarily know the
context in which the patch was written (and the commit message does
not seem to say).

Looking above, I see

 - a lone comment "git blame".  What is it trying to tell me?  I guess
   you copy/pasted it, but is there any purpose to it?

 - a test asserting the claim "Blame output (complex mapping)".  This
   title is identical to the test before.  I have no idea what this is
   about.

Puzzled,
Jonathan
