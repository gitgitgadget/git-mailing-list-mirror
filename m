From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: RFC: git diff colorization idea
Date: Fri, 23 Jan 2009 10:40:52 -0800 (PST)
Message-ID: <m3iqo5yiek.fsf@localhost.localdomain>
References: <53497057-1ADE-4300-9F35-B218959606FE@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 19:42:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQQz3-0008Dd-Vt
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 19:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758185AbZAWSk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 13:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757830AbZAWSk5
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 13:40:57 -0500
Received: from mail-ew0-f20.google.com ([209.85.219.20]:43743 "EHLO
	mail-ew0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757544AbZAWSk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 13:40:56 -0500
Received: by ewy13 with SMTP id 13so3890373ewy.13
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 10:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=RNtxahPR3feyPbDVwsBOpw0/UNBrEKT6Sq2VdVmtckg=;
        b=MDwgSbbVeIX8Ybb2qJRVSWU7IuFSgifqZDGtCbVi5w/KkDYNzBOwz7LF2PEC6AGwso
         B3gkbMFoBtRx68LH7U0R1qLfTnSkKa7PKpl08/P4vGewRf0eJqbbvO+ZOs7muRiM4Y72
         XNwsgIoJMmJa3M7zzV0NcCdMuZnN1MANf4z+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=SmypVj/t8ZeqeUzB7OpMctAiICiGwKNdOUJJsmSs4mcENvPGderP3qdC1lP4pWmqpw
         87e88N/rUtEBx+TPQX9C1kpBrCpWckkbBC6kPMkdTke8xCZfMxIn7+fAev4+nbv9tf6P
         xgl/yljWgnJXEsUzteaJUEanXjOVCnYRnoD1M=
Received: by 10.86.84.5 with SMTP id h5mr683877fgb.49.1232736053915;
        Fri, 23 Jan 2009 10:40:53 -0800 (PST)
Received: from localhost.localdomain (abwn47.neoplus.adsl.tpnet.pl [83.8.237.47])
        by mx.google.com with ESMTPS id 3sm7351111fge.57.2009.01.23.10.40.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Jan 2009 10:40:52 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n0NIfRap018706;
	Fri, 23 Jan 2009 19:41:27 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n0NIfN00018703;
	Fri, 23 Jan 2009 19:41:23 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <53497057-1ADE-4300-9F35-B218959606FE@wincent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106901>

Wincent Colaiuta <win@wincent.com> writes:

> Lately I've been wishing that Git's diff output were colorized in a
> way that combines the standard line-by-line colorizing with the word-
> by-word colorizing you get with --color-words.

I like this idea, also because Emacs ediff / ediff3 / emerge uses it,
from what I understand under the name of 'refinement'.

> 
> Pictures speak louder than words, so here are some to show what I mean:
> 
> http://www.flickr.com/photos/wincent-colaiuta/sets/72157612877491482/
>
[...]

There was some discussion in this thread on how to do this, whether
with --refine / --color-chars we shoud ony highlight differences, or
whether for example use reverse (i.e. background green or background
red), or other red / other green, or perhaps bold, or perhaps
underline to highlight regions in line which differ

> - Meld: http://meld.sourceforge.net/meld_file1.png

Not extremly good example, as it uses equivalent of context diff
format (-,+,!) with added, removed and _changed_ lines, and not
unified diff format (only added / removed lines).

> Would people be interested in seeing this feature go in? [...]

+1 from me
-- 
Jakub Narebski
Poland
ShadeHawk on #git
