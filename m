From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 09/10] remote-hg: test: be a little more quiet
Date: Tue, 14 May 2013 16:52:01 -0500
Message-ID: <CAMP44s1CYvfNw2uQrUj9DTayJc-Z9L9LLB2_4Y4KOnMBhUHxOg@mail.gmail.com>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
	<1368486720-2716-10-git-send-email-felipe.contreras@gmail.com>
	<51929e298955c_13a8f89e18228b@nysa.mail>
	<7vbo8dgryy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 14 23:52:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcN8j-0005yO-SL
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 23:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758431Ab3ENVwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 17:52:05 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:47049 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758423Ab3ENVwD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 17:52:03 -0400
Received: by mail-lb0-f178.google.com with SMTP id p10so1155729lbv.23
        for <git@vger.kernel.org>; Tue, 14 May 2013 14:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=cKGaGJ15eE09l62DkoG6kdgldLWqHy0fgTavEuoaHwY=;
        b=RCAHy5Fyp6/fiTJKrz7WMwgXnVL4BdH2k1x6NOfVYzInTeiKbYvntIpsVVRErimddF
         rbTUdlbClTbdeDe59Ib3jBaY4gl7jZDInoGG7SQKMf+bZsYzJtSLIPKm3YDzU6EGBO2Y
         l7rF5bUOkC+I8GlatZp7HfLjwDDU1X0Uif5T+FPMslXcQBeKJOSI4POt7dBoZyA3BHCl
         2O7/+Lkp3+sogPjJ8MBSDt2M7CtClh4sjJAxJHwecA7h5U3zTMBxOei655+y7kVv6nMJ
         cO0690iJtn4vwGHW53/6VwvKMcH1du5125fZVf42LA5wVC9R2DwlpyQ4TpyhUV8xgkPS
         aZIw==
X-Received: by 10.112.172.40 with SMTP id az8mr5369130lbc.88.1368568321752;
 Tue, 14 May 2013 14:52:01 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 14 May 2013 14:52:01 -0700 (PDT)
In-Reply-To: <7vbo8dgryy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224352>

On Tue, May 14, 2013 at 4:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> No-brainer; improve one test.
>
> In general, unless we are taking the output from commands to a file
> and grepping in it, we prefer not to have --quiet (unless you are
> testing the --quiet feature of the command, of course).  Running the
> tests without "-v" option will not show them and when running with
> "-v" to debug the tests, the extra output will help to figure out
> which step failed.

Yeah, but I spent a long time looking at the output of these tests and
grew tired of all the irrelevant noise. In fact, I'm even tempted to
set push.default because of that annoying message all over them. Maybe
the --quiet for the push shouldn't be there, but the --quiet for
checkout definitely. Either way, I don't see much value in changing
this patch at this point.

-- 
Felipe Contreras
