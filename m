From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: merge time
Date: Sun, 29 Jul 2007 20:57:11 -0700 (PDT)
Message-ID: <706148.71958.qm@web51005.mail.re2.yahoo.com>
References: <alpine.LFD.0.999.0707292000190.4161@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 05:57:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFMNg-00080m-30
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 05:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936053AbXG3D5N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 23:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933615AbXG3D5N
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 23:57:13 -0400
Received: from web51005.mail.re2.yahoo.com ([206.190.38.136]:28680 "HELO
	web51005.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933509AbXG3D5M (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2007 23:57:12 -0400
Received: (qmail 72532 invoked by uid 60001); 30 Jul 2007 03:57:11 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=MjqeTuQes7wtiNyFPIsUlQyVtKZl7ewRPWWplVsbu+/2UZbmZ4NZBRqH5MLLfRFDx4anghxpKaI4bhGIwmT9F4WiblTUb8DRGHp0u7zoeTdH5u84gWJ7ruCAwQJYMctI5QDOgu4FFgKJYnhiKNpENRuKWG+NUzBknHkTkpwbxHU=;
X-YMail-OSG: 1N.bKZoVM1ky_c0ar710PYCo2kOPBepbnX4cFx.L6YnRwEj.hqY1JxrF5SntgNu4jnkBWj5GDvdEwfddtAlgsH8AblLnqiEyeyYHc_LM54eAG20pyqL8jVzYQwxJXA--
Received: from [208.58.8.179] by web51005.mail.re2.yahoo.com via HTTP; Sun, 29 Jul 2007 20:57:11 PDT
In-Reply-To: <alpine.LFD.0.999.0707292000190.4161@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54179>

--- Linus Torvalds <torvalds@linux-foundation.org> wrote:
 
> The point is, there is no "locally".
> 
> Do you mean locally on my machine? That's actually *different* from the 
> locally on the public machines, and no, I wouldn't give you that 
> information anyway (since that information would include the mistakes that 
> I fixed up ;)

Ok that explains it. How about locally on gitX.kernel.org [would have to be real git repository]?
I'd want gitweb.cgi running on my local repository to use the local time of local merges to ensure
the problem I described at the start of this thread doesn't happen. Git reset --hard can be used
to fix mistakes and that wouldn't show? 

> And in fact, even on the public machines, the "locally" would be different 
> depending on things like mirroring delays

Yes, it should be different, everyone's local commit/merge order is not the same.

> So in theory, we could pick one particular public kernel.org machine, and 
> use the times as _that_ machine sees it, but the fact is, that isn't how 
> git works. No normal git command will ever show you such a senseless 
> ordering.

Is local commit order really senseless? Using local commit order and/or the local time of local
merges would solve the problem I mentioned in the start of this thread? I don't think this info
has to be exported to CVS, a web interface to git and/or git itself should be able to tell us what
local time order and/or what local commit order merges were made in.

-Matt



       
____________________________________________________________________________________
Take the Internet to Go: Yahoo!Go puts the Internet in your pocket: mail, news, photos & more. 
http://mobile.yahoo.com/go?refer=1GNXIC
