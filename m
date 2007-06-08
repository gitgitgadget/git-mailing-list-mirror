From: "Benjamin Sergeant" <bsergean@gmail.com>
Subject: Re: git-p4 fails when cloning a p4 depo.
Date: Fri, 8 Jun 2007 15:25:14 -0700
Message-ID: <1621f9fa0706081525n64e5d3a3i6379030e1f619ef0@mail.gmail.com>
References: <1621f9fa0706080941k67d2878dud8cf06436c67aea0@mail.gmail.com>
	 <1621f9fa0706081113w7bb765ebx74f03a7407b753cb@mail.gmail.com>
	 <4669CAB4.5080507@slamb.org> <4669CB75.7060009@slamb.org>
	 <1621f9fa0706081504l6106c639oe57c9fd74ebd097a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Scott Lamb" <slamb@slamb.org>
X-From: git-owner@vger.kernel.org Sat Jun 09 00:25:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwmtr-0004AW-Ln
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 00:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S970379AbXFHWZU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 18:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968100AbXFHWZS
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 18:25:18 -0400
Received: from nz-out-0506.google.com ([64.233.162.227]:6735 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968972AbXFHWZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 18:25:16 -0400
Received: by nz-out-0506.google.com with SMTP id n1so870349nzf
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 15:25:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NlQvj2peSALaqoLqFujpGHjZ8ib6b/9MhSGGG+ctwABQHsMRzAGPqtM5HFR3gRUhBKHEfVW/RK29KPiU7TGxQ40+w30HkJy0JLg5583KIXiNAkwxbjE2WxJNlSRrTOxWJ0kpDzqUL+vcdL/SEKvQDJTVh05ifB0+ZEYSs9Uk55s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZlKbxAsbjLHjj3F/iSBzI3V5bXyt97zqq57s/wlzWYGOQMqeJi9oqGD6oHg04zIhM1uTFJn9HdfjA4p6b9A+v4xmEJXV29oIeFGWmUbycTmH2274jYW7QxdwKTcZ0/dyhskOx/bjZwu7s9gy43c53aCkO5nrVJgy5MhCHRI1sOI=
Received: by 10.142.115.10 with SMTP id n10mr173087wfc.1181341514673;
        Fri, 08 Jun 2007 15:25:14 -0700 (PDT)
Received: by 10.143.43.1 with HTTP; Fri, 8 Jun 2007 15:25:14 -0700 (PDT)
In-Reply-To: <1621f9fa0706081504l6106c639oe57c9fd74ebd097a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49512>

I got my git-p4 from here BTW.
http://repo.or.cz/w/fast-export.git

On 6/8/07, Benjamin Sergeant <bsergean@gmail.com> wrote:
> On 6/8/07, Scott Lamb <slamb@slamb.org> wrote:
> > Scott Lamb wrote:
> > > No need to hardcode - from Python this is
> > > os.sysconf(os.sysconf_names['SC_ARG_MAX'])
> >
> > In fact, just os.sysconf('SC_ARG_MAX') will do.
> >
>
> magic number are lot of fun, why would you want to use the clean method :)
>
> So are you saying that in the old days, git-p4 was importing the p4
> depo in small slices to not overkill the process memory (in case the
> depo is big) ?
>
> BTW, there is the whole universe in my depot, so using -//Work/Users
> in my client specification I usually manage to have less megs of code
> on my disk after a sync.
> This way the git-p4 clone would not use too much memory. But we would
> have to change the way git-p4 works, it should be able to read a full
> client view instead of just a single perforce path.
>
> Would you give me the git command to fetch the up
> git clone <git-url> --date <the good date> ?
>
> Thanks,
> Benjamin.
>
