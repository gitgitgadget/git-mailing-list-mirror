From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] git-cvsimport-script: handling of tags
Date: Wed, 7 Sep 2005 09:21:24 +1200
Message-ID: <46a038f905090614216eca87eb@mail.gmail.com>
References: <431DD381.4050709@zytor.com> <431DE640.8050901@zytor.com>
	 <431DFB04.5020701@zytor.com>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Sep 06 23:23:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECkso-0005MO-Jb
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 23:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbVIFVVb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 17:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbVIFVVb
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 17:21:31 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:49108 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750966AbVIFVVa convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Sep 2005 17:21:30 -0400
Received: by rproxy.gmail.com with SMTP id i8so902212rne
        for <git@vger.kernel.org>; Tue, 06 Sep 2005 14:21:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b4eVp6ILzqDbGVDNCcLDmDATLU+NNlv3TQeQ287tP6xXVvCjt7RFvOKmj+8HHKTusUbAXrpEywVe8EjdlWFwkzW1QrL57RqEY3EyivZ8Shg0OqPbHyEO9r/Cnjv1hNykBrzlRcyuCTG7GfemgJ5IX3UavWSby2AeF/u6x8Ay7Gw=
Received: by 10.38.88.56 with SMTP id l56mr1275192rnb;
        Tue, 06 Sep 2005 14:21:24 -0700 (PDT)
Received: by 10.38.101.53 with HTTP; Tue, 6 Sep 2005 14:21:24 -0700 (PDT)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <431DFB04.5020701@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8148>

On 9/7/05, H. Peter Anvin <hpa@zytor.com> wrote:
> > I should probably point out that there are still bugs in
> > git-cvsimport-script; for one thing, it seems to fail to register a tag
> > associated with the head, and I have yet to get the "recognize merge"
> > feature to actually work.  It's also possible -- but I haven't verified
> > it -- that two tags which are aliases may not be properly registered.
> I just verified this; git-cvsimport-script will not handle more than one
> tag per commit.

Tell me more about how you are trying the 'recognize merge'. It is a
pretty unsophisticated thing, as it trusts the commit message in the
first place. But when it works, it works.

I have a more refined merge detection already working in the Arch
imports -- patch coming soon -- but with cvs it is pretty hard to do.

cheers,


martin
