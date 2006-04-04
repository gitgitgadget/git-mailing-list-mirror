From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: parsecvs tool now creates git repositories
Date: Tue, 4 Apr 2006 14:42:43 +1200
Message-ID: <46a038f90604031942w779894b8p5ef221482a70a301@mail.gmail.com>
References: <1143956188.2303.39.camel@neko.keithp.com>
	 <46a038f90604031538x3c94d86ap9f1400427513a3a7@mail.gmail.com>
	 <1144116459.2303.129.camel@neko.keithp.com>
	 <46a038f90604031916r4651b572lb9bae4c5a3d47bc9@mail.gmail.com>
	 <1144117473.2303.132.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 04 04:42:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQbVH-0007mX-5r
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 04:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWDDCmo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 22:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWDDCmo
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 22:42:44 -0400
Received: from wproxy.gmail.com ([64.233.184.235]:47662 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964971AbWDDCmn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 22:42:43 -0400
Received: by wproxy.gmail.com with SMTP id i22so1405893wra
        for <git@vger.kernel.org>; Mon, 03 Apr 2006 19:42:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fJJ1y5pTvuVFPdAID1GbZbxszzCkZ+Jv/8iWQx148Pl2iMqGkQKoRKKRHOpwGni3Mkk/+dC+C1Ka4nWBmW7nCHGNWByxlzlm85BbF5eLBMPAZlc7dYG6paed5teDfrDYGpGHy0RewPV5V5dvpUlkcHl6d3yUfjm4SgDyRCNPhts=
Received: by 10.54.72.9 with SMTP id u9mr1385200wra;
        Mon, 03 Apr 2006 19:42:43 -0700 (PDT)
Received: by 10.54.72.7 with HTTP; Mon, 3 Apr 2006 19:42:43 -0700 (PDT)
To: "Keith Packard" <keithp@keithp.com>
In-Reply-To: <1144117473.2303.132.camel@neko.keithp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18373>

On 4/4/06, Keith Packard <keithp@keithp.com> wrote:
> On Tue, 2006-04-04 at 14:16 +1200, Martin Langhoff wrote:
>
> > Meh, had you done it in Perl, I'd be helping you with the Pg repo,
> > attic files and ensuring that files created on a branch and then put
> > into HEAD are handled gracefully. (But you'll get Linus' and Junio's
> > attention. Smarty cookie.)
>
> I think those parts are working correctly, I've had plenty of examples
> of that kind of adventure.

Cool. What's the matter with the Pg repo? (Where can I get hold of that repo?)

> > Does it run incrementally? Can it discover non-binary files and pass -kk?
>
> It doesn't run incrementally, and it unconditionally passes -kk. It's

I thought that the .git-cvs directory it created was to be able to run
incrementally (btw, I think it's fair game to create subdirs inside
.git for this kind of status-tracking). And passing -kk uncoditionally
is destructive in some cases (I know... git-cvsimport does it, and I
want to fix that). If you can ask rcs about the mode if the file and
not pass -kk for binary files...

> currently using rcs to check out versions of the files, so it should
> deal with binary content as well as rcs does. Is there something magic I
> need to do here? Like for DOS?

We'll let DOS take care of itself ;)



m
