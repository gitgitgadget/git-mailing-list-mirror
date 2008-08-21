From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: Bug/problem with 1.6.0 on UnixWare
Date: Thu, 21 Aug 2008 13:41:07 +0100
Message-ID: <e2b179460808210541lfd7dcaeoea8554a2a76f8825@mail.gmail.com>
References: <alpine.LNX.1.10.0808210522450.24713@xenau.zenez.com>
	 <e2b179460808210435w31b911a5ie6059b5628db8138@mail.gmail.com>
	 <alpine.LNX.1.10.0808210610440.29396@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Boyd Lynn Gerber" <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 14:42:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW9UV-0003qB-3M
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 14:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbYHUMlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 08:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbYHUMlJ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 08:41:09 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:51213 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbYHUMlI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 08:41:08 -0400
Received: by rv-out-0506.google.com with SMTP id k40so922672rvb.1
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 05:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=s/zS7JspsUbJP6Jq3aXD6PC6L5qv6WqcgVBLi/F1F6U=;
        b=suTpMHuYk7SnucQ6dortoibDaQFkK2wIy2xFo+Pupna1fGQQ2dAJrozKa8W5xMy8Pg
         Ju8dZNLo5ZuhXXpb6VsEFOcYp1v/NUvJVjrN1b5TWSz5QXJ/AE793SebamjL3EEJElU+
         O0ugYQ9E3KXnZKYCSJCh4hrLo0pBVkMq8xlKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=OZRu3Wp1dh1CiFj+VYkx/jFBonTB2iRvLeg6qk2Cka5SL+g6atX+/jTH3hnET5dNf9
         qgKABn6Nn5hiAu5wxcvIOF5vkTP7v1X5DKDIXDpTerllDrQhLnK9ap3IXuBrbWzBG43N
         osJDGbiIUjxATvVr/OCTBsn7SCMsBE7HVAbl4=
Received: by 10.141.83.15 with SMTP id k15mr685145rvl.289.1219322468004;
        Thu, 21 Aug 2008 05:41:08 -0700 (PDT)
Received: by 10.141.19.11 with HTTP; Thu, 21 Aug 2008 05:41:07 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.10.0808210610440.29396@xenau.zenez.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93144>

2008/8/21 Boyd Lynn Gerber <gerberb@zenez.com>:
> Yep, that sounds about right.  It has bitten me on the 12 platforms, I
> submitted to get git working on them.  I will look at reverting it.
>
> I just tried to get this working and now I am being flooded with emails
> from people that are trying git for the first time, and asking...
>
> How I could your recommend such a broken SCM?  I told them to got back to
> the 1.5.X but being new to git and then not being able to build and use it
> is causing a lot of flack.  I am getting emails now about my recommending
> git, as it is broken.  I should not have announce to the various lists
> about how great git is and that they should dump their older SCM's in
> favor of git.  Really bad timing on my part.  I just hope these people
> will give git an other try.

If it's possible, you might want to look at automatically building and
running the git testsuite on some or all of your SCO etc platforms.
You're very welcome to push tags describing the state of the build and
tests to http://repo.or.cz/w/git/gitbuild.git - there's a few scripts
there in a side branch.

Personally, I'd like it if Junio could check to see if the 'satellite'
platforms are happily building and passing the last rc before he tags
a final release (with no additional code changes in it!), but that may
be too much of the tail wagging the dog.

Even though 1.6 builds and passes here, I probably won't push it out
in my environment until 1.6.0.2 or so.

Mike
