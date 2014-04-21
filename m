From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Mon, 21 Apr 2014 14:39:44 -0700
Message-ID: <53559020.1050407@gmail.com>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com> <5355793A.5020000@gmail.com> <53558476703cb_5c94d452ec4e@nysa.notmuch> <53558A54.4060801@gmail.com> <53558ae6f1282_604be1f30cf3@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 23:39:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcLwS-0007qf-OA
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 23:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754500AbaDUVjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 17:39:54 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:56524 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbaDUVjw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 17:39:52 -0400
Received: by mail-pb0-f45.google.com with SMTP id uo5so4152115pbc.4
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 14:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=ananBGPwmtbx3plDabJYx9GlS1SCpp+jmL8OoaCc4E4=;
        b=WgpcqtQCENA6T9weViG2BvA1fV9kKJ1QoVeSxZOWaaBAvnm7uSQP/bnzC2brJsIepj
         hNDIEVMAaJ18Mp95/Vs5FvELH5B8UwaI9epnaRZ35YfFFhzHXWtu7g2vRFhiBzPtcffk
         rOSX37N6TvQhmiZHDFgYdHMdscmvbaVBQ3qbb1/GW9B3HHETgS44f0JtSVPQDmeUzxOs
         ZNT5Lr+BsufzH3kJA6vsbdsdFoXc48gcwKdZHYJyYRstdKtRKoZTAX8QIMFMyvfTK163
         pVtSaC8GfLGvLgPfCnchJ8nizfk20KcvpODD/Xb3DEwntXQV6Ts1KXqYdO1twtSBYbsP
         kkBg==
X-Received: by 10.69.19.161 with SMTP id gv1mr5430714pbd.143.1398116392162;
        Mon, 21 Apr 2014 14:39:52 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id ky8sm80173266pbc.64.2014.04.21.14.39.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 14:39:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:28.0) Gecko/20100101 Thunderbird/28.0
In-Reply-To: <53558ae6f1282_604be1f30cf3@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246650>

On 4/21/2014 2:17 PM, Felipe Contreras wrote:
> Ilya Bobyr wrote:
>
>> Also, most have names that start with either "pre-" or "post-".
>> It seems reasonable for both "pre-update-branch" and
>> "post-update-branch" to exist.
> I don't see what would be the point in that.

Do you see the point in the other hooks doing that?
