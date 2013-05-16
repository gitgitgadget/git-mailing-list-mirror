From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] branch: add show-tracking option
Date: Thu, 16 May 2013 15:56:33 +0700
Message-ID: <CACsJy8D_5YE3w4WNvCA8-fA-y5DV2WqHULqcMYqd7X_SSh_aHw@mail.gmail.com>
References: <1368690532-12093-1-git-send-email-felipe.contreras@gmail.com>
 <5194921F.4080103@drmicha.warpmail.net> <CACsJy8CrGTa2XdfFkkKDQQjF8gM3011RiUE6roe9L7yZZq5J2g@mail.gmail.com>
 <51949B85.40600@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 16 10:57:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uctzq-0006Gt-QQ
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 10:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756557Ab3EPI5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 04:57:06 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:59798 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756121Ab3EPI5F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 04:57:05 -0400
Received: by mail-ob0-f177.google.com with SMTP id wn6so2836545obc.22
        for <git@vger.kernel.org>; Thu, 16 May 2013 01:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=J7HVozS74Lj1Wi66XGE1qME0ADJ8kfgr8S62In2cYuw=;
        b=teyFDr3C/e6TSEU5ybisHnzdC9EK32WX9CTyq4hTIMAuxWRjECUyZJQ0ESZPH6bkJk
         DhjUrQUX2NMLoKu1Z9gJMqUEvSbeZK07KbqKp0NZWV49STAi6rtZ1Ii/+cBn/HAFyTZK
         s7cRkh4AOnu8ycUV66bp11RJ0MtefzJAKX7yhoUJiQ3qG9FRdBqCcQgdariy0k+E2WYu
         GO1vNQXXbLZdWopeBANRfRRN9HBCrWkJUOk24E4rStUjXEnv7PpKKHyXjJfRnIpLDf5c
         6h1tPNyxEX1+v7tqUgrxDal1/gR9Mh68fp63ojD9m7acLifPruKFIeMeQWEENaevrBxO
         x43A==
X-Received: by 10.182.45.231 with SMTP id q7mr19691859obm.58.1368694623735;
 Thu, 16 May 2013 01:57:03 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Thu, 16 May 2013 01:56:33 -0700 (PDT)
In-Reply-To: <51949B85.40600@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224514>

On Thu, May 16, 2013 at 3:40 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>> What if I want something in -vvvv except some in -vv? I think to avoid
>> option explosion, maybe we can adopt --pretty=format:xxx from "git
>> log" and let the user decideswhat (and how) to display. "pretty" code
>> learns about alignment already, which may be useful here.
>> --
>> Duy
>
> Sure, that is the big solution we've been talking about. Unify
> for-each-ref formats and log formats and use that. After all, "git
> branch" in list mode really is for-each-ref, and should be transparently
> so; same goes for "git tag". Think "git rev-list" and "git ref-list"!

Again I forgot about for-each-ref. Sounds like sharing code between
for-each-ref and branch is a good thing to do. Then just add more
candy placeholders from git-log like %C(xx). Sounds like a fun topic.

> But I guess we'll be compabeaten ;)

No idea what that last word means :(
--
Duy
