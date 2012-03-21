From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Has anyone written a hook to block fast forward merges to a branch?
Date: Wed, 21 Mar 2012 15:32:10 -0500
Message-ID: <4F6A3ACA.6050100@gmail.com>
References: <CAJ8P3RCQjh1ehjsihAmu8roC1aeRo=R0sN2Wm0Y4bVk=st4ivw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Patti <cpatti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 21:32:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SASCh-0000WA-El
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 21:32:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760482Ab2CUUcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 16:32:14 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33099 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760282Ab2CUUcN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 16:32:13 -0400
Received: by ghrr11 with SMTP id r11so1328918ghr.19
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 13:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=hK15agP/1iK5sZ/UYZayqxVQh+cyZJAAmV/qv/+Eb5Y=;
        b=pMELGZSWHuhputtfxCUww+kfZIX6cjC1rq786ty4quTQb54heetDkpeqpNKosLQ29J
         7qdO7Z1VK9Iqvhkm5WW5AJt1kNLrkT9RicxerTw3lVkL5uoB24x1m9Mn3oZdt3j5jDy/
         IKcX0i0XCpWjZiKZSkkvgDtGmBXKdq7ML4h4LPl4C7e/yew6FVNRdI6ykTOiY6ERsmqf
         IiwEWnJo7ukLPT1gmrflZQw0IA4ITG4+2tt9Vvc8t/mxgq3Eg/bDUgPiMCYOa5eqUKc+
         EYvWAok8ML2yC7z5KioAQGVoUP/lYNZ4I425EZOsi1uTi3YbdcN0YAirxjbYauXxFOTa
         MPog==
Received: by 10.60.14.4 with SMTP id l4mr6374419oec.39.1332361932810;
        Wed, 21 Mar 2012 13:32:12 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id o9sm1837342obd.21.2012.03.21.13.32.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 21 Mar 2012 13:32:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
In-Reply-To: <CAJ8P3RCQjh1ehjsihAmu8roC1aeRo=R0sN2Wm0Y4bVk=st4ivw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193613>

On 3/21/2012 1:22 PM, Chris Patti wrote:
> I know there are hooks out there to block various other kinds of
> change, but I was wondering if anyone had specifically ever written
> one to block fast forward merges.
>
Maybe git-merge --no-ff would also be helpful to "do what you want".

(I'm not sure why you would tell people they can't do their work really 
fast or rebase to make it look like they did, but it seems that's what 
you are also implying.)

v/r,
neal
