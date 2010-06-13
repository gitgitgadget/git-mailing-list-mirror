From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: (osx 10.4.11) can't push from linux to Apache on mac: can't access location
Date: Sun, 13 Jun 2010 03:44:20 -0700 (PDT)
Message-ID: <m3iq5np602.fsf@localhost.localdomain>
References: <1276390106819-5173157.post@n2.nabble.com>
	<AANLkTim4U99KQ2zDfdSmMzbn1FqCqAPh_hKwITmQDX6H@mail.gmail.com>
	<1276410911244-5173593.post@n2.nabble.com>
	<AANLkTilIGhEXlhEbAAXIU-_1Qg8AJoCalkilWGCzIP1m@mail.gmail.com>
	<1276424936869-5173934.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: ddw_music <jamshark70@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 13 12:44:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONkg1-0008Cs-C3
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 12:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551Ab0FMKoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jun 2010 06:44:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59598 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab0FMKoX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jun 2010 06:44:23 -0400
Received: by fxm8 with SMTP id 8so1873777fxm.19
        for <git@vger.kernel.org>; Sun, 13 Jun 2010 03:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=O9JAZXH9lJEqx1iB87xOMncBA/ORHzvAFI/EhwClccA=;
        b=V7ef4iO1dh+/bJy4eHIksX72wqnXQTbygiQkSW+gpHvks4WJXP+v+txr4mHDuc1f2q
         U0f6u01wZNTG+ai+sAFBy1R4CFlbAcIKYsoQOa5YtFRGlLRMIAGFXDas34tn4m5K95h7
         VrBSuqhM5StFGn9eUN0X5Nnd9oSHacutTSYN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=e6Sm2bBW97MpGPknwgg0lSknFSEUjitMMcYJWIoXArUXOOOOyBJFzXLnqWI+krfUGC
         vARbqhUVwq3hf9CnodZzHlbu/1dira+SfcFRXxwsih6bYYO2MZbR2wMQoVWqmPV3jtu3
         kJzGXP8TV+C3cgay1Xr/vmNgriPwO/VM4gJY4=
Received: by 10.223.46.135 with SMTP id j7mr3957457faf.105.1276425861325;
        Sun, 13 Jun 2010 03:44:21 -0700 (PDT)
Received: from localhost.localdomain (abve213.neoplus.adsl.tpnet.pl [83.8.202.213])
        by mx.google.com with ESMTPS id z12sm4424519fah.33.2010.06.13.03.44.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Jun 2010 03:44:20 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o5DAhrV1029114;
	Sun, 13 Jun 2010 12:44:03 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o5DAhgr0029104;
	Sun, 13 Jun 2010 12:43:42 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1276424936869-5173934.post@n2.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149043>

ddw_music <jamshark70@gmail.com> writes:
> Tay Ray Chuan wrote:
> > 
> > I vaguely remember encountering this. Use a dav client, like cadaver,
> > to manually release the lock.
> > 
> >   $ cadaver http://yourserver/git/kc/
> >   > discover info/refs
> > 
> >   <bla bla: look for the lock token>
> >   > unlock <token>
> > 
> 
> I do appreciate the help... unfortunately, cadaver reports no locks but the
> error persists...
> 
> For my purposes, I think I can use git-daemon. It's approaching the point
> where it will not be worth dealing with the Apache layer. Unless there is a
> simple solution, the HTTP approach seems to be adding complexity without
> much benefit.
> 
> If anyone out there knows of a straightforward way to set this up, I'm eager
> to hear it. (By "straightforward," I mean I'm out of time to fiddle around
> with it much more.) If there is no straightforward way, git-daemon it will
> be for me.

Why can't you use SSH for pushing instead of "dumb" HTTPS via WebDAV?
This would require having sshd (SSH daemon, i.e. SSH server) installed,
and perhaps Gitosis or Gitolite for access control (so one can use only
single shell account).

git-daemon in default configuration doesn't allow pushing.

I don't know if new "smart" HTTP has support for pushing, and whether
it would be easier to set up than WebDAV..

P.S. You did run git-update-server-info (and added it to 'update'
     hook), didn't you?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
