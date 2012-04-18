From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [GSoC] Git to SVN bridge
Date: Wed, 18 Apr 2012 15:10:50 -0500
Message-ID: <20120418201050.GB30625@burratino>
References: <CALkWK0=Mqo=PMv7+_sr22Dnm6xxzxzaXL=Zh+2LsvT=usC7csw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 22:11:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKbDR-00073Q-1M
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 22:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536Ab2DRUK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 16:10:56 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33702 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab2DRUK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 16:10:56 -0400
Received: by obbta14 with SMTP id ta14so7040158obb.19
        for <git@vger.kernel.org>; Wed, 18 Apr 2012 13:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=um4GJZx+JYpoJU5PbBdqTj7JblSg7MEwhBC3jTgo79s=;
        b=G87dqegOPuUTVItq1b72+1iUVZSsr9dkW2DLjskJNLOwxxq5WDZhJUKg0yXD9TUsz7
         ETR1LATu5aNJujLTPQlXV5P9SVBoD8ks0WqmGKL7zXBxGt2zTsbxDn4/4lSNXwfIdBnm
         GZvPMy+AsdlJz/iuYxI7Si6m/coHL1PkgmyigZvV/wFaOQNk5ljeQbNaaYMLrTgbqwjG
         Vq8TnDcJo9x+r7f+fbePGjEl8MK7WWXR1KWRfL4RqUkn7RfYtfoF1WRQmOEbfedgYj7U
         41TRZLBohsm+kNziArYQDJJR2FZyOB4RpnSyJjHI+ygRJjnVcWc6XbuTRrnuCmTXjTFc
         15Bg==
Received: by 10.182.36.3 with SMTP id m3mr5127607obj.8.1334779855539;
        Wed, 18 Apr 2012 13:10:55 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id d6sm22643418oeh.3.2012.04.18.13.10.53
        (version=SSLv3 cipher=OTHER);
        Wed, 18 Apr 2012 13:10:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=Mqo=PMv7+_sr22Dnm6xxzxzaXL=Zh+2LsvT=usC7csw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195895>

Hi Ram,

Ramkumar Ramachandra wrote:

> Note: This is intended to be a very short proposal because I'm already
> a regular Git contributor, and I have an incomplete version of what I
> intend to build [0].  This is not a good example of a proposal that
> the Git community expects from a new student.

Yeah, seriously. :)

For what it's worth, if you'd like to propose a plan for getting push
support in the svn remote helper to work (what the architecture would
be like, what milestones would be involved along the way, and so on),
then I would be happy to help flesh it out.  Even forgetting about the
summer of code and setting a good example, I imagine such design
documents could be useful for developers and reviewers working on the
project to avoid getting lost.

Thanks,
Jonathan
