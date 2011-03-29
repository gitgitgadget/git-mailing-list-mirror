From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: GSoC 2011
Date: Tue, 29 Mar 2011 13:45:15 +0200
Message-ID: <AANLkTi=K1kMo7H99CUcNG-awwh1E+WgBNs7OZ4eweS18@mail.gmail.com>
References: <AANLkTikQ6=CrWuMemwv38HnBKPnt8CjQWqYj7oA8zVZ4@mail.gmail.com>
 <AANLkTikC5cagS8qYPDmWO+jhC4pHMkJq6zQN3QemMhwG@mail.gmail.com>
 <AANLkTikM7C_h5cwgd5KoddBUH3xsdwtBiGwM_2ecKR2k@mail.gmail.com> <AANLkTin9REqDJhWbQ2JbESufcg6hSf6cw3NpiamXvkU_@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karol Samborski <edv.karol@gmail.com>, git <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 13:45:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4XMl-0005KM-Qo
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 13:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837Ab1C2Lpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 07:45:38 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49942 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994Ab1C2Lpi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 07:45:38 -0400
Received: by fxm17 with SMTP id 17so119129fxm.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 04:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=UmyRimrzhFdwVpZv2u6haKmLbF2TojyDtt0DbvgdCz4=;
        b=OKRYxwdhax3PFM80A5F/+ZTixhIlgb6t3Qy3FadPY9BkPafMl6ezN0A7+T/CM6Na3Y
         P/ClWKIt1W7gVkbVIBoxXITtyty0w9z43tANqwahUts6bYLFKnd4KknuvaWHvvuv6uc8
         Ibha1qYdjrUZkfpqFHHNz4nvkBcYBsW5rNDMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=rNyliWQYzIdqGWBjkiaBak3xE9CnmdnebdkPPPHitKh+aAnWDVkFU46OaUf8zMG9kV
         /Zo5DQqIiyr8EUzo03QhdPoiutmracQx67rLIFOfDHYdb/Regfiu0qCMxrlPe3KmdiiB
         /9EtKkF/4W64GHQXDmHFZtCBzNIsCFTz4BUok=
Received: by 10.223.73.133 with SMTP id q5mr3454615faj.127.1301399135111; Tue,
 29 Mar 2011 04:45:35 -0700 (PDT)
Received: by 10.223.126.145 with HTTP; Tue, 29 Mar 2011 04:45:15 -0700 (PDT)
In-Reply-To: <AANLkTin9REqDJhWbQ2JbESufcg6hSf6cw3NpiamXvkU_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170256>

On Mon, Mar 28, 2011 at 10:17 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Mon, Mar 28, 2011 at 9:55 AM, Karol Samborski <edv.karol@gmail.com> wrote:
>> 2011/3/28 Christian Couder <christian.couder@gmail.com>:
>>>
>>> It depends a lot what part of git you would like to work on.
>>> Do you find one of the proposed subject interesting?
>>> If yes, tell us and the relevant people will probably tell you what
>>> you could start with.
>>
>> I thought about "Build in more external commands".
>
> Ok, but which of the suggested commands would you like to rewrite?

Before anyone starts on git-send-email.perl, I'd like to give heads up
that I've been working on that one a bit.

The code can be found at http://repo.or.cz/w/git/kusma.git in the
work/send-email-c branch if anyone is interested, but be warned: It's
messy and not really working yet, as it only really sends a single
hard-coded e-mail so far.
