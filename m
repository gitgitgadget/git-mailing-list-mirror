From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: git pull origin doesn't update the master
Date: Mon, 10 Apr 2006 12:15:36 +0530
Message-ID: <cc723f590604092345r7d0e2cedr8f9838d054ecb023@mail.gmail.com>
References: <cc723f590604092141q3517136cmc0a895a069021b8f@mail.gmail.com>
	 <7vr7469c4n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 10 08:45:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSq9c-0002OQ-SI
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 08:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWDJGph (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 02:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWDJGph
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 02:45:37 -0400
Received: from wproxy.gmail.com ([64.233.184.228]:31674 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750997AbWDJGpg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Apr 2006 02:45:36 -0400
Received: by wproxy.gmail.com with SMTP id 69so776174wri
        for <git@vger.kernel.org>; Sun, 09 Apr 2006 23:45:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cizW+LKHOjTA3gGESxsq8vv3sxqcXkVUvC4XP2+wBAohxNFL1KDQFCpoiHZkzLazfjU2WWA/Bu7mMa34rzVWOUoEBkYSDGIoxgMA/Z1jRsQXmWCXVbOkmlTr5fpSi5RbcQzVyKOJNVzfNWR0m/nVsJr/dYrI0jX2CWZz639WaFA=
Received: by 10.64.114.10 with SMTP id m10mr1175114qbc;
        Sun, 09 Apr 2006 23:45:36 -0700 (PDT)
Received: by 10.64.114.13 with HTTP; Sun, 9 Apr 2006 23:45:36 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vr7469c4n.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18581>

On 4/10/06, Junio C Hamano <junkio@cox.net> wrote:
> "Aneesh Kumar" <aneesh.kumar@gmail.com> writes:
>
> > While updating the git code base the master branch is not getting
> > updated. First look tell me that the below commit is the issue
> > a9698bb22fb7b66e5882c3a5e7b2b8b53ea03f90
> >
> > git-pull.sh does
> > git-fetch --update-head-ok "$@" || exit 1
>
> Yes, this was done as an response to an explicit request from
> Andrew Morten.
>
> What Sean said about "pu" branch is correct.
>
>
Sean suggestion worked for me.

Work flow is now a bit complicated. I clone the repository. Now i need
to edit remotes/origin to make sure what all branches i need to
follow. And then do a git pull origin. Earlier i just need to do a
clone and a git pull. I don't need to fast forward pu branch. But then
i need to get the update of master branch. since git-fetch fails
update pu branch git pull origin fails to update master branch also
which i am really interested.

-aneesh
