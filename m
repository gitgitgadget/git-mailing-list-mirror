From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: Reverting to old commit
Date: Tue, 27 May 2008 22:02:45 +0200
Message-ID: <483C68E5.1040408@dirk.my1.cc>
References: <8345bd80805271050q7412917bt292a276fbbe6aed3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marcus <prima@wordit.com>
X-From: git-owner@vger.kernel.org Tue May 27 22:03:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K15OW-0004co-Uw
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 22:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757569AbYE0UCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 16:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757553AbYE0UCt
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 16:02:49 -0400
Received: from smtprelay08.ispgateway.de ([80.67.29.8]:47932 "EHLO
	smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757429AbYE0UCt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 16:02:49 -0400
Received: from [84.176.66.110] (helo=[192.168.2.100])
	by smtprelay08.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1K15Nf-0006sv-7Y; Tue, 27 May 2008 22:02:47 +0200
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <8345bd80805271050q7412917bt292a276fbbe6aed3@mail.gmail.com>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83039>

Marcus schrieb:
> Newbie question: What's the simplest way to find an old commit and revert?
>
> Say you have a version from yesterday which worked and today's
> experiments failed, so you want to go back to that working version.
> Unfortunately, it's not tagged. Instead you need to actually view the
> code to identify the version you want. I thought maybe gitk might
> help, but I can't find my way with gitk. I hoped you could browse
> revisions easier in a GUI and tell gitk or git-gui to revert?
>
> Thanks,
>
> Marcus
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   
Probably I misunderstood, but: do you *know* which version worked
well? I.e. when you start gitk, can you point to the working
commit and are just wondering how to revert to that one?

Then gitk's "reset ... branch to here" could help you. Right-click
the desired commit and reset the branch.

There's no need to have a tag for this. You can even create a
tag afterwards for any commit you like. It's just an alias for
the commit id (sha1).

If you cannot identify the working commit, then please forget
my answer and follow the "git bisect" proposals.
