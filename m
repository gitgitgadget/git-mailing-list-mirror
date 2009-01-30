From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: do you recommend "git" (over svn) for a 1-person team???
Date: Fri, 30 Jan 2009 04:46:56 -0800 (PST)
Message-ID: <m3y6wtvu4j.fsf@localhost.localdomain>
References: <d30068860901281718x363348caya2dc94e798cc8091@mail.gmail.com>
	<d30068860901281725t14d19c1vc0557182bca3eb8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg Hauptmann <greg.hauptmann.ruby@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 13:48:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSsnL-0004uz-1Z
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 13:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbZA3MrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 07:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752371AbZA3MrA
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 07:47:00 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:4206 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295AbZA3Mq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 07:46:59 -0500
Received: by ey-out-2122.google.com with SMTP id 25so121278eya.37
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 04:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=zNpdz5dzvsYv334loZwnC4QBM+inaQa3/GFlR1UeGAs=;
        b=ZBGbbATnGStXBFkW+jC8W0pYvcJD6/Vu0fTSV3KeOTwDtvdiRQFlt6axs9NtgdkoRG
         Dg0+EOJvzara0tWcnQ0WyvgeXopVTuFyUY0eGSfw5pK3EBCz6OqAN9dE3A4J6lnD0NgZ
         pVOczKlnlPmzpurd2A9x68VkA+n/j9tcFk1HQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=a8K0yB2w9WbVqoADGCEHtOQlV/QRqdz0pvQGGzyhx00dJLeda90VuMrx9RXcurCGT3
         +5/Uij7lscL+Guv4hUdhcpN2IW4XDHvjFwj2XxHu7JbIGXpHVl4yhrauprADs2CFXyA6
         cLfKoAghG4GcrZfW+KgNlTt0/n2zVSabR0KGE=
Received: by 10.103.106.1 with SMTP id i1mr571968mum.0.1233319616811;
        Fri, 30 Jan 2009 04:46:56 -0800 (PST)
Received: from localhost.localdomain (abwh184.neoplus.adsl.tpnet.pl [83.8.231.184])
        by mx.google.com with ESMTPS id 7sm1030710mup.10.2009.01.30.04.46.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Jan 2009 04:46:56 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n0UCksVN022646;
	Fri, 30 Jan 2009 13:46:54 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n0UCkq0P022643;
	Fri, 30 Jan 2009 13:46:52 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <d30068860901281725t14d19c1vc0557182bca3eb8d@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107804>

Greg Hauptmann <greg.hauptmann.ruby@gmail.com> writes:

> Do you recommend "git" (over svn) for a 1-person team???   (the
> ability to commit while offline on my laptop sounds potentially
> enough reason)

Beside much easier (I think) sync between desktop and offline laptop?

You don't need to setup Subversion server (even if it is setting up
place for repositories): "git init" is enough (and you can use
filesystem, or bundles, or ssh for sync). 

You don't have '.svn' in each directory, but one '.git' at the top
directory of your project (module).

You have (from what I have read) better support for file renames,
better support for binary files, and much easier merging branches
(before Subversion 1.5 you had to use third party tools (SVK or
svnmerge) to not have to do merges "manually", and even now the
support for easy merging is IMHO worse in SVN).

You have all those nifty tools like git-bisect, git-log with --grep
and -S (pickaxe), git-mergetool, git-blame which follows code movement
at request (see e.g. "git gui blame"), git-stash, incremental
comitting, comitting part of changes, etc.


What Subversion has over Git (becuase it is longer) is better tools...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
