From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: A couple of minor branching questions
Date: Mon, 23 Feb 2009 17:29:10 -0800 (PST)
Message-ID: <m3tz6kvd0b.fsf@localhost.localdomain>
References: <1235435927.12677.2.camel@rottwang.fnordora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alan <alan@clueserver.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 02:30:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbm8B-0000aK-8D
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 02:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbZBXB3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 20:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbZBXB3P
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 20:29:15 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:43099 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbZBXB3P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 20:29:15 -0500
Received: by fg-out-1718.google.com with SMTP id 16so36637fgg.17
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 17:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=b5KT7IyOmuCRdG1DbdkVQpqkElJ8j1zlXMTFRyau/SA=;
        b=eg087PsncOhQtzR6A0xdf6h+m17AHm0BWDgzAUDlu3RT41h9CW8QRFb+w3sMVxVBOj
         fV7HEs3+O4lsYNCRREmvKbFNVs6JeWR3eDQhmMT+yqvBtTuygBYJSoM+ZOd0SPBY0hp8
         0wQTdyeNasK16ulBdf7+nyUmpNccYjNdU1Erc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=e/astFbRDgnkUTj0jUZAfHmNEx6pL7ZS7B09EjyGOiRepJmEnpeHLy6bZy9fw6NU/1
         CnNVnVEXnyV5WDFAKnXJu290iUlpzzVQd6rzwYUZ1C+0nuv0sc6qirhUHH0qQPYEGlaw
         oqM8uxwNzVNJQFtdVs1gU6UNyJVxRZ7uta0lo=
Received: by 10.86.31.18 with SMTP id e18mr3320191fge.72.1235438951936;
        Mon, 23 Feb 2009 17:29:11 -0800 (PST)
Received: from localhost.localdomain (abve227.neoplus.adsl.tpnet.pl [83.8.202.227])
        by mx.google.com with ESMTPS id 4sm685673fgg.55.2009.02.23.17.29.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Feb 2009 17:29:10 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n1O1TBwl024867;
	Tue, 24 Feb 2009 02:29:12 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n1O1T8Q0024864;
	Tue, 24 Feb 2009 02:29:08 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1235435927.12677.2.camel@rottwang.fnordora.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111187>

Alan <alan@clueserver.org> writes:

> Is there an easy way to tell what commit a branch is branched off from?
> Also, it there a way to tell what branch the branch is branched off
> from? 
> 
> I know I can use gitk to give a visual diagram, but I want something I
> can feed into a program.

First you can check branch.<branchname>.merge configuration option
(with git-config) to check what branch (by _remote_ name) given branch
is based on.

Second, you can use "git merge-base <branchname> <second branch>" to
find common ancestor, i.e. branching point of two branches. By the
way, there is shortcut a..b and a...b for revision ranges: see
documentation in git-rev-parse (or was it git-rev-list?).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
