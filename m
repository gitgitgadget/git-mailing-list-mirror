From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch, not .txt
Date: Thu, 18 Jan 2007 15:41:39 +0100
Message-ID: <81b0412b0701180641v55987657t331d6a1868dabee0@mail.gmail.com>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
	 <625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com>
	 <7vsle9p8pg.fsf@assigned-by-dhcp.cox.net>
	 <7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net>
	 <81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com>
	 <7v64b4ohcj.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0701180135r505a75a5j172c70792d6569c0@mail.gmail.com>
	 <625fc13d0701180352m151cceb3lf9c00b6cf0ae937b@mail.gmail.com>
	 <81b0412b0701180540x15d20453s3dbc0c061fd06d50@mail.gmail.com>
	 <45AF7FE8.5060003@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Josh Boyer" <jwboyer@gmail.com>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	davidk@lysator.liu.se
X-From: git-owner@vger.kernel.org Thu Jan 18 15:41:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7YSV-0006rY-TC
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 15:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbXAROlm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 09:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752046AbXAROlm
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 09:41:42 -0500
Received: from wr-out-0506.google.com ([64.233.184.225]:50911 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbXAROll (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 09:41:41 -0500
Received: by wr-out-0506.google.com with SMTP id i22so175370wra
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 06:41:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HjMmbSkQLQoiBpkh0al6FjTaje942+pCkudhQ3mw+k+Lx0l7y0VmrARdXTsNBnWO/D/oo+Rdu6FNFkyo0JSL9wgVWXowy8Akc2GBZVKqWtSZ4XbVwohAdwHgrnvv2wnT/rCflkfUX5DLR0gLzFtRIbwob+zQ+s6prkE9jB3rH04=
Received: by 10.78.50.5 with SMTP id x5mr837527hux.1169131299944;
        Thu, 18 Jan 2007 06:41:39 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 18 Jan 2007 06:41:39 -0800 (PST)
To: "Andreas Ericsson" <ae@op5.se>
In-Reply-To: <45AF7FE8.5060003@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37096>

On 1/18/07, Andreas Ericsson <ae@op5.se> wrote:
> Alex Riesen wrote:
> > On 1/18/07, Josh Boyer <jwboyer@gmail.com> wrote:
> >> > As much as like Unix and everything related, I think it is
> >> > not reasonable to try to change the majority. Not unless
> >> > we have something earth-shattering. Well, git is, but
> >> > 0001-fix....patch in email attachment probably not.
> >>
> >> I would venture to say that the _majority_ of git users are not using
> >> Windows.
> >
> > The _real_ majority of the programmers desperately need a better
> > VCS than CVS, SVN, Perforce, SourceSafe, ClearCase, etc.
>
> They're free to use git ofcourse, provided they install cygwin or help
> migrate it to run natively on windows. I don't think anyone would cry if

My example had cygwin installed for him. Is it too unusual?

> a competent cross-platform programmer stepped up and started submitting
> patches to get git working on windows without having to resort to the
> cygwin emulation layer.

don't think so. I _would_ cry seeing how fork(2) gets ported to Windows,
and you will, probably... after seeing how it is done in cygwin.

> The thing is, no-one's getting paid for it, so until someone *does* step
> up, it won't happen, as 95% of the *current* git users are still running
> what we on this list will indefinitely refer to as "a sane OS".

95% of the current users probably is not even 1% of all programmers
who would gladly use it and maybe less than a fraction of percent of
the ones who need it.

> > People often understand "funny ways" the others may have. They
> > don't like been told they are wrong or stupid (especially when they
> > actually are stupid).
>
> I still don't see the problem. When he understands (and uses) git, the

he does not use git. He knows what the patch is (now I have explained
it to him), I suppose he would still be mildly surprised seeing a file.patch,
but he'll probably recover.

> name and look of the patch will become blindingly clear to him, and then
> it doesn't matter if it's called .txt or .patch. He might even have some
> tool by then that displays patches color-coded and what-not (there are a
> plethora of such tools for Windows already, most of which register
> .patch and .diff as file-types they handle).

That wont happen until windows registers it for them. And that, again,
wont ever happen. Every user will register .patch to notepad, visual
studio or ultraedit or something else for himself.

> Otoh, *until* he uses git, the change doesn't affect him,

actually, patch works for git patches, so format-patch produces
files useful output for anyone.

BTW, Junio, how about making the _default_ settable at compile time?
It'd be reasonable to allow local installations choose to default to what
they find the most paranoid?

> so why bother catering for his needs?

I don't know. It's kind of good style lately.
