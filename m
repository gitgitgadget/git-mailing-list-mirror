From: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
Subject: Re: [PATCH v2] commit: add commit.signoff config option
Date: Thu, 25 Jun 2015 12:19:22 -0300
Message-ID: <CADstYCamTxaLnZeYUma6t=KP3Fx2rQH3svqgCYP4WpAR9k_USg@mail.gmail.com>
References: <1435243807-32112-1-git-send-email-cmarcelo@gmail.com>
	<xmqqlhf725xy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 17:19:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z88w3-0004nK-EH
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 17:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbbFYPTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 11:19:23 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:33123 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbbFYPTX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 11:19:23 -0400
Received: by ykdt186 with SMTP id t186so42206754ykd.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 08:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Sj+JYYfeUEMmvH+B7heZYFaTQMCykT/T1EdVpycamGY=;
        b=grNRf08SIq09GZ7Q5MF2pbL3FmL9VpJ2hwMU6mWVR9KPbl3uIY96ikgLLsYW6g1mHa
         SsiaVj4H1YCQ5uAO1QZyXw0ds4/3vsTfW0sPwdDePrLxoBZaMuJgnCkmUhKY6u9ELN1m
         ElVEI5EuqwUMtOQGhzH/LsPzZiPldGCRKj81zPnq1hwSJl9MJ+d2uva87Q3L1I6CVKKY
         4GJgTEQ+9rFAOBAz1Z33///W49sesiW/i0iJPVhLCssv7QPdhxf0tqOqcSGSIhReIhXP
         Ozf2H7boXaHEmQ71pg6M1rIBVjCrQgD4UWd11csbD5sgim0zk/0bGKsB0MVk3qKPkkPs
         Cs3Q==
X-Received: by 10.170.125.138 with SMTP id r132mr6394810ykb.19.1435245562585;
 Thu, 25 Jun 2015 08:19:22 -0700 (PDT)
Received: by 10.13.213.142 with HTTP; Thu, 25 Jun 2015 08:19:22 -0700 (PDT)
In-Reply-To: <xmqqlhf725xy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272686>

Hi,

> Hmm, I do not recall seeing v1 but that is OK.

http://thread.gmane.org/gmane.comp.version-control.git/272635
http://thread.gmane.org/gmane.comp.version-control.git/272636


> The following immediately comes to mind.
>
> http://thread.gmane.org/gmane.comp.version-control.git/51754/focus=51780

Thanks for the reference, amazed that I ended up using the same title!
From the thread:

> Even though these lines are not digitally signed,
> the intent of adding a Signed-off-by: line with your name is
> that you are certifying its origin, according to the definition
> of DCO (see Documentation/SubmittingPatches).  This should be a
> conscious act from the signer's part, and making it automatic
> with a config variable that you set once and forget makes it
> much less meaningful.

This is a fair point. However I've seen that in practice, in some
cases it's easier
to consider the DCO as the rules for contributing to the entire
project. In those
cases people tend to use commit templates or aliases or hooks, which in practice
automate the signing off act anyway.

A similar concern probably applies to format.signOff option. Would be sufficient
to add a note about conscious act (like format.signOff has) to the
config description?


-- 
Caio Marcelo de Oliveira Filho
