From: David Foster <davidfstr@gmail.com>
Subject: Re: Git/Mac refuses to install on OS X 10.8 (Mountain Lion)
Date: Sun, 07 Apr 2013 12:20:15 -0700
Message-ID: <5161C6EF.8010506@gmail.com>
References: <5160D223.3090203@gmail.com> <5161890E.701@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sun Apr 07 21:20:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOv8b-0002lr-0r
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 21:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933009Ab3DGTUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 15:20:21 -0400
Received: from mail-da0-f43.google.com ([209.85.210.43]:40789 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761204Ab3DGTUU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 15:20:20 -0400
Received: by mail-da0-f43.google.com with SMTP id u36so2306799dak.2
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 12:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=mUFL5yj30PrU2Q+FWi+rXfQey3w9ZgI2GTZNuLccPYY=;
        b=V/IsdyBEp4fxqRRJWANvG3NSrAc4MXU8zktqh+wzXxV8IoKlOrCUGFZugS2DIoYwjw
         GFP0Eyt0Tqlz/WxrO84hgmxmLuU64EKDPg47TFG2WOPp5c7C5GvY//9rtVKbeQDts4qq
         PzC6bdMXs4BycwO/8mgmA6meRmffo7YAY6sZl9Xd7jaDky0cR+8pRSv5LnKvsm0MoYD6
         QmhURtUwGb1nJZTRpxn6wL7BGKWNgurdJUu6jqRhn1tJ/Mo9Yf5suVv6tlP5PQnpU9R6
         4DENB0B0TyHHrQ/KflnHje5tPOWV3z1JXxR1J+f2s/1TyYoV1jM26vPspC/vefT4JWwU
         OIJw==
X-Received: by 10.66.159.234 with SMTP id xf10mr26297329pab.203.1365362419669;
        Sun, 07 Apr 2013 12:20:19 -0700 (PDT)
Received: from Cathode-2.local (c-66-235-53-6.sea.wa.customer.broadstripe.net. [66.235.53.6])
        by mx.google.com with ESMTPS id u9sm32297198paf.22.2013.04.07.12.20.17
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 12:20:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <5161890E.701@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220364>

 > That aside; Does the package work if you reduce the security settings,
 > install it and then reset the security settings to their default
 > settings later? If so, I'd call that a reasonable workaround

It does. An even better workaround is to right-click (or Control-click) 
on the installer and select Open. This provides a slightly different 
dialog with gives an override to open the application anyway. This 
method avoids changing the OS security settings.

 > and we probably won't even have to document it since google should 
provide it

If you intend to make the workaround official, then it would be a good 
idea to at least mention it on the download page. It is poor user 
experience to require users to use Google to workaround issues in a core 
installation scenario.

--
David Foster
http://dafoster.net/

On 4/7/13 7:56 AM, Andreas Ericsson wrote:
> On 04/07/2013 03:55 AM, David Foster wrote:
>> The default security settings on OS X 10.8 (Mountain Lion) disallow the
>> installation of unsigned packages, with no override.
>>
>> Git/Mac 1.8.2 is not signed and therefore will not install without
>> changing
>> the OS default security settings.
>>
>
> Sounds like an OSX lockin bugture to me. If anyone can sign the package
> with any random key, then it wouldn't provide much in the way of
> security, so I guess that means one has to get a signing key form Apple,
> which I doubt they just hand out to anyone (usually it means paying
> $100 to get an "apple developer certificate). That's nonsense, ofcourse,
> but it's how they've chosen to do business.
>
> That aside; Does the package work if you reduce the security settings,
> install it and then reset the security settings to their default
> settings later? If so, I'd call that a reasonable workaround, and we
> probably won't even have to document it since google should provide it
> for git and a plethora of other useful packages.
>
> Otoh, if enough osx folks want git on the latest pussycat, I'm sure
> they'll provide a package themselves sooner or later, in which case
> you just have to wait for that to happen.
>
