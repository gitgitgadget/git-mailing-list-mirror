From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/9] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
Date: Sat, 3 Oct 2015 12:44:39 +0530
Message-ID: <CAOLa=ZQ3tJQ6VD6RBBOU_41=75WB1vrD6ASk5HecnnJse0cJ+Q@mail.gmail.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
 <1443807546-5985-3-git-send-email-Karthik.188@gmail.com> <xmqqlhbl3sb6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 09:15:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiH2L-0007eV-6O
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 09:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbbJCHPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 03:15:10 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:34858 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbbJCHPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 03:15:09 -0400
Received: by vkao3 with SMTP id o3so71986191vka.2
        for <git@vger.kernel.org>; Sat, 03 Oct 2015 00:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=a7dq42n3txBH3KtiGQZDM4D09y/oFjNVNvs9rvG+YNc=;
        b=y9PtQ3nM8lOmSU6GgYf9M5naPUrmZ3GLKU2OhWUas4K3hSxAZKy5wkDw1b2PQ/iw81
         OQLcngn/w1VeNd++4ujNuc3H2OVMlu2D60MG2ptVt348IX/Q8LM5urgD/KDV2I3StJqe
         PA1MmjuGoTczn38viKD2WHqb0//yta+ECsreIfOpwSjRvuO7RiWQxm28ZNf1tKNSWV+b
         DT+VsmaZxmDsRink+9tzvsaDpZUj4dCCCcUbO+eyTz/6CwY9uOGMcKPI4ZFiI3gxFMiw
         jTGwShNS18QkBlLwWOuK3CbKTbG7cl7RqK+PLBbQ8EhLwnIP2hdsIUlBL+TPoWZQIkqB
         r9jA==
X-Received: by 10.31.21.149 with SMTP id 143mr12622753vkv.79.1443856508542;
 Sat, 03 Oct 2015 00:15:08 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Sat, 3 Oct 2015 00:14:39 -0700 (PDT)
In-Reply-To: <xmqqlhbl3sb6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278960>

On Sat, Oct 3, 2015 at 2:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Implement %(if:equals=<string>) wherein the if condition is only
>> satisfied if the value obtained between the %(if:...) and %(then) atom
>> is the same as the given '<string>'.
>>
>> Similarly, implement (if:notequals=<string>) wherein the if condition
>> is only satisfied if the value obtained between the %(if:...) and
>> %(then) atom is differnt from the given '<string>'.
>>
>> Add tests and Documentation for the same.
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>
> The fast that the patch touches only the narrow parts that are
> specific to %(if),%(then) and %(else) and does not have to touch any
> generic part (other than the populate_value() parser for obvious
> reasons) is a good signal that tells us that the basic structure of
> the code is very sound.  I very much like the direction in which
> this series is going ;-)
>

Thats nice to hear :)

-- 
Regards,
Karthik Nayak
