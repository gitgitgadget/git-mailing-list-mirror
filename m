From: "Anatoly Yakovenko" <aeyakovenko@gmail.com>
Subject: Re: cant get git to work over http
Date: Tue, 19 Feb 2008 11:53:58 -0800
Message-ID: <e26d18e40802191153w691ac5fcl3fa972ca6503b9fb@mail.gmail.com>
References: <e26d18e40802181649l3c03df82l4eb91c88bec47bf4@mail.gmail.com>
	 <20080219063937.GB3819@glandium.org>
	 <e26d18e40802182309l693b2099wb42573aca7348091@mail.gmail.com>
	 <alpine.LSU.1.00.0802191115440.30505@racer.site>
	 <e26d18e40802191019j48a1ceadk4887ffc35100ab0a@mail.gmail.com>
	 <47BB1EC0.601@freescale.com>
	 <e26d18e40802191106v51c907bdn6aa51acef5f530a3@mail.gmail.com>
	 <alpine.LSU.1.00.0802191916020.7797@racer.site>
	 <e26d18e40802191127v7cc9f051l7002b56b41dc9f86@mail.gmail.com>
	 <alpine.LSU.1.00.0802191940260.7826@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jon Loeliger" <jdl@freescale.com>,
	"Mike Hommey" <mh@glandium.org>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 19 20:54:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRYXz-0006OQ-UU
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 20:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752236AbYBSTyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 14:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752527AbYBSTx7
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 14:53:59 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:39419 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbYBSTx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 14:53:59 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3663408wah.23
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 11:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=MLUG1Dj8r2sCEyBoHWDNLAmC0DKu2ZNhIjqP1a0LzN0=;
        b=Jo96n/W9bm/jhxYbp0EyIT1qdX1cpPdCsiHGHPCT9lTIzm4kIDA7lyYmEv/z9syXO0t4Pkc+ONCL8y7Gx0m1QSLYb3yvndkbnY71Zyb3S9DuNcojs7uMaIEoRMVggwdRoVP+JTekLmnQJx7k0dt12uvHVBSY/vrb+VtUor4Z8+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MHle5b9iE/Lr7RbhdTfE96M6lYTe2ZuhFK216d+bU9zpAjd5sGPfXVzPL4jSv1sFqrAc8yWd4vyWWG6RvFuJXCzHEruG9BpZRI6EzTdeqDS9PWqqSL3J0dPMs0SsFaVldLMZ547s8btMZ/yvGVXjNKRndRYM349CiMLgLHxsB2U=
Received: by 10.114.177.1 with SMTP id z1mr4079899wae.144.1203450838607;
        Tue, 19 Feb 2008 11:53:58 -0800 (PST)
Received: by 10.114.167.5 with HTTP; Tue, 19 Feb 2008 11:53:58 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802191940260.7826@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74449>

> You set up the git repsitory via http, so where is the problem?

 ok, i created a directory on my server.  Dav is on and working, i can
send and download files using IE on that url.

So is it possible for me to just simply run "git-init" in that
directory, and treat that url as i would a repo over ssh or the fs?

i can do this:

$ git-clone /var/www/localhost/htdocs/git/repo/ repo
Initialized empty Git repository in /home/aeyakovenko/projects/repo/.git/
1 block

and i can do this:

$ git-clone ssh://aeyakovenko@localhost/var/www/localhost/htdocs/git/repo/ repo
Initialized empty Git repository in /home/aeyakovenko/projects/repo/repo/.git/
aeyakovenko@localhost's password:
Receiving objects: 100% (3/3), done.
remote: Counting objects: 3, done.
remote: Total 3 (delta 0), reused 0 (delta 0)

but for the life of me i cant do this:

$ git-clone http://aeyakovenko@localhost/var/www/localhost/htdocs/git/repo/ repo
Initialized empty Git repository in /home/aeyakovenko/projects/repo/.git/
Cannot get remote repository information.
Perhaps git-update-server-info needs to be run there?
