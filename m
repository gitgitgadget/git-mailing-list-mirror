From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 5 Sep 2007 19:21:29 +1200
Message-ID: <46a038f90709050021o5cdcc976xd099242aeb70643d@mail.gmail.com>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 09:21:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISpCl-0008Bi-MN
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 09:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755482AbXIEHVe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 03:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755070AbXIEHVe
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 03:21:34 -0400
Received: from hu-out-0506.google.com ([72.14.214.228]:41137 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653AbXIEHVd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 03:21:33 -0400
Received: by hu-out-0506.google.com with SMTP id 19so1781294hue
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 00:21:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kHEVouQFPCWew66omE2mExmaj1bFYN6NhrQjVCh1JIoNqfHT9FvLuLhx6Z0qwIsdMiqQvgcF03GwQyZX+8F521nK7bazYJqntbpVepCIYcGRkcMa9fZEbjagmFwzOWo10sndwTQYLr9HhXqzvoGPXVLUkGReVAv0rrsqT5QFAtw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ald5CWBbqkNfWO2UXiCJH6sRuH6r2RC+gqC8/+qn3emGp6ihppu94gIMusOpTUA9n3CxPrFGtZZtnft49/iYhJ/+nx2q4zY/CoQgaW7wLdvAM4ZHjzL5eHT5T8BMMrHfzqOWZbrLIAwfgvW8ptlCf1UwVJow7wS05oLm9AoP9qM=
Received: by 10.82.126.5 with SMTP id y5mr343761buc.1188976891765;
        Wed, 05 Sep 2007 00:21:31 -0700 (PDT)
Received: by 10.67.40.9 with HTTP; Wed, 5 Sep 2007 00:21:29 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57673>

On 9/5/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> I personally repack everything way more often than is necessary, and I had
> kind of assumed that people did it that way, but I was apparently wrong.
> Comments?

(resent with CC to git@)

I never followed up on one of your suggestions back in the day -- that
we printed an informational msg along the lines of "you have X loose
objects, it's about time to repack" after some operations (fetch,
merge, commit). These days it's all C, so I'll pass the buck to people
that actually know how to do printf() ;-)

Also -- early users got everything exploded during clone, James is
probable one of them. It is the worst case scenario, really. Users of
a modern git will start off with a large packs, and accumulate little
packs from pulls, so it's not as bad.

In fact, in James' case, it would have been way way way faster to
"steal" the packs from git.kernel.org via http (or your laptop) and
_then_ repack. He'd been sorted in a minute.

cheers,


martin
