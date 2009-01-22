From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: CR codes from git commands
Date: Thu, 22 Jan 2009 10:04:16 +0000
Message-ID: <e2b179460901220204x7b6a43b5hddfee623d2425429@mail.gmail.com>
References: <18805.64312.289059.660023@hungover.brentg.com>
	 <alpine.LNX.1.00.0901212319310.19665@iabervon.org>
	 <e38bce640901212334v1e672d48t81d5c81fecd929eb@mail.gmail.com>
	 <alpine.LNX.1.00.0901220238380.19665@iabervon.org>
	 <7vbptzahra.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 11:06:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPwRT-0005pc-PH
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 11:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755164AbZAVKET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 05:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754977AbZAVKES
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 05:04:18 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:35331 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659AbZAVKER (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 05:04:17 -0500
Received: by qyk4 with SMTP id 4so4484618qyk.13
        for <git@vger.kernel.org>; Thu, 22 Jan 2009 02:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=B+YEjD4F6cFMqfOTrry5Frg+CzXY8r8GUAMUYtkVXC4=;
        b=AsgY0jZVWqOnxK08/SBYHNm+DRimS+3k2+5U/VJYJ0tRoD26d0r6Z8cfTkk6P+qFfH
         BzGpHIzW1LtSzH8ro1MaxnxtGlszJKD1AW0zp7nhvjZANyKM/UqKrqZg2KYBd/FZu5Sl
         9+ZMMvaFNN81UXFbBmn3/QB4cLxXVdptjPi6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RKpV7wzKvrfwVtKzLKLSyAj4ROpq+LHq6lpsW+MxT3LDBU03Cfq5F/ELBVDbX235mq
         EoA5zpiLyyPmICVUC8IuR8bzWB0mJfI3aSFriE+lchfE4eKdgHMQllukI2UGmUCe23V6
         kNx9yqkPnl9c/YiaMw/ZeY732/QpXjPdemcd4=
Received: by 10.214.184.3 with SMTP id h3mr1976805qaf.179.1232618656441; Thu, 
	22 Jan 2009 02:04:16 -0800 (PST)
In-Reply-To: <7vbptzahra.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106740>

>2009/1/22 Brent Goodrick <bgoodr@gmail.com>:
> The environment I'm running git under is the Shell mode inside GNU
> Emacs. I can't tell you what type of terminal it is, because I believe
> that is defined deep in the guts of Emacs. Having read your reply
> above, I'm now wondering whether this is an Emacs issue versus a git
> issue. If it is an Emacs issue, then I am truly embarrassed for having
> wasted everyones time with it.

2009/1/22 Junio C Hamano <gitster@pobox.com>:
> I think we pay attention to "dumb" when deciding if pager is useful and if
> we can do color, but I do not think we check anything beyond "is it a tty"
> when deciding to show progress or not.  The only thing we do differently
> for "dumb" terminal is if we use ANSI clear-to-eol escape sequence or fill
> with a run of SPs to overwrite trailing part of a line, and we assume even
> dumb terminals know how to do a carriage-return.

I think this earlier discussion is probably relevant... I'm guessing
though, $EDITOR is set correctly here 8-)

2008/12/17 Junio C Hamano <gitster@pobox.com>:
> Any semi-good emacs users (let alone hackers) export PAGER=cat to be used
> in compilation mode (and possibly shell mode), so this is not a problem in
> practice.
>
> I have something like this in my .emacs:
>
>    (setenv "PAGER" "cat")
>
> I suspect (I am just a user not a hacker) this will have bad interaction
> with emacs terminal emulation mode, but I do not use the mode, so it is
> enough for me.

Mike
