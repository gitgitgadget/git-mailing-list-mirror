From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: Can someone confirm what the contents of refs/heads/master means?
Date: Mon, 8 Dec 2008 14:35:56 -0500
Message-ID: <eaa105840812081135p56eceb97yb968575b11a7f985@mail.gmail.com>
References: <f78b0fcc-6165-440a-b76b-b1b0a281b15c@k8g2000yqn.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: davetron5000 <davetron5000@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 20:37:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9lv5-0004TK-QZ
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 20:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbYLHTgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 14:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbYLHTgA
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 14:36:00 -0500
Received: from mail-gx0-f11.google.com ([209.85.217.11]:42011 "EHLO
	mail-gx0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbYLHTf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 14:35:59 -0500
Received: by gxk4 with SMTP id 4so130710gxk.13
        for <git@vger.kernel.org>; Mon, 08 Dec 2008 11:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=Z3ywNseplJslfQ7kRPfPshZsFsoqK6+1+Lp17SL9+LY=;
        b=KyEK5m1kB+LQ51vMV6rx/7hsI4JWa7yl9GVQPzjzGgsdbwXvbS+uNi3Z6ase7kpZFy
         jHrBfmuECQOqHcE53m0vHaCJQMQBU67DanjYOIm2NgbA5Zs4fKRgHbA6o2j/7MQ/5BKf
         mP76oXN53dqrLqTmnszgnIsKGDxSeOG2lKerc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=WagniqtC+BfLJphUfwUPnXxwd0VNzZMiOrJYcXGUCsItUROYezMBNNOUPcrTkz1qQr
         VVYF//GLaKAdpvJaQ5H1VZw9k6BuBwHQ2FCY6zsL6sau8x1aCdLf9sWfjtZr1GH7iydc
         Efpwf+5GArB7Hy0RnpHNpIiA3KdsBOStSgOkc=
Received: by 10.65.191.19 with SMTP id t19mr3124590qbp.61.1228764957054;
        Mon, 08 Dec 2008 11:35:57 -0800 (PST)
Received: by 10.65.230.19 with HTTP; Mon, 8 Dec 2008 11:35:56 -0800 (PST)
In-Reply-To: <f78b0fcc-6165-440a-b76b-b1b0a281b15c@k8g2000yqn.googlegroups.com>
Content-Disposition: inline
X-Google-Sender-Auth: ff17c509052d75cc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102576>

On Mon, Dec 8, 2008 at 2:23 PM, davetron5000 wrote:
>
> So, I overwrote refs/heads/master with the contents of refs/remotes/
> trunk (i.e. the SHA-1 of the svn trunk).
>
> Things seem to be working; git svn dcommit commits to the trunk and
> git svn rebase updates from svn's trunk.
>
> So, I want to make sure that refs/heads/master actuall does, in fact,
> point to the head revision of whatever branch is considered "master".

I do believe so, yes. That, or an entry in packed-refs.

> Can someone comfirm this (or provide the actual explanation if I'm
> wrong?)

Overwriting internal files by hand feels a little too much like work
for my taste. I would have done something more like "git reset --hard
trunk" (or, if not on master, "git branch -D master; git branch master
trunk" ), but of course you can feel free to do things the hard way if
you prefer. :-)

Peter Harris
