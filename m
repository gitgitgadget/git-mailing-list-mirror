From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-cvsservr questions
Date: Thu, 8 Jun 2006 17:23:25 +1200
Message-ID: <46a038f90606072223v450a3c57m16482b20f5088462@mail.gmail.com>
References: <E1FoCCg-0002vH-FX@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 08 07:23:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoCzb-0005uN-Bo
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 07:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWFHFX0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 01:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWFHFX0
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 01:23:26 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:51517 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750847AbWFHFX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 01:23:26 -0400
Received: by wr-out-0506.google.com with SMTP id i20so341118wra
        for <git@vger.kernel.org>; Wed, 07 Jun 2006 22:23:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OosLoVOFBnptXxidNBZVfKskJ+KQ1aYlLnGit01V1Z8bfQWnrJJ54PZz5JoaeJAmBN+AxPD7nYVQeiVgl8DfHBmu7UolmpDM+Xs+lDCw/lDjWrED8Ab66jW1Fpq6hwmyLjZ0NrURWg/ZkhUOFwMjmkhRLCIWBZlczLKmiKS1eYs=
Received: by 10.54.86.13 with SMTP id j13mr47877wrb;
        Wed, 07 Jun 2006 22:22:57 -0700 (PDT)
Received: by 10.54.71.4 with HTTP; Wed, 7 Jun 2006 22:23:25 -0700 (PDT)
To: "Jon Loeliger" <jdl@jdl.com>
In-Reply-To: <E1FoCCg-0002vH-FX@jdl.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21471>

On 6/8/06, Jon Loeliger <jdl@jdl.com> wrote:
> Mart{i,y}n et al,
>
> I'm having a bit of a problem setting up my git-cvsserver.
> I think I have followed the man page, but this is the
> only real response I get:
>
>     $ setenv CVSROOT :pserver:anonymous@jdl.com:/pub/..../foo.git
>     $ cvs co master cvs [checkout aborted]: unrecognized auth response
>       from jdl.com: Unknown command BEGIN AUTH REQUEST at
>       /usr/bin/git-cvsserver line 132, <STDIN> line 1.
...

> I have enabled it the config file, and set a log file

Very strange. The calling line to git-cvsserver should have the
'pserver' option. Perhaps the inetd configuration is missing the
doubled-up pserver?

cheers,



martin
