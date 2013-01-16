From: Stephen Smith <ishchis2@gmail.com>
Subject: Re: Question re. git remote repository
Date: Wed, 16 Jan 2013 15:59:04 -0700
Message-ID: <0630A778-9AC8-4023-889C-4FC58ABAB683@gmail.com>
References: <201301161749.r0GHnGV6007806@smtpb02.one-mail.on.ca> <20130116220615.48c159546bccfa5b9cd9028e@domain007.com> <20130116182156.GB4426@sigill.intra.peff.net> <20130116233744.7d0775eaec98ce154a9de180@domain007.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jeff King <peff@peff.net>,
	Konstantin Khomoutov <kostix+git@007spb.ru>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Lang, David" <David.Lang@uhn.ca>
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Wed Jan 16 23:58:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvbwR-0005kx-3B
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 23:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758063Ab3APW6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 17:58:20 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33706 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757773Ab3APW6S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2013 17:58:18 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so1055811pad.25
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 14:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:references:mime-version:in-reply-to:content-type
         :content-transfer-encoding:message-id:cc:x-mailer:from:subject:date
         :to;
        bh=TXoOXs6GChE6BZ5FnzG2NqkfrA1Skr1Ni7fytEFLBhI=;
        b=Jol4p8UIHc/i+KqZ0LGKCsh+ANrwe9o+MpsEQ8d9RA5tdbyrr+OgD2bY00wZ/YAfk5
         P1ZVbXwXnWm3SWFa+bEmi7ywHICMuB6sFfHEdG8/o+1wW7ll971ruRTr2Q6mfn+eroC/
         uafnBtkcOS3V7uyJLQ/KbNIDpe/q7N5ppU0FEA9bsRoKVV1ExGctZirlWSmkmWPvriv4
         CyWXliJ7jUG9M07W5O7xZ29orkD6e108G0cPwArvp0hOXiPoqygAhXDuv1TQK2jCCYI4
         Gwwko5VkhE7+4APl088N6x9utS1o9fVltFbuxil0ORdKxT6HnnzEASItsgfh25EDesSl
         1Nfw==
X-Received: by 10.68.223.230 with SMTP id qx6mr7156355pbc.159.1358377097683;
        Wed, 16 Jan 2013 14:58:17 -0800 (PST)
Received: from [10.3.46.124] (mobile-166-137-218-055.mycingular.net. [166.137.218.55])
        by mx.google.com with ESMTPS id c2sm13753397pay.34.2013.01.16.14.58.15
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Jan 2013 14:58:16 -0800 (PST)
In-Reply-To: <20130116233744.7d0775eaec98ce154a9de180@domain007.com>
X-Mailer: iPhone Mail (10A551)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213819>


>>>> Ideally we'd prefer to simply create our remote repository on a
>>>> drive of one of our local network servers. Is this possible?
>>> 
>>> Yes, this is possible, but it's not advised to keep such a
>>> "reference" repository on an exported networked drive for a number
>>> of reasons (both performance and bug-free operation).
>> 
>> I agree that performance is not ideal (although if you are on a fast
>> LAN, it probably would not matter much), but I do not recall any
>> specific bugs in that area. Can you elaborate?
> 
> This one [1] for instance.  I also recall seing people having other
> "mystical" problems with setups like this so I somehow developed an idea
> than having a repository on a networked drive is asking for troubles.
> Of course, if there are happy users of such setups, I would be glad to
> hear as my precautions might well be unfounded for the recent versions
> of Git.
> 
> 1. http://code.google.com/p/msysgit/issues/detail?id=130

A group I was with used a master repository on a windows share for quite some time without a database corruption being seen.   