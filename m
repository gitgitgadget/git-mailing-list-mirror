From: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Tue, 3 Jun 2008 16:40:44 +0200
Message-ID: <b77c1dce0806030740td820c52ve45619812313776c@mail.gmail.com>
References: <1212489977-26822-1-git-send-email-rgarciasuarez@gmail.com>
	 <200806031512.20729.jnareb@gmail.com>
	 <b77c1dce0806030636i434e4716r8a52d6aeb93e9719@mail.gmail.com>
	 <200806031614.29161.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Luben Tuikov" <ltuikov@yahoo.com>,
	"Sam Vilain" <sam@vilain.net>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 16:41:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Xhr-0000qd-8w
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 16:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596AbYFCOkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 10:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753490AbYFCOkr
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 10:40:47 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:54503 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbYFCOkq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 10:40:46 -0400
Received: by yw-out-2324.google.com with SMTP id 9so819542ywe.1
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 07:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Y4PflAdeFjSfD457rRQZuNAv2jqHRMGC31gy2D6qEBY=;
        b=Iu3ZVbKfNzkuTX+huuwVO8XbxcSJJ3F8M2iemKeUciM5jvxXxhi9+JJjj355CwuMmkbxN4RrQ95GqVnp0n2or3GMzSU1NFQFMBXz8X9BPA5si6o8nmBggNCycbvWC1kSDpm8/9tanM3OY/HIynKgf9+LwowefDUHVaMKKqgf9qo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mcEXDfC+S56D0FjNyrvU1G5c9wTRLRP3MA30a+g+0n/b5MRXWvAo8Fy0FtWDFK3FhOrojM6mGLb9IPzezYEai7naEzXvINdUlOLwuP+zrHcwLa3cNshZbfGa4VuGUgnaBzkIkL46Wxz9/HOGd1iRD+bRBnw5E/PH1bWkAyml7YU=
Received: by 10.143.12.20 with SMTP id p20mr2285594wfi.301.1212504044631;
        Tue, 03 Jun 2008 07:40:44 -0700 (PDT)
Received: by 10.142.212.20 with HTTP; Tue, 3 Jun 2008 07:40:44 -0700 (PDT)
In-Reply-To: <200806031614.29161.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83667>

2008/6/3 Jakub Narebski <jnareb@gmail.com>:
>> Shameless plug : the sources for perl 5 are currently being kept in a
>> perforce repository. There is a rough web interface to it at
>> http://public.activestate.com/cgi-bin/perlbrowse with excellent blame
>> log navigation features (including navigation against p4
>> integrations).
>
> By the way, what is the difference between '<<' links and 'br' link
> in the above mentioned annotate/blame interface?

"br" navigates to another branch from which this file has been
integrated (in p4 speak.)

> I'd like to say that I prefer gitweb's marking blame by blocks, not by
> lines, and extra info on mouseover.  But having blame navigation
> capability of perforce web interface would be really nice (I think
> "git gui blame" has something like this; I don't know about other
> tools like qgit, giggle, or ugit).
>
>> Since we're going to move the official perl 5 vcs to git (many many
>> thanks to Sam Vilain for that, BTW),
>
> BTW. how in your opinion Git compares to Perforce, both as a tool
> itself, and also about quality of companion tools such like gitweb
> or git-gui?

I'm not using companion tools much, but I'm really impatient to switch to git.
(I'm often working offline and applying patches from mailboxes. That
already makes two good reasons for switching:)

> I think it would be really nice.  Will you want to use git-diff-tree
> to mark differences from the version we came from (marked by 'hp',
> 'hpb' and 'fp' URI parameters), or would you rather extend git-blame?

I don't know. I'll look at git-diff-tree.
