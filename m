From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFCv4 3/5] 2/2: Add Python support library for CVS remote helper
Date: Mon, 5 Oct 2009 16:50:40 +0200
Message-ID: <fabb9a1e0910050750q195bdafv5511915fe5d26c02@mail.gmail.com>
References: <1250480161-21933-1-git-send-email-johan@herland.net> 
	<1250480161-21933-4-git-send-email-johan@herland.net> <fabb9a1e0910050631j73bf7288w65da92806332d051@mail.gmail.com> 
	<200910051641.43136.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Oct 05 16:59:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mup2b-0004Ov-VU
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 16:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbZJEOwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 10:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbZJEOwJ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 10:52:09 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:50944 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbZJEOwI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 10:52:08 -0400
Received: by ey-out-2122.google.com with SMTP id 4so592337eyf.19
        for <git@vger.kernel.org>; Mon, 05 Oct 2009 07:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=SjSnnaaEznYAYhRZ732/Sgmb6c2uXPt2MnPDD7ZUZtw=;
        b=aLKq++PCVkZhG9b4EaUZ/HwTi0AFDv4QkhIOIWWoiLBXC5AhIJmSDktWhhsgmHfPTo
         7vJLk8xqtaZLRCe9TmnD5i5S8FjUNpZ4NCVyxO5G7MxnIzteMX3ZG1UvOCmqhhWJrHzy
         s/ov60a407lIIM4qI0+IioyeRSJLNhEQd2Gwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=YU9r5mZcTPIQUZermevi9a1isDK4ZqtWV2q4tyhoovJJZ4OtqfWo/AypWKAqs0Fdog
         Fg3P+PigAhGIIhv88g4VjiU+xrbNMOEkn+Whq8mA+ne+K1MMT3Xi3DlBOsD/DobI5UWh
         d1FBSvAr5/l/4Sr6h3C/pC9pxodrNzg0xQggc=
Received: by 10.216.89.195 with SMTP id c45mr24602wef.38.1254754260235; Mon, 
	05 Oct 2009 07:51:00 -0700 (PDT)
In-Reply-To: <200910051641.43136.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129564>

Heya,

On Mon, Oct 5, 2009 at 16:41, Johan Herland <johan@herland.net> wrote:
> - Are you planning to share directory structure only, or some of the
> Python code as well? From the above structure it seems like you want to
> make use of e.g. util.py and git.py. I'd be delighted if the code is
> reusable by other remote helpers.

Yes, the main reason I suggested this was because I want to reuse
util.py and git.py :). Of course, it'd probably be cleaner to move the
little CVS-specific code that is in git.py atm out of it.

> - Do you plan to put the remote helpers into this structure as well, or
> keep them separate? (currently the cvs remote helper lives separately
> in git-remote-cvs.py in the project root directory)

I think it's good where it is right now, and I've also placed
git-remote-hg.py in the root directory.

>> I'm willing to spend some time to do the needed refactoring, but IIUC
>> Daniel said that you need to reroll the cvs series anyway?
>
> Yeah, a re-roll was planned once the sr/gfi-options work was finalized.
> (right now I'm mostly focused on the jh/notes work). Feel free to post
> the hg-specific and/or common parts as a separate patch, and I can
> rebase the CVS series on top of that before I submit the next
> iteration.

Yeah, I'm waiting on Shawn to decide what should be done with the
whole options thing before I resubmit sr/gfi-options.

> Nice to see people starting to pick up the foreign-vcs work. :)

Now if only we could bribe Eric to write a svn helper :).

-- 
Cheers,

Sverre Rabbelier
