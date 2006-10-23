From: "=?ISO-8859-1?Q?Erik_B=E5gfors?=" <zindar@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 24 Oct 2006 01:14:02 +0200
Message-ID: <845b6e870610231614y681e64eu33bb0806f530c742@mail.gmail.com>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	 <453A7D7E.8060105@utoronto.ca>
	 <20061022074513.GF29927@artax.karlin.mff.cuni.cz>
	 <200610221105.26421.jnareb@gmail.com>
	 <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com>
	 <87zmbozau2.wl%cworth@cworth.org>
	 <20061022185350.GW75501@over-yonder.net>
	 <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org>
	 <20061023222131.GB17019@over-yonder.net> <ehjgli$lft$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 01:14:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc8zh-0000UI-Hi
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 01:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWJWXOG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 19:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWJWXOF
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 19:14:05 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:52129 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932369AbWJWXOD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 19:14:03 -0400
Received: by nz-out-0102.google.com with SMTP id z3so618562nzf
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 16:14:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XoIuvliT3qwwOQcOFBEs4bNJoo6BuqhGb2AvYzqfnJtq49zdKUR0muQ3F6oPLUWkexU5GGi0fEPJwr9oxf8+vpn/udCjMEq9oyDd3wsJ4GmRq1QULq2Rdw1GLW/5xfoKCHl0RdG7HmQCqVNtnGoyWbrLRS0FPkag5VeOR8YEZP4=
Received: by 10.35.102.18 with SMTP id e18mr7544431pym;
        Mon, 23 Oct 2006 16:14:02 -0700 (PDT)
Received: by 10.35.116.4 with HTTP; Mon, 23 Oct 2006 16:14:02 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <ehjgli$lft$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29898>

This is starting to turn into a "my VCS it better than yours"
discussion rather then anything else.  That's unfortunate....


>
> Which means that "gitk --all" means show whole DAG in graphical history viewer.
>
> As in bzr there is no command (nor plugin) to clone whole repository,

But it wouldn't be hard to create one...

> I guess that the answer is that you can't do this. But perhaps
> I'm mistaken, and you can do this in bzr-gtk/bzrk...

As of now there is no way to do it due to the fact that nobody has
done it yet. You can ofcourse clone branches into a common repo and do
operations on that. For example, there is a plugin that allows you to
list heads in a repo (and not in branches). So basically, if you loose
a branch, you can still find the head in the repository and recreate
the branch.

I don't see any problem doing a "gitk --all" equivalent in bzr.
Personally, I don't really have a need for it.

> BTW. The following question IIRC remained unanswered: can you easily
> in bzr create branch off arbitrary revision (for example deciding that
> stable branch should start two revisions back in history from development
> branch)?

bzr branch -r-2 development stable
(or "bzr branch -rrevid:foobar" to start at revision id "foobar")

very easy.

/Erik

-- 
google talk/jabber. zindar@gmail.com
SIP-phones: sip:erik_bagfors@gizmoproject.com
sip:17476714687@proxy01.sipphone.com
