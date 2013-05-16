From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] branch: add show-tracking option
Date: Thu, 16 May 2013 11:28:45 -0500
Message-ID: <CAMP44s3cjO4ETd+_oQB=afxDuWZb+HBDEOA2sdHfFQ10+y9foQ@mail.gmail.com>
References: <1368690532-12093-1-git-send-email-felipe.contreras@gmail.com>
	<5194921F.4080103@drmicha.warpmail.net>
	<CACsJy8CrGTa2XdfFkkKDQQjF8gM3011RiUE6roe9L7yZZq5J2g@mail.gmail.com>
	<51949B85.40600@drmicha.warpmail.net>
	<CACsJy8D_5YE3w4WNvCA8-fA-y5DV2WqHULqcMYqd7X_SSh_aHw@mail.gmail.com>
	<7v1u9699x7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 16 18:28:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud12x-0000n5-QU
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 18:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735Ab3EPQ2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 12:28:47 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:43242 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224Ab3EPQ2r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 12:28:47 -0400
Received: by mail-la0-f43.google.com with SMTP id ez20so2043754lab.16
        for <git@vger.kernel.org>; Thu, 16 May 2013 09:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=uuXlL8MbFgqC1XlK4zg4BCmXp1iN2mW3Me+v8rZ3UZk=;
        b=Z092IW/Vv3Ix9drSUTvttbw5IuKzrazv0uOy2qSv7bX44Rv4hKWHeEEHQ32VowsEfZ
         N4kxHcMBfYr9+A1pCGJWfkjFCYSYSsmgGn3i3iV/u2+KHF/tHhE+yOGZFdH12EwvKXEa
         EdXdZnAaYS3BsEOEQzIN6X4UeAp4cBAW5fdHvDS8odIgCcl29Y28ifTsR0BFkRxzfXmc
         LTzVejVkQBwwaJM2r90TD5Cg5ZDHhL5NffH1Mk0QYhB+S0vdPmojOP1FEXZ89QqJ0WsZ
         D3nqc33O0MMdGG/PFy0gOP1G9iRg0/yRpqkpo6DXnoetqjCdyy1IzrCRNHPB1Rc6UWtD
         +kGA==
X-Received: by 10.112.166.101 with SMTP id zf5mr20069031lbb.59.1368721725452;
 Thu, 16 May 2013 09:28:45 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 09:28:45 -0700 (PDT)
In-Reply-To: <7v1u9699x7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224593>

On Thu, May 16, 2013 at 11:17 AM, Junio C Hamano <gitster@pobox.com> wrote:

> *1* indented because this is dependent of @{u}; showing ahead/behind
>     without showing @{u} would not make any sense.

That's what 'git branch -v' does.

-- 
Felipe Contreras
