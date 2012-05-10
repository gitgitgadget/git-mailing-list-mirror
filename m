From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git.pm
Date: Thu, 10 May 2012 10:16:50 -0500
Message-ID: <20120510151650.GA6591@burratino>
References: <CAB3zAY3-Bn86bCr7Rxqi4vxbYFxUesLwm8gddxyMSexov2tOhw@mail.gmail.com>
 <CAFouetgwRpB1GFJOC8PTVryVY-94S3xa5ZiSaWQWoz070qQ-6g@mail.gmail.com>
 <CAB3zAY0NeXuH-wXyYkbim5U74eANY4hq5D6SsVLu3KeUqHFqzQ@mail.gmail.com>
 <20120426203136.GA15432@burratino>
 <CAB3zAY3VHtUobJfJ7=nSKb_6uJOXLGVHzR18qV6txPkzf54cDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Henigan <tim.henigan@gmail.com>, git <git@vger.kernel.org>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
To: Subho Banerjee <subs.zero@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 17:22:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSVCP-00018V-9b
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 17:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760011Ab2EJPWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 11:22:32 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64958 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759932Ab2EJPWa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 11:22:30 -0400
Received: by eaaq12 with SMTP id q12so611311eaa.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 08:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=YwN9LAaxcVb8X/SOxcOwS88riY9WWLOlScMVou+dXLE=;
        b=RUzHItnW4CcAdPMtVTtSU3t6pp4HwGRmL+17ehmkfHQOMs3LsauepWx0a0nwlzvcyO
         lJP9jxcclqG0T6ANTwPNU3TZLHq0bUJttilVMgBNURYM0uVZozUb+E3oe4Kh7zWXf9yI
         9zJE50bf+BjjHw6azQ52YN4quCLpt8uI5LLKEV8/zmS8SNtbTdUPdT89RO/Lq45fIPKU
         +B3lVOUNnQFXd8EtxvgHfkcg57XgCWSQO5wGArKjSvcvmEgIR99wlpOJ9tCLhUOPOEGz
         VbqsF1wTPaulWJ4ZQSRBkDTVH4ecIqv/aSnkDhwgq8iAquEwBHda25V0Z/n5nlnnnjAa
         NEFQ==
Received: by 10.50.94.163 with SMTP id dd3mr2739903igb.8.1336663022222;
        Thu, 10 May 2012 08:17:02 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id cg9sm2054155igb.17.2012.05.10.08.16.59
        (version=SSLv3 cipher=OTHER);
        Thu, 10 May 2012 08:17:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAB3zAY3VHtUobJfJ7=nSKb_6uJOXLGVHzR18qV6txPkzf54cDw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197580>

Hi Subho,

Subho Banerjee wrote:

> I have started looking into how the error catching mechanism
> implemented right now. I have looked into the more modern error
> catching/throwing mechanisms in use in perl, and
[...]
> This I believe is a big decision, and I would like to hear what you
> guys have to say before I actually get along changing and playing
> around with stuff inside the code.

I'm cc-ing Jakub in case he has thoughts on this.  Otherwise, my
suggestion would be to make a small trial change and send out a
patch to get feedback.  It's not a big decision until we actually
apply the patch. :)

Hope that helps,
Jonathan
