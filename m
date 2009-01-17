From: David Aguilar <davvid@gmail.com>
Subject: Re: I've added Dulwich to the Git Wiki
Date: Fri, 16 Jan 2009 18:37:53 -0800
Message-ID: <402731c90901161837r1c7187dk590c1a46be49e1e9@mail.gmail.com>
References: <alpine.DEB.1.00.0901162329340.3586@pacific.mpi-cbg.de>
	 <1232146991.24098.13.camel@ganieda.vernstok.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jelmer Vernooij <jelmer@samba.org>
X-From: git-owner@vger.kernel.org Sat Jan 17 03:39:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO15j-0003f5-Iq
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 03:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756783AbZAQCh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 21:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbZAQCh4
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 21:37:56 -0500
Received: from rv-out-0506.google.com ([209.85.198.235]:36374 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175AbZAQChy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 21:37:54 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1844018rvb.1
        for <git@vger.kernel.org>; Fri, 16 Jan 2009 18:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=J3Fx8mJt1wTv2pH1zycSUA7dRFWb6+Iuhb9yCJd0NwA=;
        b=R2Q2cS7l5B0eUE2bECg/wyderuQ0Y/Z4Q6kRvOaFtJoMMnUt9/b4nSgbG31sX0pwsA
         jR2cCcpj52/Mu2X69i552A9guIguwPvm093SXA9OKvhCUc+x4PDzE+l0fgk/mHTKS94b
         MZFFZtXOw8Iu/KIcm2LGHbHX/p1r0sQW50/B4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CtkU4iZVuoa4ox3ZIx43gAyVYgjPn0xaSbNaWBTRPucqsq+sQXQhhj7othaXGG1+/P
         DZ0DN2Ie4iqgQ5NCDgeEGy74yZtkwr7tQRcNuiWdTXU/dDfG6mQmqOp8ml1eTqTEeGtF
         B/HzbGUH7YpyCxOUnzo6KW1ohgTRKBbtIMij8=
Received: by 10.143.12.11 with SMTP id p11mr1307476wfi.19.1232159874019; Fri, 
	16 Jan 2009 18:37:54 -0800 (PST)
In-Reply-To: <1232146991.24098.13.camel@ganieda.vernstok.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106010>

On Fri, Jan 16, 2009 at 3:03 PM, Jelmer Vernooij <jelmer@samba.org> wrote:
>>
>> BTW I find it a bit distressing that more and more projects crop up doing
>> substantial and valuable work around Git, but without even bothering to
>> mention it on this list.  There might have been a good chance, too, to
>> avoid having _three_ Python libraries for exactly the same task.
> I wasn't aware of PyGit (and its homepage doesn't seem to work), but
> Python-Git is just a wrapper around the git command line tools, it
> doesn't parse/write the file formats itself.
>
> Cheers,
>
> Jelmer
>
> --
> Jelmer Vernooij <jelmer@samba.org> - http://samba.org/~jelmer/
> Jabber: jelmer@jabber.fsfe.org
>

Hello

This sounds like a great project.

I've talked with the authors of GitPython in the past and I believe
the reason it was never mentioned here was that they were probably too
shy or intimidated (you guys are pretty hardcore ;-) ).

Anyways, as you said, GitPython is purely a wrapper around git
commands.  BTW, git is bloody fast so it's actually not that bad and
works pretty well.

GitPython's license is the New BSD license and thus it can't use git
code nor could it use libgit2.  I think the best route for a useful
Python module would be to wrap something like libgit2 which aims to be
a true library for git.  If that's the goals for Dulwich then all the
better.  If not (and it instead aims to be a pure-Python
implementation) then that's cool too, but for performance reasons I
think the community would best be served by pursuing a core git
library with various language bindings built on top of it.

In any case, this sounds like a neat development and it does seem like
the goals are slightly different then the existing GitPython module.
GitPython was basically a port of the Ruby Grit library, which also
just wraps git commands.  I'll keep my eye on this and see if there's
anywhere I can  help.

-- 
    David
