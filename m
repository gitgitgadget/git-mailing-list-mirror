From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/9] for-each-ref: avoid printing each element directly to stdout
Date: Sun, 19 May 2013 18:58:11 +0700
Message-ID: <CACsJy8DEup_oatEwB=-nA6_RGrO=k+urJ7cus4Ngc4GSxxMiNA@mail.gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
 <1368959235-27777-4-git-send-email-pclouds@gmail.com> <CALkWK0mSxYhJDBzrtfZyKQquqAYJiYj2AFBdk3hdDyQgSW3ZRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 13:58:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue2GE-0002C4-Jb
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754481Ab3ESL6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 07:58:43 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:65148 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754307Ab3ESL6m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 07:58:42 -0400
Received: by mail-oa0-f43.google.com with SMTP id o6so6712966oag.16
        for <git@vger.kernel.org>; Sun, 19 May 2013 04:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=RX4RmCc5xpexara6fll2Oqk/E6O+pqXu39Ipa+M+srU=;
        b=p5YXVyG4vTzwqTBEpkVsV8AlKCt4nSeslGkqL0++XiNl1l82Kz9kVKfSiMZCbW17Ea
         HkkU+uNjKR1Mtj8SEjcli4V+4ykOsZ4gA342uSrvvnQ9e7x30gG2YUfl2exPmDx0Evb+
         FO2Yl4WhtlqJiXcXnsN0dYXO64e+Amns5lcofpKqGRNJa8koOG0s8cJ8iyXcn2Wqr8nh
         wxhqvjfGH/I9KAAZsikSMGBUJLE9G26oxTvchYfsApSbmVS+10FG8Ed7gDHL6BC27kGx
         r2vzBHrFjOgxEVWY91z0/1Pe/gzu1w8c0Ycy3miJfv04hsK3Q5DvdnIOJnhNqpQ+g5eP
         LVzg==
X-Received: by 10.60.174.18 with SMTP id bo18mr537639oec.110.1368964721825;
 Sun, 19 May 2013 04:58:41 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Sun, 19 May 2013 04:58:11 -0700 (PDT)
In-Reply-To: <CALkWK0mSxYhJDBzrtfZyKQquqAYJiYj2AFBdk3hdDyQgSW3ZRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224874>

On Sun, May 19, 2013 at 6:17 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
>> [PATCH 3/9] for-each-ref: avoid printing each element directly to stdout
>
> Why did you do this?  Atoms are designed to be independent of each
> other.  I'll keep reading: might find out in a later patch.

Sorry for the lack of explanation in the message. I wanted to discuss
about syntax more than code. As you see later down the series, we'll
need to process an atom for all refs, then output all refs in the end.
We can't do that wihout buffering.
--
Duy
