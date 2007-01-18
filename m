From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch, not .txt
Date: Thu, 18 Jan 2007 14:40:49 +0100
Message-ID: <81b0412b0701180540x15d20453s3dbc0c061fd06d50@mail.gmail.com>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
	 <87ps9d7j6t.fsf@morpheus.local>
	 <7vejptsglj.fsf@assigned-by-dhcp.cox.net>
	 <625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com>
	 <7vsle9p8pg.fsf@assigned-by-dhcp.cox.net>
	 <7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net>
	 <81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com>
	 <7v64b4ohcj.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0701180135r505a75a5j172c70792d6569c0@mail.gmail.com>
	 <625fc13d0701180352m151cceb3lf9c00b6cf0ae937b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	davidk@lysator.liu.se
X-From: git-owner@vger.kernel.org Thu Jan 18 14:41:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7XVh-0006rl-VZ
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 14:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbXARNkx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 08:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbXARNkx
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 08:40:53 -0500
Received: from wr-out-0506.google.com ([64.233.184.233]:24148 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932379AbXARNkw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 08:40:52 -0500
Received: by wr-out-0506.google.com with SMTP id i22so159776wra
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 05:40:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LavC+SIq9xRxDmDRmArPVg9yNlBPReTCP33nuHrL9RgeB2EP8yEP/U7CaydqOnRpm4CCOf67Zhxq8+nYj8Zy6D07HnKc+k7mcVKOXys9/v9xEl/PY8el6auehXXN96nX9XJMsK134IDQOHWBUDlS3DOylsogJWd1cxk59bmdIXQ=
Received: by 10.78.134.12 with SMTP id h12mr823110hud.1169127649122;
        Thu, 18 Jan 2007 05:40:49 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 18 Jan 2007 05:40:49 -0800 (PST)
To: "Josh Boyer" <jwboyer@gmail.com>
In-Reply-To: <625fc13d0701180352m151cceb3lf9c00b6cf0ae937b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37088>

On 1/18/07, Josh Boyer <jwboyer@gmail.com> wrote:
> > I think we'd raising the entry barrier with choosing the defaults
> > being so convenient for us. Well, the real-life programmers
> > are less of Unix-liking kind. They are more lazy and demotivated
> > kind, and Git will be _forced_ on them. It almost certainly
> > will not be their choice. Not always, some'll like it (heck, I know
> > people who swear by Perforce!), but most have a job, source
> > of income, and not the profession (like in professional pride).
>
> real-life programmers?  Please don't generalize.  It's insulting.

Just because you are not able to realize that the count of
windows-based projects is still superior to that of say...
"likable" systems, they wont magically disappear.
If that is the case, I think I do some more insulting
and say that they are not only real-life but also will never
accept the statement of their ways being wrong, however
stupid they may appear. That's just how it is, count them if
you don't believe me.

> > As much as like Unix and everything related, I think it is
> > not reasonable to try to change the majority. Not unless
> > we have something earth-shattering. Well, git is, but
> > 0001-fix....patch in email attachment probably not.
>
> I would venture to say that the _majority_ of git users are not using
> Windows.

The _real_ majority of the programmers desperately need a better
VCS than CVS, SVN, Perforce, SourceSafe, ClearCase, etc.

> In this enviroment, Linux is likely the dominant OS,
> followed by other *nix.  So changing the extention to benefit the
> majorit of _git's_ users is a good thing.

Yes. For me and you. One of my coworkers knows nothing about patches,
but wants (and perfectly able to) review my code. He has usable brains
and is able to figure out what "+" and "-" is (he has, by now). He hasn't
even realized that it was an automatically generated information, as
I sent a patch to him first time, thought it was just a funny way to
document changes (and was surprised when I told him a patch can be
applied automatically, even if the original file is not exactly the same).
But he is a typical windows-trained programmer. Lazy, unmotivated and
happily married. He does programming by accident (was smart enough
to learn the basics of the trade). Why would he want to take the an
extra step of figuring out what that strange "0001-...patch" means?
Now, I know him, would never think about sending him a real patch.
I'm kinda grown and tired, and need the bastard, too. Someone younger
will just call him idiot and "improve" the situation by telling him about
"stupid windows" and "he should the right ways". Just to be answered
"it worked for some millions programmers before you" and "I told your
manager you making problems and are hard to communicate with".

People often understand "funny ways" the others may have. They
don't like been told they are wrong or stupid (especially when they
actually are stupid).
