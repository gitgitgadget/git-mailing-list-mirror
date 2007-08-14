From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: gitk performance questions/issues
Date: Tue, 14 Aug 2007 12:25:59 +0100
Message-ID: <e1dab3980708140425r72733f1bn4bc0d2e6cc68fb4c@mail.gmail.com>
References: <e1dab3980708130248g1cbab0cej18e260c8bfa2b315@mail.gmail.com>
	 <alpine.LFD.0.999.0708130945420.30176@woody.linux-foundation.org>
	 <e1dab3980708131018h495c5cf2m76cb8f6ffc4df6dc@mail.gmail.com>
	 <18113.12777.164103.302185@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Aug 14 13:26:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKuXK-0003MV-Gv
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 13:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998AbXHNL0G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 07:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752469AbXHNL0F
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 07:26:05 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:11519 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183AbXHNL0B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 07:26:01 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1425341wxd
        for <git@vger.kernel.org>; Tue, 14 Aug 2007 04:26:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WPWfp5x/b4Ib57OSswYvl6X6r7slFTojk6gpyWIg+n03s/+QWCGplVbjCN8W4/0jlZMogdy+xwxgz9KZgT8FpxZysTIwlfzyRQMYcc1mFDC9mWepe/B6pDlX86LE7zIU7GcYZfOjm5ngmONb1klCecj0WAIFJ653qsGnWgvLgyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rh0ooxzTq09FZa8++JMVTA8ipZMDStA/kKKg5i0SPmLv7/77bJtKL+nincKGU9sD5wOvNj1ve5r5MmnJSYZ9VG99gOdroT1/8YQBDikhHLFv90O9wyrvJbK7g2d0Ca35v2yauQCGjDAJ2wPY+/zibHeDvkXrCpUZt+3fROBoIXM=
Received: by 10.70.13.1 with SMTP id 1mr12092807wxm.1187090759345;
        Tue, 14 Aug 2007 04:25:59 -0700 (PDT)
Received: by 10.70.26.12 with HTTP; Tue, 14 Aug 2007 04:25:59 -0700 (PDT)
In-Reply-To: <18113.12777.164103.302185@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55828>

On 8/14/07, Paul Mackerras <paulus@samba.org> wrote:
> David Tweed writes:
> Could you try this: go to the Edit->Preferences window and turn off
> "Display nearby tags".  Then with your ~2000 refs in place, see how
> long gitk takes to start up and to display a diff.

Right, I've restored the file of 1915 packed tags (but not the 35 loose
tags). Using DNT for "display nearby tags"

DNT on: consistently 11s to window appear, 20s to normal cursor
DNT off: consistently 11s to window appear but normal cursor immediately

Regarding getting the diffs, I think that was "user misunderstanding" and
I'm doubting if I definitely did click on the blue circles yesterday. Clicking
on the any part yellow tag marker displays the SHA of the tag object
(which I'd confused with the start of an unfinished commit diff);
for some reason I'd thought it would give the diff-with-parent. Clicking on
either the blue circle or "commit headline text" does bring up the diff
instantly even with the packed refs file. Sorry for the confusion.

> Also, if it's possible to give me a copy of your repo, that would
> help.

I'll privately mail Paul about getting it; if anyone else wants a copy
of the repository
in order look at startup performance issues mail me. (The most embarassing
thing in there is just some astonishingly crap code, but I'd prefer not to
blanket publish it.)

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
