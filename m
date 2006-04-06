From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: parsecvs tool now creates git repositories
Date: Fri, 7 Apr 2006 09:51:36 +1200
Message-ID: <46a038f90604061451m4522e3f3qceae2331751a307c@mail.gmail.com>
References: <20060405174247.GA29758@blackbean.org>
	 <1144262498.2303.231.camel@neko.keithp.com>
	 <20060406181502.GA15741@blackbean.org>
	 <1144354356.2303.270.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Jim Radford" <radford@blackbean.org>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 06 23:51:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRcOH-0006pB-FW
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 23:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWDFVvh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 17:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWDFVvh
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 17:51:37 -0400
Received: from wproxy.gmail.com ([64.233.184.237]:59588 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751273AbWDFVvh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 6 Apr 2006 17:51:37 -0400
Received: by wproxy.gmail.com with SMTP id 71so112808wra
        for <git@vger.kernel.org>; Thu, 06 Apr 2006 14:51:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d3Ioserx8ZuIE01NGkvYmgwrE/2/EX2VBM3VzUq0Qkap1Pb1IRZ6yFDkeDlNzSg0BjUVxi42+o16D8HeUTHsR/WePAVEgmVrluT4S69kKdpu7yyO44mJCzR03AUft4GrLm6C95DhPoCcDbkD/dxfZdezR8jS2QHQIQda6ryIHl8=
Received: by 10.54.84.17 with SMTP id h17mr1452567wrb;
        Thu, 06 Apr 2006 14:51:36 -0700 (PDT)
Received: by 10.54.72.7 with HTTP; Thu, 6 Apr 2006 14:51:36 -0700 (PDT)
To: "Keith Packard" <keithp@keithp.com>
In-Reply-To: <1144354356.2303.270.camel@neko.keithp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18483>

On 4/7/06, Keith Packard <keithp@keithp.com> wrote:
> > Almost all of the errors I was seeing in the last version were fixed
> > with your "branches that don't get merged back to the trunk" fix.
>
> That's good news at least.

I'm re-running my import of Moodle's cvs (20K commits) with the newer
parsecvs. The previous attempt looked very good except that

 - file additions were recorded with one-commit-per-file. I am not
sure how rcs is recording these, but hte user does enter a common
message at "commit" time. Perhaps the file addition action could be
ignored then?

 - some tags made on a branch show up in HEAD. This may be due to
partial-tree branches, but I am not sure.

cheers


m
