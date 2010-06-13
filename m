From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: (osx 10.4.11) can't push from linux to Apache on mac: can't access location
Date: Sun, 13 Jun 2010 05:38:06 -0700 (PDT)
Message-ID: <m3eigbp0q5.fsf@localhost.localdomain>
References: <1276390106819-5173157.post@n2.nabble.com>
	<AANLkTim4U99KQ2zDfdSmMzbn1FqCqAPh_hKwITmQDX6H@mail.gmail.com>
	<1276410911244-5173593.post@n2.nabble.com>
	<AANLkTilIGhEXlhEbAAXIU-_1Qg8AJoCalkilWGCzIP1m@mail.gmail.com>
	<1276424936869-5173934.post@n2.nabble.com>
	<m3iq5np602.fsf@localhost.localdomain>
	<1276430179137-5174101.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: ddw_music <jamshark70@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 13 14:38:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONmS8-0000CR-F3
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 14:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506Ab0FMMiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jun 2010 08:38:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:57556 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499Ab0FMMiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jun 2010 08:38:09 -0400
Received: by fg-out-1718.google.com with SMTP id d23so856239fga.1
        for <git@vger.kernel.org>; Sun, 13 Jun 2010 05:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=zZvEOCiD+J06WwBpPtmiTlw8VVq9+DkXGKgOvXYCkRo=;
        b=EtH8bty7AMiIC1Cd7t6nUjyZS0cJW/kFz87icu7bOhA3yq6bbdCNe69KX/kKrnbfP+
         asUSlUh7VwPLUHyMuhG9XjNZHMiYToItKbfPy9B6xIts1UO3se4PM55nwGd6bdISI0oR
         NwML8MwNIQGAIeWajXtuUUId5PVg0TN8dsPE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=wkEhVQH48swAKT/E3zCXizxFhaDVtVB9eyDLNGiLmMplb8s3Z4FHbSTcd8GNORowJ2
         8Tx446d1mHTlGGQ6j1WbOqwhH9hn6R5qWumUq2dHb1JZ+7slw0E/0uwvHd4aHkaqhJgL
         /u+FywLwHOwSlfhwZL5Sq63oHyQHBl97t9bCQ=
Received: by 10.87.48.18 with SMTP id a18mr7069915fgk.53.1276432687664;
        Sun, 13 Jun 2010 05:38:07 -0700 (PDT)
Received: from localhost.localdomain (abve213.neoplus.adsl.tpnet.pl [83.8.202.213])
        by mx.google.com with ESMTPS id l19sm7412384fgb.20.2010.06.13.05.38.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Jun 2010 05:38:06 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o5DCbniZ031142;
	Sun, 13 Jun 2010 14:37:50 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o5DCbc1T031139;
	Sun, 13 Jun 2010 14:37:38 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1276430179137-5174101.post@n2.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149047>

ddw_music <jamshark70@gmail.com> writes:
> Jakub Narebski wrote:
> > 
> > Why can't you use SSH for pushing instead of "dumb" HTTPS via WebDAV?
> > This would require having sshd (SSH daemon, i.e. SSH server) installed,
> > and perhaps Gitosis or Gitolite for access control (so one can use only
> > single shell account).
> > 
> 
> I'll consider that later on. For the moment -- I spent probably five or six
> hours today and fiddling around with the configuration, and I don't have
> time to look at any other tools (gitosis etc). (At least osx comes with
> "Remote Login" == sshd preinstalled.)

Gitosis / Gitolite would be needed only if there are many people that
you want to have SSH access to git repositories without giving them
all shell access...

> 
> While experimenting with git-daemon this morning, I did get the
> functionality that I need working by enabling receive-pack. Yes, I know
> that's a security risk, but I'm the only user, behind a hardware router (no
> exposed IP address) and I will have the daemon running only for a few
> minutes at a time when needed for sync.
> 
> I realize this isn't the "correct" or "optimal" configuration, but I know
> that it will work for the moment and, as stated, I simply won't have any
> further time for experimentation for the next few weeks.

...but in your situation it would be anough to have on server (i.e. on
computer you want to push to) to have sshd and git installed, and have
sshd enabled (turned on) and git available in your $PATH on server.

Then

  git push <user>@<host>:/path/to/repo.git <branch>

should work (or you can configure remote).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
