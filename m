From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Fix safe_create_leading_directories() for Windows
Date: Thu, 02 Jan 2014 21:37:39 +0100
Message-ID: <52C5CE13.2020506@gmail.com>
References: <52C5A039.6030408@gmail.com> <alpine.DEB.1.00.1401021826120.1191@s15462909.onlinehome-server.info> <52C5ABDE.1010006@gmail.com> <20140102181857.GG7608@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jan 02 21:37:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vyp1d-0003Jd-0S
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 21:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbaABUhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 15:37:48 -0500
Received: from mail-bk0-f52.google.com ([209.85.214.52]:54951 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbaABUhs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 15:37:48 -0500
Received: by mail-bk0-f52.google.com with SMTP id u14so4629852bkz.25
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 12:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=MbSuYqRvfTFcCgqDhBJul0fjRBjoGPLtsBSab6VULDk=;
        b=Dn87PHgebNrJSjpz/3Z1/SI1rUpOwN+oT8xliyDuSFwOaaQkrUT21l5cTTWy0uis0F
         oxE5iLeBZdxY4AdPy6x4OT9mTjLBRE37/lx8v36y5kJJJg7E27EDU3PdHCEs/Mbf6+x0
         2AvPdZG3GQPg3BWfPIQLPJJznKPAYKsI1AQNUm6JC33cnn7poc3zK7gH3ocvkaBS0UCd
         WzHNFTA7aDWHXQM5w4AzvympLddEV+1+HdJFKu2G4RDqvzVIfiDlqRNpDsARmuoepGcK
         r1VKEnKk3T15CAvbG0mokcdSsff1Bl+l5Is+8LNZU97sVwdxZclS7Xug0ldEAaFNTRwh
         Wlzg==
X-Received: by 10.204.203.12 with SMTP id fg12mr4958779bkb.31.1388695067160;
        Thu, 02 Jan 2014 12:37:47 -0800 (PST)
Received: from [192.168.188.20] (p5DDB39A7.dip0.t-ipconnect.de. [93.219.57.167])
        by mx.google.com with ESMTPSA id dg4sm44037165bkc.10.2014.01.02.12.37.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 Jan 2014 12:37:46 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20140102181857.GG7608@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239873>

On 02.01.2014 19:18, John Keeping wrote:

>> That said, I see any further explanations on top of the commit message
>> title is an added bonus, and as "just" a bonus a link to a pull request
>> should be fine. You don't need to understand or appreciate the concept
>> of pull requests in order to follow the link and read the text in there.
>
> The commit message serves as an historical record of why a change was
> made; depending on an external service to provide this information when
> it can quite easily be included in the commit itself lessens the value
> of the commit message.

Sure. My point just was that IMHO the commit does not *depend* on the 
information provided in the link; for me the commit was simply 
self-evident, and I just added link as optional information, not to 
replace any inline text that I would have written otherwise.

-- 
Sebastian Schuberth
