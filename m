From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch, not .txt
Date: Thu, 18 Jan 2007 10:35:03 +0100
Message-ID: <81b0412b0701180135r505a75a5j172c70792d6569c0@mail.gmail.com>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
	 <87ps9d7j6t.fsf@morpheus.local>
	 <7vejptsglj.fsf@assigned-by-dhcp.cox.net>
	 <625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com>
	 <7vsle9p8pg.fsf@assigned-by-dhcp.cox.net>
	 <7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net>
	 <81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com>
	 <7v64b4ohcj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Josh Boyer" <jwboyer@gmail.com>, git@vger.kernel.org,
	davidk@lysator.liu.se
X-From: git-owner@vger.kernel.org Thu Jan 18 10:35:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Tfq-0001jG-RC
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 10:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbXARJfI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 04:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbXARJfH
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 04:35:07 -0500
Received: from wr-out-0506.google.com ([64.233.184.231]:63297 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932152AbXARJfG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 04:35:06 -0500
Received: by wr-out-0506.google.com with SMTP id i22so110278wra
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 01:35:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vgw7CYu5L2qfC8XNBwBTzQ0M+obbwcZ6rABpn6LHP8L39GtJyrUyIzdC0Mdd9m3fYzQe9jAtUgZSQoZpuZZZEPN+hJdbF5HZMqP38LUnkTzX5ZMGEdWk5SM7xSPHQcRg8WxR5tXdl+6oqUn5n/TzeZXAyXw1ToUgWY0/o2OsOYU=
Received: by 10.78.164.13 with SMTP id m13mr590824hue.1169112903141;
        Thu, 18 Jan 2007 01:35:03 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 18 Jan 2007 01:35:03 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v64b4ohcj.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37072>

On 1/18/07, Junio C Hamano <junkio@cox.net> wrote:
>
> > I'd like to see ".patch" there, but...
> >
> > I have to mention, though, that the majority of the editing
> > programs is used on that stupid thing called windows ...
>
> Even if majority of git target audience were on Windows, I
> thought majority of Windows users are on either VFAT or NTFS and
> not DOS 8.3 filesystems these days.

The filesystems are not 8.3, the programs are.

> > Also, how many mail clients know that .patch is actually
> > a text and not application/binary? It'll make patch
> > reviewing harder for some (not sure if I'd like a review
> > of such a person, though).
>
> Is it common for popular MUAs to have a single command that lets
> you specify a file and depending on its suffix paste it inline
> or make it an attachment?  I had an impression that most have
> separate commands for "read text from file (as opposed to
> typing)" and "attach a file (of random type, not necessarily and
> more often than not text)".

No, they don't :) They only have "attach" and drag-drop (which does the same).

> The output of format-patch is not meant to be used as an
> attachment (it is "read text from file" kind), so I do not think
> your worry applies here.  Maybe something I am missing?

Yes, the experience being a damned corporate windows user
in a novell netware network with 50-year old admin fixated on
microsoft exchange, not to mention Outlook Express users...

I think we'd raising the entry barrier with choosing the defaults
being so convenient for us. Well, the real-life programmers
are less of Unix-liking kind. They are more lazy and demotivated
kind, and Git will be _forced_ on them. It almost certainly
will not be their choice. Not always, some'll like it (heck, I know
people who swear by Perforce!), but most have a job, source
of income, and not the profession (like in professional pride).

As much as like Unix and everything related, I think it is
not reasonable to try to change the majority. Not unless
we have something earth-shattering. Well, git is, but
0001-fix....patch in email attachment probably not.
