From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [gitweb feature request] Release snapshots with vX.X.X tags
Date: Sun, 08 Nov 2009 05:40:54 -0800 (PST)
Message-ID: <m3tyx5rv6j.fsf@localhost.localdomain>
References: <1257680442.14087.78.camel@owl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Bram Neijt <bneijt@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 08 14:41:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N780t-0002PD-GE
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 14:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbZKHNkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2009 08:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbZKHNkv
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 08:40:51 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:62959 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366AbZKHNkv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 08:40:51 -0500
Received: by bwz27 with SMTP id 27so2607320bwz.21
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 05:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=SbEfL6PmV9Cxekxgx+SBc7PxQ+KT2o+WNr4Sih8kKdI=;
        b=FoDDHnqZ3xiyrGp/N298XecqjGXB3aSJljECx/TAKdORe/AO1bV+DbRVqni1ocmidu
         nesp578JxfRCYIn0ohp0Td9/CdcCNCk0W9DM4cBPb18a9tveHNHkSKhXDY5VbpcZZTx7
         EBR4TOMUErLvLInVrQDVFg1+lWpHp8eWcsXJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Se53AmfJ8JHhJRP+Scetg9YA2jiCKW7ESEZ/dw5qy8EjANXBYjP78wY9iwR23EaAYr
         H6lYrTR+Zrnl+kGsFZvT++5zuoOzbV8gnhmsgbBGe5rXO6dSRcjSllj2f3Ggjbjm8GLu
         T4aDk8RMLq5UiOUct0ToP7pkPv68IEd98ZUjY=
Received: by 10.204.151.209 with SMTP id d17mr3700329bkw.120.1257687655356;
        Sun, 08 Nov 2009 05:40:55 -0800 (PST)
Received: from localhost.localdomain (abwu61.neoplus.adsl.tpnet.pl [83.8.244.61])
        by mx.google.com with ESMTPS id 15sm427671bwz.0.2009.11.08.05.40.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Nov 2009 05:40:54 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nA8DerZr008787;
	Sun, 8 Nov 2009 14:40:53 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nA8DeqJF008784;
	Sun, 8 Nov 2009 14:40:52 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1257680442.14087.78.camel@owl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132400>

Bram Neijt <bneijt@gmail.com> writes:

> I would like to create release snapshots with a git tag like "v0.0.1".
> For proper Debian packaging, a release snapshot of tag "v0.0.1" would
> have to be named "project-0.0.1.tar.gz" and contain a single directory
> with "project-0.0.1/" in the archive.
> 
> Attached is a very dirty patch to the current head of gitweb.perl to
> change the snapshot if the requested hash has a tag which matches
> "m/^v(.+)\^0$/". This regular expression will probably have to be more
> strict then that in the future, but my main concern is the quality of
> the patch, and whether or not this feature is something the mainstream
> would appreciate.
> 
> My question to you all is: would this feature be considered as an
> addition, and if so what would be the best way to get this patch into
> shape for inclusion?

See Documentation/SubmittingPatches in git sources or in gitweb:
  http://git.kernel.org/?p=git/git.git;a=blob;f=Documentation/SubmittingPatches;hb=HEAD
Patch should be posted _inline_[1] (to make it easy to review the
patch), and should use _unified_ (diff -u) format (to make it possible
to apply patch correctly even if file changed in meantime) if you
can't install git and use it (git format-patch) to generate a patch.


By the way there is patch on git mailing list addressing part of
mentioned issue:
  "[PATCHv2 0/3] gitweb: Smarter snapshot names"
  Message-ID: <1257606809-23287-1-git-send-email-jnareb@gmail.com>
  http://thread.gmane.org/gmane.comp.version-control.git/132366
(earlier version of this patch can be found in 'pu' branch as merge
from 'mr/gitweb-snapshot' into pu).

This patch makes snapshot with name "project-version.tar.gz" to
contain single directory "project-version/" in the archive.  Snapshot
of tag *if requested* using 'refs/tags/v0.0.1' as 'h' (hash) parameter
would have "project-v0.0.1.tar.gz" as proposed archive filename...
but this patch doesn't make gitweb generate such links.


[1] In very rare cases such as troubles with whitespace, line-wrapping
    and encoding it might be better to attach it with text/plain
    mimetype.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
