From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 3/4] count-objects: report garbage files in pack
 directory too
Date: Thu, 14 Feb 2013 16:24:11 +0700
Message-ID: <CACsJy8DxRuML1+gSCZaGC1hA4MU9sWnoGJGZMbeUVdaipOH7vA@mail.gmail.com>
References: <7va9r9igze.fsf@alter.siamese.dyndns.org> <1360746799-3668-1-git-send-email-pclouds@gmail.com>
 <1360746799-3668-4-git-send-email-pclouds@gmail.com> <7vehgkb43v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 10:25:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5v40-0002JO-GA
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 10:25:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756834Ab3BNJYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 04:24:44 -0500
Received: from mail-ob0-f178.google.com ([209.85.214.178]:58917 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756741Ab3BNJYm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 04:24:42 -0500
Received: by mail-ob0-f178.google.com with SMTP id wd20so2238276obb.9
        for <git@vger.kernel.org>; Thu, 14 Feb 2013 01:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=oBjmpnk82a/qMubwxSz3tADq1f9/JPl1gyX044mRCug=;
        b=UfjF5btw/35Q7R3MlqHjKhjzJ6knuBHuFsu6F+dfqwrFd4NbFm+1PPduPL+Y1b0b1X
         y6O7LahFNnU6vT7q9n1Bm9nhcnm7hIIbss5DWlA+E0vsplQJF155fAUmgn7IGFcMHyJ4
         h31YxxKHXK6g4rTa7p9uuRc9CAEW3dWfSEz/Q68NiYX2aXBJ1YZR/wLtnWLgdRGid6Te
         GA3WUn/MlCrfK3auCaSblUe0WYtbvbqlP2XG5ldJeduJobK0em2ete09Y3+/HzkyKceE
         BaFiD4ImkzJJ0+YCCEf3flSR/NlgBqRy1w40u6SqBFFU47UJ8/A4IU2SkY4X0zgl+rX7
         GdYQ==
X-Received: by 10.60.5.231 with SMTP id v7mr19015966oev.62.1360833882003; Thu,
 14 Feb 2013 01:24:42 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Thu, 14 Feb 2013 01:24:11 -0800 (PST)
In-Reply-To: <7vehgkb43v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216302>

On Wed, Feb 13, 2013 at 10:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> +     default:
>> +             return;
>> +     }
>> +     for (; first <= last; first++)
>
> This looks odd.  If you use the usual last+1 convention between the
> caller and callee, you do not have to do this, or call this function
> with "i - 1" and "list->nr -1" as the last parameter.

I know. I just don't know how to name the variable to say "the element
after the last one".
-- 
Duy
