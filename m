From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] configure.ac: check tv_nsec field in struct stat
Date: Thu, 8 Jan 2015 00:41:57 -0500
Message-ID: <CAPig+cSwBZuYAp97nLBLcdCkTrcbCfwZ+xKe0JAEt_ekk3EFRA@mail.gmail.com>
References: <CAPig+cSFAzsUj2sOaCyPTu_U8_c5qkF1qQo4nzecVzY0TqmJpg@mail.gmail.com>
	<1420662236-27593-1-git-send-email-reubenhwk@gmail.com>
	<1420662236-27593-2-git-send-email-reubenhwk@gmail.com>
	<CAPig+cSrht0fovEWhEknxPPzwZhA7vzeLcM+omaM7PR752GfGw@mail.gmail.com>
	<CAD_8n+RkCWzz0VSPb+3XkR-qbms1csGBbFRJtc-HwMp823QdCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Reuben Hawkins <reubenhwk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 06:42:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y95rA-00081e-Fp
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 06:42:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbbAHFl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 00:41:58 -0500
Received: from mail-yk0-f181.google.com ([209.85.160.181]:60278 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbbAHFl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 00:41:58 -0500
Received: by mail-yk0-f181.google.com with SMTP id 142so424389ykq.12
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 21:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=5pJUCislKYFEBvn50SdgpQ6cdg5At10rtRT3PJ0BrO8=;
        b=qxa+fmVREWYROHUpvo5Nuew6YIyN28zy+QG5z4ughv9aEnt0bOQkyEETGgkqw3dTms
         8eMTMuQzvmrggW/HEcGZJRyr/msiIsF3eH+v1KjebNPO7xt0peu8XYVidghNT8KR2DWQ
         2tWUiVepPCqW3qsXGFvR5Bj/BDYGiVz9n5194QX+iG1d//H2EA6t6kxjBrO6nItUwoHg
         0lhoV38qdiBu62GRZ+x22kJrkqVmygSz6TRghrgnxQ2Zpo/ENaI5eD9Z1+o2SA+Ll9xv
         70NxzSnCQrrADGJnj+EoIhVVkvGApTScUuJ0M17dFDLZ2x4MHPXVLpWg72QZBY3F2qJs
         Klsg==
X-Received: by 10.236.89.172 with SMTP id c32mr5195913yhf.180.1420695717552;
 Wed, 07 Jan 2015 21:41:57 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Wed, 7 Jan 2015 21:41:57 -0800 (PST)
In-Reply-To: <CAD_8n+RkCWzz0VSPb+3XkR-qbms1csGBbFRJtc-HwMp823QdCQ@mail.gmail.com>
X-Google-Sender-Auth: JAnom3I4peM0k4Lm26347L3xVXw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262182>

On Wed, Jan 7, 2015 at 5:19 PM, Reuben Hawkins <reubenhwk@gmail.com> wrote:
> On Wed, Jan 7, 2015 at 1:19 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, Jan 7, 2015 at 3:23 PM, Reuben Hawkins <reubenhwk@gmail.com> wrote:
>>> This check will automatically set the correct NO_NSEC setting.
>>
>> This commit message neglects to mention the important point that
>> you're also now setting USE_ST_TIMESPEC when detected. You might
>> revise the message like this:
>>
>>     Detect 'tv_nsec' field in 'struct stat' and set Makefile variable
>>     NO_NSEC appropriately.
>>
>>     A side-effect of the above detection is that we also determine
>>     whether 'stat.st_mtimespec' is available, so, as a bonus, set the
>>     Makefile variable USE_ST_TIMESPEC, as well.
>
> I see you're single quoted 'tv_nsec' and 'struct stat'.  Should I also
> use single quotes in the first line of the commit msg like this...
>
> configure.ac: check 'tv_nsec' field in 'struct stat'

Quoting them was just my personal taste, however, consistency of
formatting between subject and the body of the message would be nice.
Use whatever seems correct to you.
