From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: FAQ Q: another version control system?
Date: Thu, 3 May 2007 10:04:28 +1200
Message-ID: <46a038f90705021504i4d362c8amd233580bdff81223@mail.gmail.com>
References: <9e7886190705020012n72070874nae5a74b6d1387e3@mail.gmail.com>
	 <9e7886190705020013k5721480aj767c1c8643fc8d23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter <petervanbohning@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 03 00:05:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjMwX-0004j9-TS
	for gcvg-git@gmane.org; Thu, 03 May 2007 00:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993181AbXEBWEa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 18:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993180AbXEBWEa
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 18:04:30 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:63984 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993181AbXEBWE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 18:04:29 -0400
Received: by wx-out-0506.google.com with SMTP id h31so266214wxd
        for <git@vger.kernel.org>; Wed, 02 May 2007 15:04:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AUeqrrH7QtcdO4kM58g1agWZB8P7vSxCg40WrSO8hVn/93VTYZ2ryhVSZ/yWL/MLJs8G7CHj4gBPVXtTSSA/pkUm5aoZYzdRf+r3q+9PmE3uXjb7S3BGbZGQTYmb1nABpfFV0TPKmw8YpKWI9LL02F0hxixO7CmPAtG59uciI5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ND/398ent8ydTK5MmchJnuEFYKLI2SwUSQKV5fPJqxxKeAIMZeowLvIBu7gVWEMlXuoPvphT/EI/9Yniw2e+Am6CYhE+S+spBSpK3c9EoQNNkNXfNj27T0xlY6nsgkxfZu6+wNLYskCcbEglmW5f31LMB1h5krWm0/zbSxdEWj8=
Received: by 10.90.115.4 with SMTP id n4mr1245868agc.1178143468863;
        Wed, 02 May 2007 15:04:28 -0700 (PDT)
Received: by 10.90.75.15 with HTTP; Wed, 2 May 2007 15:04:28 -0700 (PDT)
In-Reply-To: <9e7886190705020013k5721480aj767c1c8643fc8d23@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46049>

On 5/2/07, Peter <petervanbohning@gmail.com> wrote:
> But why isn't such a feature set added into SVN?  Why do I have to
> download another version control system just so that I can "git"
> libxcb and X11 so that I can compile gtk so that I can compile xchat

If you are just a user trying to get a development version of libxcb,
I am sure that you can download a snapshot -- if the project doesn't
offer them formally, it'll probably have a "gitweb" thingy to browse
the development history online that also allows you to download a
snapshot. If it's really x.org they _definitely_ have gitweb (just
like viewsvn or viewcvs). No need to get git.

If you are a developer, git knows a lot of tricks that svn/cvs don't,
things that change how a large and broad project is developed. Lots of
people find it worthwhile, so chances are there'll be a payoff to the
pain of learning it. :-)

cheers,


martin
