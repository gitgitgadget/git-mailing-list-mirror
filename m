From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v4 0/2] allow git-svn fetching to work using serf
Date: Thu, 18 Jul 2013 17:16:44 -0700
Message-ID: <ACCFF6B2-010B-465A-A011-E56BCE64C119@gmail.com>
References: <8a6adfae744011599e410da7a46808b@f74d39fa044aa309eaea14b9f57fe79> <7v8v131lye.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 02:16:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzyNQ-0004CJ-DE
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 02:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934825Ab3GSAQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 20:16:48 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36184 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934805Ab3GSAQr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 20:16:47 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj3so3804992pad.0
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 17:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=qCZ9prAcwsdLkVyTKiiR0i8GFU2wSoI1JHPKHzDa+lg=;
        b=fKLyPK85r5RVxlLW1/IZ+lTYZuTv17cnwi+HBEdFYOBHA8uBsEz4wuPzX6/m7LJCbR
         lL5povLnIauRQmE6zRW2CFQvuXgykGd9Dag5WJWE4zX8n3gZstV48RxNKxYCivg0XuCt
         iNNo5iT4eg1LIfnJXapwYpCMcKB7ZgzLEVq6FN5TPFr+Orp9CcOgm9cn5xNshDTH6q2/
         r/Z/ITmK9EmCQkIUjoxZqzRD8OMOmKYNN7kotm/sRXB65NwlnLlXURSZVl7L45Il8h16
         vJXP2Sb+QORl+yBWYHCcTzM+rg8AGBHZGvPTuGtMb1yOMJSDk3DmBmRg39d0OaS4gd3W
         VIaQ==
X-Received: by 10.66.222.1 with SMTP id qi1mr15679933pac.53.1374193007434;
        Thu, 18 Jul 2013 17:16:47 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id iq6sm16216528pbc.1.2013.07.18.17.16.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 17:16:46 -0700 (PDT)
In-Reply-To: <7v8v131lye.fsf@alter.siamese.dyndns.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230772>

On Jul 18, 2013, at 16:34, Junio C Hamano wrote:
> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> This patch allows git-svn to fetch successfully using the
>> serf library when given an https?: url to fetch from.
>> ...
>> Versions v2-v3 of the patch introduced a bug when attempting
>> to change the _temp_cache function to use the new
>> temp_is_locked function at the suggestion of a reviewer.
>
> Err, excuse me, is this meant to _replace_ what is already in 'next'
> for the past 6 days?
>
> Could you feed an incremental update, highlighting where the update
> improves compared to the previous attempt in the log message?

OK.  I have sent out an "incremental update against 'next' branch'"  
patch based on how a set of recent incremental updates to 'next' was  
sent to the list on 2013-07-04.  If that is not what you had in mind,  
I apologize in advance.
