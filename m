From: Deon George <deon.george@gmail.com>
Subject: Re: Feature Enhancement Idea.
Date: Thu, 24 Sep 2009 19:25:34 +1000
Message-ID: <5b5e291e0909240225q49a202abk7cf1a0c8f715ad5f@mail.gmail.com>
References: <5b5e291e0909222317q47ae36d4la470f17ec3902124@mail.gmail.com>
	 <m3bpl0c2cf.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 24 11:27:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mqka7-000147-CS
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 11:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774AbZIXJZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 05:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752434AbZIXJZd
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 05:25:33 -0400
Received: from mail-px0-f194.google.com ([209.85.216.194]:47738 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbZIXJZd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 05:25:33 -0400
Received: by pxi32 with SMTP id 32so1489037pxi.4
        for <git@vger.kernel.org>; Thu, 24 Sep 2009 02:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=wPqGM9nLeIhwOZNMJTUbc50b6p1Hq+iUBAMzYqRCUSA=;
        b=LbtuZGJyNQ0Nt803AnP3JQxZ8DzYah0e/xwMWCS/3f+DJJQFsieE9GfXL7MjK5yGvp
         +UErYmqp809Mv4u6JzCtBZq9GYU5ZCAcz2iEytoXjnfJWnbLyn7GZ8yARCzPdkqC6vVe
         Z8wh6yPuVKHHI+ZzgrWg1qvICc+0n7rICBDpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Yb1PbAF06DNYxFJalif4/Ib0AmrvEFi59QiD/T0Ub2Y2Ljc6ZC5mccNUuST5btdkXu
         pVIFcO1k+cTzbNddFzkq4ugKlXhLwk8YAhygBQPGNV96fVTIHW5yS6OCgFqpK9vhQGBt
         WlxKgZRN27SobGSJCV44MQ82xZ8RxdWZE4vOU=
Received: by 10.140.188.15 with SMTP id l15mr197029rvf.119.1253784334907; Thu, 
	24 Sep 2009 02:25:34 -0700 (PDT)
In-Reply-To: <m3bpl0c2cf.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129034>

Jakub Narebski wrote:

> First, I assume there that you do not allow for the same file to
> belong to different repositories.

Well, no, I cant see why a file cannot belong to both repositories.
I'm sure it would be easier if a file did belong to a unique
repository, but given that GIT operates at a content layer (from what
I've read anyway), I cant see why it couldnt belong to more than one.

> you can try either submodules
> (git-submodule), or subtree (subtree merge, or third-party git-subtree
> helper).

I had a quick look at submodule - I dont think it helps me anyway,
since I want the flexibility for files to belong to many
sub-directories - not all under 1 sub directory hierarchy.

> Third, if the above isn't what you want, then you can manually
> intermingle working directories of different git repositories
> (probably requiring decouplig of bare git repository (git-dir)
> from working area (work-tree)).

Ahh, now this sounds like it might be what I want to do - I think I'll
explore this. I can see that it would provide file level autonomy
only, but as a starting point I think it will help heaps...

I'll work on it as time permits and come up with some scripts to
provide what I am after (need to learn more on the workings of GIT
first - everyday I learn a new feature :)

Thanks for your idea...

...deon
