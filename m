From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Simple commit mechanism for non-technical users
Date: Wed, 19 Aug 2009 01:10:03 -0700 (PDT)
Message-ID: <m37hx0ns13.fsf@localhost.localdomain>
References: <ef72456d0908180905u18593b63tdc850b8552db30b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: D Sundstrom <sunds@peapod.net>
X-From: git-owner@vger.kernel.org Wed Aug 19 10:10:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdgFM-0003FM-Mr
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 10:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbZHSIKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 04:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbZHSIKG
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 04:10:06 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:51500 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbZHSIKE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 04:10:04 -0400
Received: by fxm28 with SMTP id 28so3915213fxm.17
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 01:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=nwr8rjitSCw8z19za/81DxRAiXjWqHqndzPMxfOZll4=;
        b=KpO1ohDGYzPWEW8KBTXZWRQsiYI6AFLxotoKm2EtIAJF/l3V51BL8Mu3t1FlKPTp/X
         C6lrykCBkQ3gV6p9eYHjKMCyw+tf+KrLRB6zyy7j/alEBf6K2ivhVlfCTLFd8CMQW3Vd
         GdwbbhmJYRni4d1l2Xj7SyxYttPv8Gh/N+Jw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=bXQufCmgnIEA5jJC7btjrOxZzTaCGj28fegpifj2BMGsCSY6WZDjHfokNKFOeRygeo
         GxEY0in/rdo7CGNohK8R2uSs2vP+JtFoGtBNxIP2IcfxDZJtovGyhpE3Ezsm+mIfWftM
         2dGk8KLno8dpDONNaFEwyNY6dz99HEccCAuKU=
Received: by 10.86.227.27 with SMTP id z27mr3892430fgg.66.1250669404534;
        Wed, 19 Aug 2009 01:10:04 -0700 (PDT)
Received: from localhost.localdomain (abvk137.neoplus.adsl.tpnet.pl [83.8.208.137])
        by mx.google.com with ESMTPS id d6sm6432729fga.9.2009.08.19.01.10.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 01:10:03 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n7J8A16H004725;
	Wed, 19 Aug 2009 10:10:01 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n7J8A0hi004719;
	Wed, 19 Aug 2009 10:10:00 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <ef72456d0908180905u18593b63tdc850b8552db30b9@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126515>

D Sundstrom <sunds@peapod.net> writes:

> I use git to manage all project artifacts, including documentation,
> proposals, presentations, and so on.
> 
> However, I have a hard time convincing non-technical staff to learn
> enough about git or to take the time to go through the effort of
> committing changes to a repository.  So the steady stream of email
> attachments with "Acme Specification v3" or "final final spemco
> proprosal" continues.
> 
> I'd hoped there was a simple web interface that would allow a user to
> upload and commit a file to a repository, but I've had no luck finding
> one.  (I've used cgit for browsing, but it is read-only).

Some of git web interfaces or git hosting software offer editing via
web interface.  Neither gitweb nor cgit offers this; it is available
AFAIK in GitHub (but it is not open source, and server version GitHub:FI
isn't cheap).

You can use some wiki (there are some wikis with git backend,
e.g. ikiwiki, see http://git.or.cz/gitwiki/InterfacesFrontendsAndTools)
or CMS like Drupal instead.  Note that wikis usually work in 
lock-edit-unlock mode (no merging changes), and have per page (per file)
versioning.


Alternate solution would be to use one of GUIs for Git, like
e.g. git-gui or QGit, or filemanager integration / shell extension
like (for MS Windows) TortoiseGit or Git Extensions.

> Is anyone aware of a simple way I can have my non-technical users
> manage their documents against a git repository?  Ideally this would
> involve no installation of software on their machine (unless it were
> compelling, for example, the Finder plugin for SVN on the mac was a
> great tool for these users; or at least those on a mac...)

What operating system?  What do you use currently?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
