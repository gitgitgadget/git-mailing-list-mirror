From: "Ben Williamson" <benw@pobox.com>
Subject: Re: git-svn: Missing files
Date: Thu, 20 Jul 2006 14:31:54 +1000
Message-ID: <b6327a230607192131x2623af69jf1f47d5e43e52023@mail.gmail.com>
References: <b6327a230607191902n47b81993x8caea2df3955d8c0@mail.gmail.com>
	 <b6327a230607191909tf48c4f8nc551b732523cca3e@mail.gmail.com>
	 <20060720024815.GC31763@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 20 06:32:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3QD0-0004CN-5E
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 06:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWGTEb4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Jul 2006 00:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWGTEb4
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Jul 2006 00:31:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:32009 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932566AbWGTEbz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jul 2006 00:31:55 -0400
Received: by nf-out-0910.google.com with SMTP id n29so486102nfc
        for <git@vger.kernel.org>; Wed, 19 Jul 2006 21:31:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=M8Qz1MutmwJTWPW3yBCRNKXbAM+swcfp3ZGqfMDg3jVCCFz1mhIzd1qiYVpLrc3iANALjFIwTxoQlI06K/Qq0vd5Qn7iIsQIZKPJqDuNPfQ10t4/OVlFCJ8KjMviZ916SzvJU+YTb1QO5upCc4s79eVOKGSQzUpuF8ZgxV9k+YU=
Received: by 10.78.158.11 with SMTP id g11mr88963hue;
        Wed, 19 Jul 2006 21:31:54 -0700 (PDT)
Received: by 10.78.126.12 with HTTP; Wed, 19 Jul 2006 21:31:54 -0700 (PDT)
To: "Eric Wong" <normalperson@yhbt.net>
In-Reply-To: <20060720024815.GC31763@localdomain>
Content-Disposition: inline
X-Google-Sender-Auth: 443b0fd072285ea2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24018>

Wow, I just got back from lunch to three replies and a patch! I'll try
to keep up here...

On 7/20/06, Eric Wong <normalperson@yhbt.net> wrote:
> May I ask if you have the Perl SVN:: library bindings installed?  If so
> 1.1.1-broken (and all versions afterwards) will automatically. use them
> (if the SVN library version is >= 1.1).

Yes I have Perl SVN:: installed, because I started off trying
git-svnimport. (Most of my attempts there resulted in lots of commits
of the same empty tree, until someone else on this list mentioned that
"trunk/projectname" should be removed from the url. Then it started
working, but it seems to be a large repo and was taking forever, so I
tried git-svn.) I didn't realise git-svn didn't need the Perl stuff.

$ rpm -qa | grep subversion
subversion-1.2.1-0.1.1.fc3.rf
subversion-perl-1.2.1-0.1.1.fc3.rf

> Nevertheless, I'm running an import right now (with the SVN:: libraries enabled)
> and will make another run with them disabled (which is kind of slow).
> I'll keep you posted...

Me too, with your latest script - will let you know. Thanks!

- Ben.
