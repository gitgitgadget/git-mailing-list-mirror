From: Nicolas Dudebout <nicolas.dudebout@gmail.com>
Subject: Re: [patch] color of branches in git status -sb
Date: Thu, 17 Nov 2011 09:16:41 -0500
Message-ID: <CA+TMmK=-KZOo9jY=8T2eO--cSvrT=g1H20LOmNQiSv3SULqQcw@mail.gmail.com>
References: <CA+TMmKns-9jiedxY4FiJoBg8akkxwkPBib11EmvCD3r7mRA6vQ@mail.gmail.com>
	<7v4ny3pn4v.fsf@alter.siamese.dyndns.org>
	<CA+TMmKkM0B8Bge4Jz7KVjR=F-dK0ojuVJp-fe2vj96uq5z0DrA@mail.gmail.com>
	<20111117105320.GA5591@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 15:16:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RR2ln-0008B9-V4
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 15:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081Ab1KQOQn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Nov 2011 09:16:43 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41446 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757357Ab1KQOQn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2011 09:16:43 -0500
Received: by fagn18 with SMTP id n18so2960264fag.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 06:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=V6xLZFNEndYTkiUy8Hf0CGXL9dKfh0vLrBzUdyB27e8=;
        b=GW3I1Bwi3pePu73Ph7c0t1S1+No8EdO4cgmAtFd7XFV7EiWR+9QUf647Pfb4mI36Ei
         G8iouwfWu5V5nSsueZvBDv4gOWZ/J9qo1lJvyduPPS2h9zKo6sIvxmfQxyeWddXzuLPx
         tOykUKERO7+KJYj9EfNBkSksIgANFHPpnKj/s=
Received: by 10.152.109.198 with SMTP id hu6mr23545105lab.11.1321539401744;
 Thu, 17 Nov 2011 06:16:41 -0800 (PST)
Received: by 10.152.13.105 with HTTP; Thu, 17 Nov 2011 06:16:41 -0800 (PST)
In-Reply-To: <20111117105320.GA5591@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185598>

I just tried to redo this patch.
I stumbled upon some inconsistency between the coloring of 'git
status' and 'git status -sb'.
I'll read a little bit more to give a better report with the correct pa=
tch.

In a nutshell, the local branch is colored by:
- WT_STATUS_ONBRANCH for git status
- WT_STATUS_LOCAL_BRANCH for git status -sb

Nicolas

On Thu, Nov 17, 2011 at 5:55 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi,
>
> Nicolas Dudebout wrote:
>
>> Please disregard this as a patch. I do not have the time to understa=
nd
>> how they have to be properly formatted. I just pasted the output of =
my
>> git client.
>
> What git client are you using? =C2=A0Maybe it can be fixed to produce
> patches that others can easily apply.
>
> The 'git diff' and 'git format-patch' commands produce applicable
> patches when I try, though that doesn't mean much.
>
> Hope that helps,
> Jonathan
>
