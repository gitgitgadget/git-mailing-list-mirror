From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: 'git log' numbering commits?
Date: Thu, 12 Apr 2012 20:14:15 +0200
Message-ID: <CAGK7Mr4kPp+vTM2OrQ3MqcnGy3KsXj9yr1BThm57jrUqk-46Yg@mail.gmail.com>
References: <4F868A24.9090004@monom.org> <20120412084122.GG31122@sigill.intra.peff.net>
 <4F869D4C.8090108@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Daniel Wagner <wagi@monom.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 20:14:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIOXj-0002Dn-Mz
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 20:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933248Ab2DLSOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 14:14:47 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50766 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757926Ab2DLSOq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 14:14:46 -0400
Received: by yhmm54 with SMTP id m54so1250794yhm.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 11:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CxhG4xiEVxq0r1wTi8G975wjaaUq5yJ3/mkQQQXYqbQ=;
        b=xeinBIXQc82xp7ZmuMRc9B6ANLU42UwISFqSHnW/3quaxIoSYqUQ+7bdrSFFgOZrYH
         4EFdJTCLCNUCPlNeAzMgePz7mgjPQmkeu4vGpq56s+2VVpaD0OTReopB8mMoPMoev3L1
         o7vnCZfBdgyqFlrv43YloJqWrn7Hi6UdD06hu6oYsw3x0Di3+3/+1rqv4fFgw5ZWukWI
         jBH0c0sG7RNZqxVZi+bxVRV36hDoEepFFxS2igkYhzviilesdgbBje2tY1Byt7aoK08E
         zyGSAbRroDHClhAVZErYTs7/05dQ4NQfuVY50JmSflbqhpAFqgzTHjvEQVQ0ySsrlnHM
         Gvow==
Received: by 10.50.154.167 with SMTP id vp7mr3549959igb.55.1334254485792; Thu,
 12 Apr 2012 11:14:45 -0700 (PDT)
Received: by 10.50.65.101 with HTTP; Thu, 12 Apr 2012 11:14:15 -0700 (PDT)
In-Reply-To: <4F869D4C.8090108@monom.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195352>

> I am using git trunk :) I'll try the @{upstream} trick.

Not sure if it helps, but I use something that is somewhat easier to
remember for me (specifying the upstream manualy):

git rebase -i origin/master

Philippe
