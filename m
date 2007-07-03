From: "Dongsheng Song" <dongsheng.song@gmail.com>
Subject: Re: Can git-svn treat specify paths as branches ?
Date: Tue, 3 Jul 2007 22:11:55 +0800
Message-ID: <4b3406f0707030711i3ba973b2m44696214f61cbbc8@mail.gmail.com>
References: <4b3406f0707030212h1e029023sf74c5c7b0e95654b@mail.gmail.com>
	 <1183467196.3868.1.camel@lt21223.campus.dmacc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeffrey C. Ollie" <jeff@ocjtech.us>
X-From: git-owner@vger.kernel.org Tue Jul 03 16:12:04 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5j6l-0002YO-Pm
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 16:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327AbXGCOL4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 10:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755143AbXGCOL4
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 10:11:56 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:58840 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753812AbXGCOL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 10:11:56 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1803517wxd
        for <git@vger.kernel.org>; Tue, 03 Jul 2007 07:11:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F9YVD8VRthb7cFHJhqnfDDCNxUs699CEGQe9p4mNVteaHJMg6zWnFa8+XytVvym/2ZutAGP/ct6euDzY2YdBvaflWshGZCUHJu+VqwQcrXRrvS3diczERvU7XBDHzh/bbAWNGNiKeNfOF9Sw7/EmZI8YhkPv+pAyFT3fZgCNVPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VpRrCs6rQUbqYiY0eySX/gFDjk7wwPne15g+DFs5IgjwPdFdF1UP/+MdvHyk0LMoglaWPlhemjNY6Ttyavk6TX05HLHHmsSEMgZLEnw+6mRA/CWiH2kuH67wvmPnQXfsAkXLDexwfCkqr7mnSHkczWJTwVa2/6/4pHK1ivCKOQc=
Received: by 10.70.30.5 with SMTP id d5mr9313655wxd.1183471915311;
        Tue, 03 Jul 2007 07:11:55 -0700 (PDT)
Received: by 10.70.43.18 with HTTP; Tue, 3 Jul 2007 07:11:55 -0700 (PDT)
In-Reply-To: <1183467196.3868.1.camel@lt21223.campus.dmacc.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51496>

Thanks, it works.

2007/7/3, Jeffrey C. Ollie <jeff@ocjtech.us>:
> On Tue, 2007-07-03 at 17:12 +0800, Dongsheng Song wrote:
> > For google code projects, the repositories organized is:
> >
> > branches  tags  trunk  wiki
> >
> > Can I treat wiki as a branch? i.e.
> >
> > [svn-remote "svn"]
> >         url = http://serf.googlecode.com/svn
> >         fetch = trunk:refs/remotes/trunk
> >         branches = branches/*,wiki:refs/remotes/*
> >         tags = tags/*:refs/remotes/tags/*
>
> What's the structure underneath the wiki directory?  If it's just
> content, I'd use:
>
> fetch = wiki:refs/remotes/wiki
>
> Jeff
>
>
>
