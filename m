From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] git: treat "-C <treat>" as a no-op when <path> is empty
Date: Sat, 7 Mar 2015 23:38:47 -0500
Message-ID: <CAPig+cRDkoH-zmYhk9ag+Yiwg1h452hOpS2fx2H5xmu5KUNqiQ@mail.gmail.com>
References: <1425640688-26513-1-git-send-email-karthik.188@gmail.com>
	<CAPig+cTkC1Y1sWJLpG0iUHju3GOMnvOT-nsAU51GykeV2QB+vA@mail.gmail.com>
	<54FAD7D7.4030008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 05:39:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUSzS-0003MB-U3
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 05:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbbCHEit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 23:38:49 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:33358 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbbCHEis (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2015 23:38:48 -0500
Received: by yhl29 with SMTP id 29so33068145yhl.0
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 20:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=rzpJVJFKjECaU6Xh5KuGaCxrbyCg+jbKqoD+Uffdy0g=;
        b=ZOeyj6lN/oC/EMcwTAHeD+xf7kGx+30cBysm3Z9SXf8g+Z8O9nsXxXdZBH5KRgbAuO
         ggNCyNRjefsEPr3pbyuXB4Oe57iW4gmNfi8kn9GQErnMhDzXcAUAV0IpgTKMzviVYF+/
         selXmiRyYlCSGKDdacK8x+Cf+r9HHs4MjAgjdsBXOcr5d2bCEIrsIx0uacEp4mlr9Qx7
         2Gn0otqjTz8ketL1QbbDxXuF3pi6xR9b6koeqQp3V3ZypVQcuk50pypaghOSXLGz6YCC
         GEcKmGrdsASqlrg5zD/ywrRTJV85BMUuV4MA4X1MAobnQu5+gMq6ipghHTINvl9QUtgF
         lVbw==
X-Received: by 10.236.70.100 with SMTP id o64mr20482584yhd.94.1425789527918;
 Sat, 07 Mar 2015 20:38:47 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Sat, 7 Mar 2015 20:38:47 -0800 (PST)
In-Reply-To: <54FAD7D7.4030008@gmail.com>
X-Google-Sender-Auth: RmfiJQmi9_2Xd_XdPvAirkB99DM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265025>

On Sat, Mar 7, 2015 at 5:49 AM, karthik nayak <karthik.188@gmail.com> wrote:
>> This iteration looks sensible, except that the Subject reads
>> strange.  Will queue with minor tweaks to the log message,
>> and perhaps with a fix to unreadable *(*argv)[1] that was
>> mentioned elsewhere.
>
> Hey could you tell me what seems strange, so I can improve on
> it the next time.

Junio means that you somehow botched the Subject: line when you copied
the commit message I suggested into your new version of the patch.
Instead of <path>, you wrote <treat>.

> Also "*(*argv)[1]" seems more readable to me, maybe more of a perspective?

I also had considered suggesting (*argv)[1][0] as more readable, but
it is primarily personal taste, and I didn't want to bike-shed the
issue.
