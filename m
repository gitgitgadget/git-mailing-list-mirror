From: Eugene Sajine <euguess@gmail.com>
Subject: Re: origin/branchname and tracking branch pointing to different 
	commits?
Date: Thu, 7 Jan 2010 12:25:04 -0500
Message-ID: <76c5b8581001070925g21ac3136x2928f12dc43437e5@mail.gmail.com>
References: <76c5b8581001070903i3810f63crd764d451f7454584@mail.gmail.com>
	 <201001071813.01187.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 07 18:25:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSw6k-0002YP-8L
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 18:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189Ab0AGRZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 12:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887Ab0AGRZH
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 12:25:07 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:57106 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849Ab0AGRZF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 12:25:05 -0500
Received: by iwn32 with SMTP id 32so2480542iwn.33
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 09:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=cTQMncDFJ4Vw7cYOJWQWcW3kf0ieZgv7bjgrwZWYVPs=;
        b=TkAUGTzcAAsMjWyC7zbBx5HZS9+6rVCRR7fh+VvGiFy38gmvGN6ecfhqjtvZz/1cKR
         q407lYSTZ6HFDnVEQ4OBSyslsIJQ24P8MUzxGTuF02yyBEZy4W9V31hDUALpP0ozozIK
         VqvOTWIFR+imz3Pew9wpys4wRXTHF67HdTpCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=u56mGkE43eL/M9hoa2LRWVGaRZf/YGKJQ3VJsuuN6uXC7rAx8voCac4mTxfypLYf8W
         UXKqZH+yaf6o5hJc2bLfupDfklcuT5I7G6MpP8+gE/ye+wywBSPexpsNu19YRoMFJyuN
         DVBuTrpT8NF428EATeb4hs5M6nNzRX+H3HENc=
Received: by 10.231.170.201 with SMTP id e9mr1734241ibz.16.1262885104449; Thu, 
	07 Jan 2010 09:25:04 -0800 (PST)
In-Reply-To: <201001071813.01187.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136365>

On Thu, Jan 7, 2010 at 12:12 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> Eugene Sajine wrote:
>> $git pull origin qa
> [...]
>> So, generally, speaking qa branch is fine and is in synch with the
>> remote mainline, but the state of local origin/qa is not clear.
>
> 'git pull $remote $branch' does not update the $remote/$branch
> remote-tracking branch; it stores in FETCH_HEAD and merges straight
> from there.
>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
>

Yep. That's what i though it is. I.e. origin/branchname will point
always to the last pushed commit only. Isn't it a bit strange that git
fetch doesn't update origin/qa?

Probably the problem is that whenever I'm pulling or pushing to remote
repo i expect the last updated state of particular remote branch to be
reflected in origin/branchname, but IMHO it is correct expectation...

What do you think?

Thanks,
Eugene
