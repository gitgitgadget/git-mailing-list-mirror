From: J Smith <dark.panda@gmail.com>
Subject: Re: [PATCH/RFC 2/2] grep: rename "grep.extendedRegexp" option to "grep.patternType"
Date: Tue, 31 Jul 2012 23:38:43 -0400
Message-ID: <3D9678D0-DD72-4538-81E8-7568A2A3211D@gmail.com>
References: <1343775209-56505-1-git-send-email-dark.panda@gmail.com> <1343775209-56505-2-git-send-email-dark.panda@gmail.com> <7vpq7bh5wx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 05:39:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwPmU-0003b8-JI
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 05:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007Ab2HADir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 23:38:47 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:65196 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782Ab2HADiq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jul 2012 23:38:46 -0400
Received: by yhmm54 with SMTP id m54so6873617yhm.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 20:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:in-reply-to:mime-version:content-transfer-encoding
         :content-type:message-id:cc:x-mailer:from:subject:date:to;
        bh=l+NxtmJPjQ8IBvMyv6zmn4qhN27iRU9jIaSCtx+TivI=;
        b=NjHhUxrU83NNJkeiALgBe1hndNqDnttBtS6OWIWU7ZqsWxkwCNcWV0oZMIN3EJhI5V
         oYsVLqR9ZD9IqE5BAzZjcpL9xdi/l4OXZOyxZXOPvLmVMQWwsLYew8pi+XxFbQtSbhlM
         05E5LKhKWDEVN7VeNz2bU5EsL+WJyXOboPNW5/Ar1O/h9SvWHq83ZUUopUfiOuUbsA7X
         yVKTuDqJ+SZ5T5b+LQkjrqsTL1VVdLsZU1Qc427I69Ki7DI/g0Sdgs7N+MeBCNRo5ISA
         QRmhFW5w6ygH9y5tB6pStl2iiZNm1Hr1pxV7YYM5jLdddqYyquFFfRMOnfVu7Lhkd8mM
         7aAg==
Received: by 10.50.106.136 with SMTP id gu8mr2730532igb.23.1343792325189;
        Tue, 31 Jul 2012 20:38:45 -0700 (PDT)
Received: from [192.168.1.136] (bas1-burlington02-2925096436.dsl.bell.ca. [174.89.109.244])
        by mx.google.com with ESMTPS id nh1sm11276203igc.11.2012.07.31.20.38.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 Jul 2012 20:38:44 -0700 (PDT)
In-Reply-To: <7vpq7bh5wx.fsf@alter.siamese.dyndns.org>
X-Mailer: iPad Mail (9B206)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202701>


On 2012-07-31, at 7:22 PM, Junio C Hamano <gitster@pobox.com> wrote:

> J Smith <dark.panda@gmail.com> writes:
> 
>> With the addition of the "basic", "extended", "fixed", and "perl"
>> values for the "grep.extendedRegexp" option the name "grep.patternType"
>> better represents the option's functionality. "grep.extendedRegexp"
>> remains available as an alias to "grep.patternType" for the purposes of
>> backwards compatibility.
>> ---
> 
> Sorry for not bringing this up earlier when we discussed grep.patternType,
> but my preference would be to introduce grep.patternType with these
> type names (including basic and perl) from the beginning, and then
> ignore grep.extendedRegexp if grep.patternType is set.
> 
> The core part of the change may look something like this...

Ah, I see. Yeah, that's not a problem. I'll make the appropriate changes tomorrow and post a new patch. 