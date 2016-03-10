From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v4] commit: add a commit.verbose config variable
Date: Fri, 11 Mar 2016 04:09:08 +0530
Message-ID: <CAFZEwPOfK4qOQ5+8vVaspx+LM+QcG+gw2uKtyjQEu7jWdHxTGA@mail.gmail.com>
References: <0102015362963f6a-626ad27e-e705-4a75-93a6-55a5f75d0226-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 23:39:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae9Eg-0001GC-Gt
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 23:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596AbcCJWjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 17:39:10 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34010 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641AbcCJWjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 17:39:09 -0500
Received: by mail-yw0-f194.google.com with SMTP id f6so5199923ywa.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 14:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to;
        bh=71RjKE5exTH3EYEeCwb46KSwvpLpV0zUMt91MspeQtY=;
        b=EZzl29nagyTIn89F2K0mVZlVLJsMzjYo7x6oqbeMapD+s1mgKt1tw2dVdQ1rHYHFwc
         uZiU7yGSOYGeykRoKVI3ZJbCxCf+Zr5QuuQnsForssmA6LnyWsb3dsPYk7LQTfFzWq4S
         dky1f7cP11EgD6WKcnVJO4Yo11JO9b8sU/GmvPPz/0mCnwizERAz2jvQco+J7a79gy27
         LRnQdUIPkY1PS8KnJ2ROnszP2Zv9BkZKhhTrBAbZ9ZrjjibgCIaBolyn4vw8VtX6sqLP
         AWoVVH4X3WU8x5wyQ2lYYafOtzom9MTm+HrnP61AgVvr7S2MO2fuNjIoaJXLSaNLOR8C
         I1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to;
        bh=71RjKE5exTH3EYEeCwb46KSwvpLpV0zUMt91MspeQtY=;
        b=NdkmngjQMKxmI7pdaHadmidKQe1yxwjCq2kcuhPThFnOhtYN4vgDo1YCd1zGxIkr5J
         2GR3WQThS00Mom3lb6ytPmkKBAsXUl1EO7rrNAwa8JVqRZN3Ex8kLdJRF21NWYOJuGHH
         ibHp/lFC+LdAD58OOYu0W1orZ9wmVt4YapX5/LJtaRFnbUshq07fOCrxyQsCfZoLT+/o
         +oaTxTvNM3a5xe1sBtgl67YT61gqIXw6ut4Uusrw3eSB8/JyM4FB/lV/4YLOVL0u8EQh
         N3sTDyTI8Zbqys/R7cXvwOvKrlI8xzzr7csIm1iztzIrZJrfJiXQYWDj2KiAmlkgrfXX
         /pXw==
X-Gm-Message-State: AD7BkJLXk7zgfPRPWzAUH7T4cAzYXADWCH9zpvqnnFyMl7k+Gc/v72CBtKrHCtL1ohlyOtBN7/S94iZoQICSAg==
X-Received: by 10.129.37.3 with SMTP id l3mr3351120ywl.128.1457649548411; Thu,
 10 Mar 2016 14:39:08 -0800 (PST)
Received: by 10.13.203.137 with HTTP; Thu, 10 Mar 2016 14:39:08 -0800 (PST)
In-Reply-To: <0102015362963f6a-626ad27e-e705-4a75-93a6-55a5f75d0226-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288654>

Older versions of this patch can be found at :-

[v3] : http://thread.gmane.org/gmane.comp.version-control.git/288634

[v2] : http://thread.gmane.org/gmane.comp.version-control.git/288569

[v1] : http://thread.gmane.org/gmane.comp.version-control.git/287540

The changes with respect to last version are :
 - put the code in git_commit_config() instead of git_status_config()
 - Add test to cover all possible scenarios

Regards,
Pranit Bauva
IIT Kharagpur
