From: "Michal Rokos" <michal.rokos@gmail.com>
Subject: Re: index-pack died on pread
Date: Wed, 25 Jul 2007 22:07:50 +0200
Message-ID: <333e1ca10707251307k21b5f58bjb8e5803173e3d9b3@mail.gmail.com>
References: <333e1ca10707230552i34c2a1cfq9fae94f20023e9d7@mail.gmail.com>
	 <81b0412b0707230832w438613d0rdaa8dc97013962a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 22:07:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDn9H-0000pE-2r
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 22:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbXGYUHw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 16:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbXGYUHw
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 16:07:52 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:16262 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbXGYUHv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 16:07:51 -0400
Received: by wa-out-1112.google.com with SMTP id v27so334800wah
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 13:07:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ePGrDaQv/8CqDWjfBBVCvllyreKE2EcxwkAh8lYEu4yzA1xbqlpmL/8MKD0kBoVLPu08ZR/rt6dYQ6Byr/7Z/JiXz6U46cfxaXJ6wIHpu2mMxSrUS99HYa1DH8WETXUCOTISjIV5awX9TwaY8vUMwVg4+581nucTZgrLl2KTxRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KFMwdeo9hSLA4aTcAUM9JbOYIKHKcxyXEStcx/BpqopEo/aROP8ACL9Fu4uNhmY/ZrOmhtkhHu7XvVGRbXDLbdjTcO4/HaboQvyhl7MAbpmHWWIAYw761wrQyLUeg/kaubMpu/3qmELJlCpZgj2A5G24yVpZXwcWYuHQ304d/+A=
Received: by 10.115.111.1 with SMTP id o1mr977139wam.1185394070621;
        Wed, 25 Jul 2007 13:07:50 -0700 (PDT)
Received: by 10.114.150.6 with HTTP; Wed, 25 Jul 2007 13:07:50 -0700 (PDT)
In-Reply-To: <81b0412b0707230832w438613d0rdaa8dc97013962a6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53712>

Alex,

On 7/23/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 7/23/07, Michal Rokos <michal.rokos@gmail.com> wrote:
> > fatal: cannot pread pack file: No such file or directory (n=0,
> > errno=2, fd=3, ptr=40452958, len=428, rdy=0, off=123601)
> > fatal: index-pack died with error code 128
>
> strange. pread(2) should not return ENOENT. Not in HP-UX
> not anywhere.
>
> Could you recompile with NO_PREAD=1 and try again?
> Maybe HP-UX pread(2) implementation is just broken.

When I tried to recompile with NO_PREAD=1 the problem disappeared.

Do you want me to try something more with it?

Michal
