From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Darcs
Date: Mon, 25 Jun 2007 08:45:57 +1200
Message-ID: <46a038f90706241345m4b5ecb80p9f4ec840993023e0@mail.gmail.com>
References: <cecbdd220706232232w77a609faxf0e6b2dc37f0d1f4@mail.gmail.com>
	 <alpine.LFD.0.98.0706241030540.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Bu Bacoo" <bubacoo@gmail.com>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jun 24 22:46:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2YyD-0006YL-8P
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 22:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755097AbXFXUqA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 16:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755063AbXFXUqA
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 16:46:00 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:60213 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754900AbXFXUp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 16:45:58 -0400
Received: by wx-out-0506.google.com with SMTP id t15so1279679wxc
        for <git@vger.kernel.org>; Sun, 24 Jun 2007 13:45:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N0puWrQUgwu1ddXJWitY8DgqQFuA5r5ozLw+WRx1PMT44FpZg95mV61ep+yTuS0xCWwTQIYuQkYDCh8PdHZQ7Wm1jdkruFA+8fquZGGoZ8UzJ4mt5awph1706GkeTDFbTKRdyakj9waEU5bdiv0sTTQqjK95lKJVZ15Gbj51iNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gnToqk4kajMKGjplLrpZaSMINWOoruTdTBsqB9aO8Q+uEV4HuJK+Vl40c4xW5o8aOYTEbDcZfRGZ0bwY9EhMtnXFktYs+1/XdMHc1WuURPrcUCDhEl5fIuyWdqKDf+9krbR1CbXgvD5g3aG4nQovfjBHTCxPfQSDA2IaVWhGdmw=
Received: by 10.90.91.14 with SMTP id o14mr3682956agb.1182717957716;
        Sun, 24 Jun 2007 13:45:57 -0700 (PDT)
Received: by 10.90.52.9 with HTTP; Sun, 24 Jun 2007 13:45:57 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0706241030540.3593@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50819>

On 6/25/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Ahh, a chance to flame! I will never back down from such a challenge!
>
> Darcs is .. umm .. ehh..
>
> "Academic".

OTOH, and from the POV of someone closely following the SCM tools in
the last few years (and using almost all of them), darcs was the first
usable DSCM in the camp. I am not sure how much of its commandline
user interface was borrowed from BK or elsewhere, but darcs was
_easy_, where Arch was extremely hard to use.

The darcs commandset (init, push, pull) is what git, hg and bzr have
today in common. At least _I_ learned about how it could be easy by
watching people use Darcs (and feeling very ashamed of my baroque Arch
usage). The focus on patch tracking (as opposed to "snapshot"
tracking) and the whole patch algebra are two misfires I'd say.
Snapshot-tracking DSCMs are winning (faster and fundamentally more
reliable), and the patch algebra doesn't quite scale and (as far as
I've heard) sometimes ends in unsolvable corner cases.

And the closer we get to Darcs UI the happier I feel ;-)

cheers,


martin
