From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH v1 00/25] contrib: cleanup
Date: Fri, 9 May 2014 13:09:46 -0400
Message-ID: <CACPiFCLcXOsSG34oBefEN7CPy4AKMAZjf7EA5WmxJG5oUfmepA@mail.gmail.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <CACPiFCJnsu3qw59oK94sP1u0+KBDvne0ZpKS0LMGc_9ge+rJjA@mail.gmail.com>
 <536c36fc8e04c_741a161d31095@nysa.notmuch> <20140509152236.GC18197@sigill.intra.peff.net>
 <536cfb02d0f1a_ce316372ecce@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 19:10:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WioJK-0004SI-S6
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 19:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757230AbaEIRKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 13:10:09 -0400
Received: from mail-ve0-f170.google.com ([209.85.128.170]:39830 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757227AbaEIRKI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 13:10:08 -0400
Received: by mail-ve0-f170.google.com with SMTP id db11so5692051veb.1
        for <git@vger.kernel.org>; Fri, 09 May 2014 10:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=w4IpT3MfBWpJ6POQJ90l9uKid15UrjLLQ1XNzoHkmIs=;
        b=rglxk2lkczDhTdmxVDpQDMtP+rt7JK+3NQE15pdL6DGUsLeew2+4j5BXLAVmQuQOi8
         GXHIQgIoGbO2AAVI4vGsUcCvlow4h5TKA/aYKkkbWtiMBshmWeUB6yZQQcW9pJjo9V6g
         6UiCEXQuT7n6i+TRvfTDpY6JwZR9JtXJ2stWYpk7yc5b/LrxU8w8XzO8h2dpitDndFQy
         qy5FlcKDvpN7STmDcy8W2Fh9Y2PhyJjrh/XxH5MTWiT2J8ylBRi/zpSIHod6ZTUFXQbx
         x5GykuCfgkNieOcEjCTts3nEj+/YffpKXRryl3YBPWqu6vMefeuCG984mcvWe7Y3rbXy
         kipg==
X-Received: by 10.52.185.105 with SMTP id fb9mr7848657vdc.12.1399655407082;
 Fri, 09 May 2014 10:10:07 -0700 (PDT)
Received: by 10.220.183.138 with HTTP; Fri, 9 May 2014 10:09:46 -0700 (PDT)
In-Reply-To: <536cfb02d0f1a_ce316372ecce@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248589>

On Fri, May 9, 2014 at 11:57 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> I already explained:
>> That's right, and they are Cc'ed so they can respond.  Some tools have
>> only one commit or two, and in those I didn't even bother Cc'ing
>> anyone.
>
> contrib/persistent-https consist of a *single* commit, I didn't bother
> with those.

!?

That single commit is the "merge" into contrib. It may have had a dev
history before.

> And how do you determine the author? We don't have a MAINTAINERS like
> Linux. Is it the first commit?

git blame, aggregate lines against each name?

There was a tool for that discussed a couple years ago, can't remember
name. I used it to find tha lines to my name have shrunk in all my
years inactive :-/



m

-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
