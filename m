From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] git-gui--askpass: generalize the window title
Date: Fri, 12 Feb 2016 10:26:30 +0100
Message-ID: <56BDA546.4090808@gmail.com>
References: <000001529cbe5436-285f0113-5761-49d8-8961-5a9df0180ed7-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 10:26:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aU9zu-0007dG-Ie
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 10:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbcBLJ0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 04:26:37 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35024 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbcBLJ0f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 04:26:35 -0500
Received: by mail-wm0-f43.google.com with SMTP id c200so11606678wme.0
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 01:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:newsgroups:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=Md+i2UPW6zqEGAmr5B4mjJJn2Pg+yMwFkHGbMFHc4kY=;
        b=oWXDMlW2O1moStSESEVJML//Caj/obESJQFJu+WXXbg+BaLkGXSxvQspNOGl6K7iFO
         +8F4GPKvGYYC7fvbWncUZ153lS7n+j4GJmhv9B3gxMQsMqNPO4J84w6e/RxOc3dp/7px
         2Y78TKEOMyVXB3SYRn1gKb/MmPGET/E6dAQvYtSQuYlAUsK5+f9EAQl1okZG+WGjnDuy
         YUG3wcBRCBTkChkT/6pMJFufNIL2/8TVwzrxmUvFFv2VrGuaC1P3tJs3KBx7znKf/Xce
         d02bhAnfLEO3efxN9lRWL6nhEogTBcS3MQQwM7cGvmwPV+wLbYj/uq4Sytg3bOBxYjuQ
         2W1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:newsgroups:cc:from
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Md+i2UPW6zqEGAmr5B4mjJJn2Pg+yMwFkHGbMFHc4kY=;
        b=LbYX3Rnya/Sl/rmomCIYhKSJknpbrJDcjPyPagUff+MKMOX3OfKoXe33lPK4V8Xdpu
         Uu8nsMP4Wgplzbctpty5S3S25Oy10lcLEDEkOcyShEmuRM9YI6ZhskjEF24ppC96gxen
         l7i+B1YKEJMlR/+8UjOKmvf12Tsoyy3G6hK4RgqQGvhou8aZ8QjquyZjtOOFTYMhxT3c
         Bz65KxcNBpwxD5vNw91IgmgalTwshkPgVZlMKrtQgLiPqgP45ctJKQydAtNsT1W4Crhu
         V7XKqEpoqXzNW/6LPaQxaljPCTwzmZ0kT4KGib3K/LSD/7Bc9FN26xpRvUgyuDoUuHUG
         x+Xw==
X-Gm-Message-State: AG10YOSoGPW63pMgOJ2AkoKoXVASr+jHqDQbpn9Zqm9uf8fVrFtEQXUjxnpAmc34js6WcQ==
X-Received: by 10.194.11.67 with SMTP id o3mr617290wjb.74.1455269194596;
        Fri, 12 Feb 2016 01:26:34 -0800 (PST)
Received: from [192.168.188.20] (p508EAD77.dip0.t-ipconnect.de. [80.142.173.119])
        by smtp.googlemail.com with ESMTPSA id ct2sm11120894wjb.46.2016.02.12.01.26.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Feb 2016 01:26:34 -0800 (PST)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <000001529cbe5436-285f0113-5761-49d8-8961-5a9df0180ed7-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286043>

On 01.02.2016 13:11, Sebastian Schuberth wrote:

> git-gui--askpass is not only used for SSH authentication, but also for
> HTTPS. In that context it is confusing to have a window title of
> "OpenSSH". So generalize the title so that it also says which parent
> process, i.e. Git, requires authentication.
>
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>

I haven't seen this being picked up so far. Any comments?

-- 
Sebastian Schuberth
