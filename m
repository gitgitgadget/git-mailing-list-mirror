From: Aubrey <aubreylee@gmail.com>
Subject: Re: how to trace the patch?
Date: Fri, 28 Apr 2006 00:19:56 +0800
Message-ID: <6d6a94c50604270919w2c4b8f9er796168f03577e736@mail.gmail.com>
References: <6d6a94c50604270306j44c280bdo283591f2f595f74e@mail.gmail.com>
	 <BAYC1-PASMTP029B6CB13A6C0BA3956E17AEBD0@CEZ.ICE>
	 <Pine.LNX.4.64.0604270843190.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 27 18:20:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZ9Dl-0003ro-18
	for gcvg-git@gmane.org; Thu, 27 Apr 2006 18:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWD0QT6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 12:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbWD0QT6
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 12:19:58 -0400
Received: from nproxy.gmail.com ([64.233.182.189]:7447 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965167AbWD0QT5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Apr 2006 12:19:57 -0400
Received: by nproxy.gmail.com with SMTP id n29so1401309nfc
        for <git@vger.kernel.org>; Thu, 27 Apr 2006 09:19:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W7LJ/wJxrCZZq6yF27HVzuynNDRq7ub02abXsqBlx3L4RgsUNyG8SZrkW1HASVbqVrhFc3BlEKQZD2ah/CDaG2t+Nz/SFa0C9jYbZ1S5E8FRVkGA5xit4zxeAVhXWPKriWROKA+uXe69T4zZx4zUpXNyJDXfRcYIXUWmWCpb3GI=
Received: by 10.49.54.8 with SMTP id g8mr4630864nfk;
        Thu, 27 Apr 2006 09:19:56 -0700 (PDT)
Received: by 10.48.220.18 with HTTP; Thu, 27 Apr 2006 09:19:56 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604270843190.3701@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19238>

Thanks a lot.
I'll enjoy it.

Regards,
-Aubrey

On 4/27/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Thu, 27 Apr 2006, sean wrote:
> >
> > $ git log -- <filename>
> >
> > To see a list of commits that affected the file you're interested in.
> >
> > $ git log -p -- <filename>
> >
> > Will include a diff after each commit showing you how the file was
> > changed.  And if you want to see what other changes happened in each
> > commit that modified your file, add "--full-diff" to the command above.
>
> Side note: the "git log -p" thing only works with git 1.3.0+, and even
> without the "-p", old versions will be very slow.
>
> So if you have anything older than 1.3.0, you're likely better off using
> "git whatchanged [-p] -- <filename>".
>
> Also, regardless of which one you use, it's worth pointing out that:
>
>  - for tracking multiple files, just use more than one filename, and you
>   can also use a directory name.
>
>  - you can combine this with all the normal revision limiting rules, which
>   is often useful when you know you're not interested in stuff you've
>   already seen.
>
> For example, if you have just done a "git pull" and you noticed that a
> file (or set of files) you cared about changed - or you just wonder _if_
> it changed - you can do something like
>
>        gitk ORIG_HEAD.. -- drivers/scsi/ include/scsi/
>
> to see what changed due to the pull within those files. Useful whether
> you're tracking certain subsystems, individual drivers, architectures,
> whatever.. It can be useful also just to split the logs up (ie maybe
> you're not interested in anything in particular, but you do a "git log"
> and see something that strikes your fancy, you can decide to see what
> _else_ changed in that area).
>
> And instead of "gitk", use "git log -p" or "git whatchanged" or whatever.
> It's all the same thing, just different ways of looking at it.
>
>                Linus
>
