From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Raw commands to add object to existing tree
Date: Fri, 21 Aug 2009 22:56:23 +0000
Message-ID: <32541b130908211556w314bca57hb6c8902d78528c95@mail.gmail.com>
References: <ef72456d0908211531m5e261805p2f67d3a8a16a0b5@mail.gmail.com> 
	<32541b130908211539ke64bd2bif0aa7cff6bc6ae8f@mail.gmail.com> 
	<alpine.LFD.2.01.0908211546250.3158@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: D Sundstrom <sunds@peapod.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 22 00:56:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Med2S-0000IN-Je
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 00:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932825AbZHUW4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 18:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbZHUW4n
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 18:56:43 -0400
Received: from mail-gx0-f205.google.com ([209.85.217.205]:57609 "EHLO
	mail-gx0-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932720AbZHUW4m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 18:56:42 -0400
Received: by gxk1 with SMTP id 1so1378123gxk.17
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 15:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=uCI1Q+tPAiw17dr4ExRAUu6+4jYtmhEzHXa3NeAIuWI=;
        b=lhUbW6z9rBab/IuQXR8VZ/Aq2JIP5b2/fDFcYhr2BOIZOuXZJOoIQHRMw+fIgA8HjN
         ak4bEXbKB6750jQkWaOnnl4Hp+nmbvbGKSTkvrrpoRjDOOIfGet0BGO9DhI7TF0cLdTk
         qOJgYTIa1HjqDOS19m6mQF717pZPG1ZKllgYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RB8S84hMippuBau4/WB+ZLSpxjdSrT86eW3H7FtGDJHVsDMTTmptCBx/fYO0bjMxeK
         p+Z8GCe9lumvsgQGEGkHKcyriZQz8esKBwTVdxb24qOo5MjTHot7qGgZ8qzHeMeFrkye
         Asu1gdiE8sh+tvfDIxTEr1y09FcNeVcUDM0Kc=
Received: by 10.150.103.21 with SMTP id a21mr3262564ybc.54.1250895403089; Fri, 
	21 Aug 2009 15:56:43 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0908211546250.3158@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126771>

On Fri, Aug 21, 2009 at 10:49 PM, Linus
Torvalds<torvalds@linux-foundation.org> wrote:
> Looking at that thing, I have ugly flashbacks to my git scripts in 2005 ;)

It rather resembles my git scripts in 2009, in which I'm using a web
service to let people upload Microsoft Access databases and version
control and branch them.  Long story, but I'm sure glad this plumbing
stuff exists :)

And yes, my scripts use the -p option.  Oops.

Have fun,

Avery
