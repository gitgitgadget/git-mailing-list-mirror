From: "David Frech" <david@nimblemachines.com>
Subject: Re: test suite fails if sh != bash || tar != GNU tar
Date: Tue, 10 Jul 2007 21:08:30 -0700
Message-ID: <7154c5c60707102108g59280301pa5c3c0dc3911753d@mail.gmail.com>
References: <7154c5c60707101939sc921b07wef1d14f85086947d@mail.gmail.com>
	 <Pine.LNX.4.64.0707110347580.4047@racer.site>
	 <alpine.LFD.0.999.0707102020020.3412@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 11 06:08:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8TVD-0005uQ-3q
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 06:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbXGKEIb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 00:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbXGKEIb
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 00:08:31 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:8600 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbXGKEIa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 00:08:30 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2147581wah
        for <git@vger.kernel.org>; Tue, 10 Jul 2007 21:08:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=GDSQ8iN2YYV74lsCLFFYkgoQ1P5ZpmAMGVRwL1cGbu+QkGKEOtL64ufsBLQ+ssuLp3E1n1WWHekT4VS16hdUn+Z8QVn+RgDj3QZ/j7CQ1NusXusyUte3n4l/CE7htFsBWWma7aSKdzaeuV7Ib02swrCT5vV7INT0mOBmtfUMzpg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=hv6HCX/yw98ZqfyTcGtyzgh97hPvQsiEZ+dVHiPYYLFuCsYxEdwKx98i39IRI1Aumv1SkajcJOljMOXcupl4qBzBTY6ewQ3VfiuP6nuBz3YqQDn0LDOpUbd00rlfdKXuRVGLwjYxTiD8vx9DoMr3NMOWucoS74i2I49dmOVsUMY=
Received: by 10.114.173.15 with SMTP id v15mr4787451wae.1184126910412;
        Tue, 10 Jul 2007 21:08:30 -0700 (PDT)
Received: by 10.115.59.9 with HTTP; Tue, 10 Jul 2007 21:08:30 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0707102020020.3412@woody.linux-foundation.org>
Content-Disposition: inline
X-Google-Sender-Auth: c2f5bfce15abfc22
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52133>

On 7/10/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Wed, 11 Jul 2007, Johannes Schindelin wrote:
> > As for GNU tar, I think that this is easily fixable if you have access to
> > non-GNU tar.  We do not use tar _ever_, except for the test suite, to
> > verify that things are working as expected.
> >
> > If you could put in some time to make the tests work, that would be
> > awesome.
>
> Yeah, it would be a good thing to get rid of any bashisms, but to _keep_
> it working somebody would then need to test every once in a while that it
> still works ;)

I'll see what I can do. As I'm planning on running git on both FreeBSD
and DragonFly for the forseeable future, and plan to track git's
evolution (running stable releases if not more bleeding-edge code), I
can run the test suite every time I build a new git.

Cheers,

- David

>
>                 Linus
>

-- 
If I have not seen farther, it is because I have stood in the
footsteps of giants.
