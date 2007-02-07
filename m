From: "Don Zickus" <dzickus@gmail.com>
Subject: Re: git log filtering
Date: Wed, 7 Feb 2007 13:19:03 -0500
Message-ID: <68948ca0702071019i5704f24fnf2b9a7d6dfa74d86@mail.gmail.com>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com>
	 <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 07 19:19:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HErOC-00027O-Mm
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 19:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030533AbXBGSTH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 13:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbXBGSTH
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 13:19:07 -0500
Received: from wr-out-0506.google.com ([64.233.184.227]:8810 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422697AbXBGSTF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 13:19:05 -0500
Received: by wr-out-0506.google.com with SMTP id i21so288639wra
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 10:19:04 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jtmd01o9AISeVcBUQW1rlot+AeJMqn5ArMPVN1ZvQhtUe2y8hX5kr8yyuHPlurJs3HDtZVtUDdT9fr3cxy0LZCMjxt/meHBWKLCcmegiiL8we9NcHY+ASMmHToXiaxZso29Z3yxyv74qu2ciQaLb0eRTkIbz00riM4qxtC+d2Bk=
Received: by 10.114.181.1 with SMTP id d1mr2191005waf.1170872343179;
        Wed, 07 Feb 2007 10:19:03 -0800 (PST)
Received: by 10.65.189.12 with HTTP; Wed, 7 Feb 2007 10:19:03 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38952>

>  - "git log" can itself do a lot of filtering. Both on date, on revisions,
>    on "modifies files/directories X, Y and Z" _and_ on strings.
>
>    See "man git-rev-list" for more (it doesn't apply to just "git log", it
>    applies to just about any revision listing, including gitk etc)
>
>    For example,
>
>         git log [--author=pattern] [--committer=pattern] [--grep=pattern]
>
>    will likely do exactly what you want. You can do
>
>         git log --grep="Signed-off-by:.*akpm"
>
>    on the kernel archive to see which ones were signed off by Andrew.

Cool.  The hidden little options.  :-)  This is exactly what I was
looking for.  Thanks.

I didn't see these options in the man pages.  Might be worth putting in there??

Cheers,
Don
