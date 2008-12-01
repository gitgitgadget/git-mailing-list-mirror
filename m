From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: RPM for gitweb (was: SPEC files for git)
Date: Mon, 01 Dec 2008 07:57:07 -0800 (PST)
Message-ID: <m3prkbj3ch.fsf@localhost.localdomain>
References: <4933FFC6.8080306@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Nicolas Morey-Chaisemartin" <devel@morey-chaisemartin.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 16:58:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7BAK-0005Ng-7E
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 16:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbYLAP5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 10:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbYLAP5M
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 10:57:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:21335 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbYLAP5L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 10:57:11 -0500
Received: by ug-out-1314.google.com with SMTP id 39so2709063ugf.37
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 07:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=tJhJdF+o+aCiV9OBhFteenD9Sb1ip++hTGl4KHnK4uk=;
        b=JeZPnUEvPjX5KAMDHChkFlxFaH7UmQU6LNocO/KdIkAjS38SZRkhNBtIHlGa16Ona8
         JN4XAfKWfJib0QtZnc1OSCPP2kJLp1rci8lK92S7kwFTBNS6AfA73Q3O2XlklffxINCc
         WFRm7NJQBrfJ0sDpYFOdWdctlFJ5owFGsQghY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=CY21gqePThB0mVlmTLQcIfcvfogU2y4gt21Ntl1KU+gvGrV3uFm1mp/nN7UREWU8l7
         hZjVsHwD2S0k/ze3m5/S3pM12gbKy+pQxq4sQ/jhwGSQWSrmjKsTjZVG3rkxb9gOP7cw
         RJo7zv5sUfAxfF/o1NtVYtq9bElyUuNW0IUSk=
Received: by 10.66.238.16 with SMTP id l16mr3478498ugh.38.1228147028745;
        Mon, 01 Dec 2008 07:57:08 -0800 (PST)
Received: from localhost.localdomain (abwt156.neoplus.adsl.tpnet.pl [83.8.243.156])
        by mx.google.com with ESMTPS id k27sm4850500ugd.48.2008.12.01.07.57.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 07:57:07 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mB1Fv5HG010273;
	Mon, 1 Dec 2008 16:57:05 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mB1Fv2c4010270;
	Mon, 1 Dec 2008 16:57:02 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4933FFC6.8080306@morey-chaisemartin.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102054>

Nicolas Morey-Chaisemartin <devel@morey-chaisemartin.com> writes:

> I'm trying to recompile gitweb-1.6.0.4-1 for RHEL5, but I'm missing
> the spec file.  I've checked the git SRPM. 

Which SRPM? The one for RHEL or Fedora Core, or the one from
http://www.kernel.org/pub/software/scm/git/RPMS/SRPMS/ ?

> It generates a lot of things but no RPM for gitweb.
> 
> Is there any place with an official spec file? Or has anyone made one
> which he could share?

The .spec file for various git subpackages (git, git-all, git-svn,
gitk, git-gui, git-email, perl-Git, etc.) is in git src.rpm file, and
source for it can be found as git.spec.in file in git.git repository.

There is no gitweb RPM subpackage in generic .spec file from git.git
repository (from kernel.org) because 1.) installation of CGI scripts
(or mod_perl legacy scripts) depends on distribution (what web server
is installed, where and how config for this web server is managed);
2.) there is no standard place where to put git repositories to be
hosted by gitweb like /var/www/html/ or /var/www/cgi-bin/

Read gitweb/INSTALL[1] from git repository on how to install gitweb.

[1] http://repo.or.cz/w/git.git/:/gitweb/README
-- 
Jakub Narebski
Poland
ShadeHawk on #git
