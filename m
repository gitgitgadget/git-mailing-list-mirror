From: Jon Forrest <nobozo@gmail.com>
Subject: Re: [PATCH] Fixed pluralization in diff reports
Date: Sun, 31 Jul 2011 22:09:23 -0700
Message-ID: <4E363503.6050102@gmail.com>
References: <4E3624F9.7070406@gmail.com> <7v8vrdkc19.fsf@alter.siamese.dyndns.org> <4E36277B.9020208@gmail.com> <7v4o21k9e9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 07:09:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnklJ-0007vu-OY
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 07:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569Ab1HAFJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 01:09:54 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55594 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291Ab1HAFJw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 01:09:52 -0400
Received: by gyh3 with SMTP id 3so3255198gyh.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 22:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=EnLo27H3nMyVHqodwyA+rbhzhX3g5x0QH9OLEQEx8eU=;
        b=AT42g1MjIDH5MiRost26kyJJ+J4E/AUmvCjUf5H9KRs5P4SA+uaCtiLZLsFbqA5fm3
         Wi9M/WMASEBO60XOPPF0xzvryE1XXWE0roGLdDJw/cmWo/3+78khsiR6vtwg26/yEQEB
         a88zu6akA7Os8aIadF9q7OcmeanNYKYmrJHos=
Received: by 10.142.60.21 with SMTP id i21mr2734113wfa.389.1312175391758;
        Sun, 31 Jul 2011 22:09:51 -0700 (PDT)
Received: from [192.168.0.107] (c-98-248-228-150.hsd1.ca.comcast.net [98.248.228.150])
        by mx.google.com with ESMTPS id v17sm2866721wfd.5.2011.07.31.22.09.50
        (version=SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 22:09:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <7v4o21k9e9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178320>

On 7/31/2011 10:06 PM, Junio C Hamano wrote:
> Jon Forrest<nobozo@gmail.com>  writes:
>
>>> This is how the other diff implementation has always showed this line, no?
>>
>> Maybe, but it's not grammatical English no matter who does it.
>
> It does not matter it is grammatical or not; changing it would break
> expectation by scripts that are used to the output both by the other
> implementation and by us.

I see your point. I agree that this change isn't important
enough to disturb so many things. I didn't realize this
would happen.

Sorry,
Jon
