From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2015, #05; Tue, 19)
Date: Tue, 19 May 2015 15:31:52 -0700
Message-ID: <CAPc5daW1DWOsNLsRPNG-vezHLejC968p=VHx_8Z5x+uqn1hcvw@mail.gmail.com>
References: <xmqqbnhg6y8h.fsf@gitster.dls.corp.google.com> <20150519222843.GB994@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 20 00:32:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yuq3e-000802-AW
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 00:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbbESWcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 18:32:13 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:35494 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbbESWcN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 18:32:13 -0400
Received: by obcus9 with SMTP id us9so23610351obc.2
        for <git@vger.kernel.org>; Tue, 19 May 2015 15:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=VU3oejDBZaiX6LnLf65Tw5sgZidYTN7brFES0e9x6pw=;
        b=yDh8hQACxbfL8uSgmkNqjQnS1Po/qAKy+g4ETNmo7wNktxRbIhLQ1ykhdjS4mtijcI
         2A+M1WRqyxzAz2pa6w19B43RidMawfErmjC2TU/nYc0ZHicn+NMGvWhU9HNBobsBsYhY
         v1SyCIZhWamGcVqnXQuba2rer2xGxLWO1gFY1mzvC0wAcsGyc6yu8ri3NjBwxvXcRkwm
         uzqwm7WlCMGtmNXGc7k8ElVJSV3fE6QsSKEb5eGYhAbzuC/+GIRPBMnndQV4HeK3rY8R
         x6BxHqDbefBjqqRNc8oEq3rcgMsZ6gQ8A//V5nn5vWqbhRkK5u+2avYPP3TN870PPOjY
         zZYw==
X-Received: by 10.182.230.136 with SMTP id sy8mr26293057obc.44.1432074732406;
 Tue, 19 May 2015 15:32:12 -0700 (PDT)
Received: by 10.202.197.18 with HTTP; Tue, 19 May 2015 15:31:52 -0700 (PDT)
In-Reply-To: <20150519222843.GB994@peff.net>
X-Google-Sender-Auth: wzUQj6f6k8L7bC8QM347fVnLbac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269429>

>> * jk/http-backend-deadlock (2015-05-15) 2 commits
>>  - http-backend: spool ref negotiation requests to buffer
>>  - http-backend: fix die recursion with custom handler
>>
>>  Communication between the HTTP server and http_backend process can
>>  lead to a dead-lock when relaying a large ref negotiation request.
>>  Diagnose the situation better, and mitigate it by reading such a
>>  request first into core (to a reasonable limit).
>>
>>  Will merge to 'next'.
>
> FYI, my plan was to re-roll this with a configurable max-buffer value
> (and a higher default). That can come on top if you prefer, though.

Thanks, then I'll hold.
