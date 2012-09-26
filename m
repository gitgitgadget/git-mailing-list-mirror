From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/7] Extract, test and enhance the logic to collapse
 ../foo paths.
Date: Wed, 26 Sep 2012 12:45:05 -0700
Message-ID: <20120926194504.GA5013@elie.Belkin>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-4-git-send-email-schwern@pobox.com>
 <20120730195108.GA20137@dcvr.yhbt.net>
 <5016F2A5.1090102@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael G Schwern <schwern@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Sep 26 21:45:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGxXw-0001SY-5z
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 21:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095Ab2IZTpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 15:45:13 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:43393 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034Ab2IZTpL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 15:45:11 -0400
Received: by padhz1 with SMTP id hz1so707681pad.19
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 12:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=X2Cvr9AlmYuhsbJEgJZiydzCBF9EfXwUkQhV/WHIduI=;
        b=MS1tfMOUXYmKd9LkWNI8TrDU/Agkotd3Aqu5Lifzu2bE1RliIzCutzxob4TpMWjkEa
         J/8NvQrZbcXs9ixKQc7F8qx0TZXLqryMnVvaY0XkFp8s47FftiLQS83JRwrJgr6xN50n
         By7dPMVCfALg8696M/cmPdOEu8+5KaTLE3MTl8noMNNj4i0tZargWaMtn6MMhbV+9rpL
         xnRW0fXSQHvDMPsWMAPkw/vTr1bWYGhX6DyhqM3hmWXIElb31W0RAojXsimTuXBOxFwz
         WPcnLfFF3bTK53LeCpe3HxHFZyPNk9jrexIbqMS/N/no5754qEzWPOjRfQSlWYkc98XU
         agWg==
Received: by 10.66.74.100 with SMTP id s4mr3793532pav.27.1348688711123;
        Wed, 26 Sep 2012 12:45:11 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id pw9sm2513905pbb.42.2012.09.26.12.45.09
        (version=SSLv3 cipher=OTHER);
        Wed, 26 Sep 2012 12:45:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5016F2A5.1090102@pobox.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206441>

Hi,

Michael G Schwern wrote:
> On 2012.7.30 12:51 PM, Eric Wong wrote:
>> Michael G Schwern wrote:

>>> _collapse_dotdot() works better than the existing regex did.
>>
>> I don't dispute it's better, but it's worth explaining in the commit
>> message to reviewers why something is "better".
>
> Yeah.  I figured the tests covered that.

Now I'm tripping up on the same thing.  Eric, did you ever find out
what the motivation for this patch was?  Is SVN 1.7 more persnickety
about runs of multiple slashes in a row or something, or is it more
of an aesthetic thing?

Puzzled,
Jonathan
