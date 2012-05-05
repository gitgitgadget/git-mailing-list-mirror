From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Jonathan gives feedback --> flamewars inevitable?
Date: Sat, 5 May 2012 13:39:54 -0500
Message-ID: <20120505183954.GA18844@burratino>
References: <1336231400-6878-1-git-send-email-felipe.contreras@gmail.com>
 <20120505155423.GA14684@burratino>
 <CAMP44s1dhAjKt3mxVmg2+0qp-QTyjYb1knhxf+m177Cg2ZBC1Q@mail.gmail.com>
 <20120505164736.GC14684@burratino>
 <CAMP44s2NRMxuvQXk4RyqFYR=oQw_vrJhmbdwtXsrg=eHhGBS2w@mail.gmail.com>
 <20120505173327.GE14684@burratino>
 <CAMP44s1SLb6CXMKxRDFUbxkg56dU3=ObZPZh7XxQC3vovNnvdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 20:40:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQjtr-0004m5-2e
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 20:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756484Ab2EESkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 14:40:04 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38932 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756427Ab2EESkD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 14:40:03 -0400
Received: by obbtb18 with SMTP id tb18so5770613obb.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 11:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fk/80EzfzDqnEiP1GAykbE6CpXWudXSBlNh2lYeexZo=;
        b=e6Q5kMhNxTItWmrlbyEnZl7L/WHIW/zJtDpyQwuOVbucymvjJ6jWTbtdXNgfUWuAiX
         +f9g6OowJRIhesdJ7FbDdhfDwSIQMN+VDWaAdDRDuuF/Yt6UBIgYKl295oLpAtW2UQFJ
         rQx+GLGKWU5WxBoysT8J6hju0ZhC7IP2w8LXVN0cjyo1xCJp/tfSnKqh/q16lKCbxycv
         nzoacB3sw4NMwXyfafXP1z+zu1O6pcB2GBAXxrMpW+7hcGi5WjP73hYM/Sx6oZsdxqa0
         YqAlW7GOLZxmSimUvAApVK5LATdcnR6uWbmgcdfMQsSDg01eWDGcpHvIoj2gWfzTjgLI
         rRCg==
Received: by 10.50.154.169 with SMTP id vp9mr5353500igb.53.1336243202829;
        Sat, 05 May 2012 11:40:02 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gj10sm2127633igc.9.2012.05.05.11.40.01
        (version=SSLv3 cipher=OTHER);
        Sat, 05 May 2012 11:40:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s1SLb6CXMKxRDFUbxkg56dU3=ObZPZh7XxQC3vovNnvdw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197133>

Felipe Contreras wrote:

> If you had said "You know, I think they have this guideline, but it's
> not really relevant, what is relevant is X" right when the topic of
> bash-completion guidelines popped up, this thread would have looked
> much different.

Ah, apparently I was still unclear.

The leading underscore is a convention.  They do use it.  They are
thinking of moving to another convention and will probably do so.

I believe that convention is relevant to the git completion script.
Not because we should blindly follow everything the bash-completion
project does, but because there are reasons behind that convention,
following common practices means our behavior is less surprising, and
in fact I do want it to be possible to incorporate git's completion
script in the bash-completion project if that's convenient.

A little changed because their proposed future namespace does not make
it possible for outside contributors to make unofficial extensions and
then include them as something official later without change.  Maybe
that's a flaw.

When I stated what I thought was (and still think is) a fact, and you
decided that the best use of your time was to argue with me about that
instead of talking about the consequences, yes, I was annoyed.  It was
a rabbit hole I shouldn't have followed; you're right.  But I still
don't know what I should have said instead, or how to stop it from
coming up again and again.

Jonathan
