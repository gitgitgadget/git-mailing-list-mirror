From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: cannot see git-fetch result in gitk
Date: Sat, 01 Dec 2007 05:55:53 -0800 (PST)
Message-ID: <m3zlwuwmce.fsf@roke.D-201>
References: <475154DB.4040606@imap.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tilman Schmidt <tilman@imap.cc>
X-From: git-owner@vger.kernel.org Sat Dec 01 14:56:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IySpW-0001gM-SD
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 14:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbXLAN4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 08:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbXLAN4E
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 08:56:04 -0500
Received: from mu-out-0910.google.com ([209.85.134.189]:45348 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbXLAN4B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 08:56:01 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1149066mue
        for <git@vger.kernel.org>; Sat, 01 Dec 2007 05:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=aTuJ8eKMZrcMK1jhxo8lp1hef05c9ogJfIKbPRhejvg=;
        b=NkAd9MP+oP8RCh+e7HHKVIRFHdiJUMVDtY+wywsqZizn+1yOkYY18UW3opeRBEZaSk6iIWNl1zk5X0le4HZ6vhCsgVSfSzLAjXZJpcvFX3TYFP+mBitS+AbTidB6VrCMetyiypqBRVorihnd99b8B6krlC/ngSTf3NH3Yp8crko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=uFaTYhmD0fow1UGTnuUUOEOlPIcu7cWcesgEAGtnfPqCGEhFYSdFJjSMA89Dhu7rRo/P59gvgsDFwrQ0tHZX4fZbnE2JMc8dbmygIvzmW9oYRDGneLWedwg6avvN8/kcxF+h5ivdhqvI0UIGj9sCFaLhdc/qkE00xWRlpFjI4sg=
Received: by 10.86.4.2 with SMTP id 2mr8419715fgd.1196517354220;
        Sat, 01 Dec 2007 05:55:54 -0800 (PST)
Received: from roke.D-201 ( [83.8.236.184])
        by mx.google.com with ESMTPS id d4sm4739236fga.2007.12.01.05.55.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 01 Dec 2007 05:55:53 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB1DtlZT002411;
	Sat, 1 Dec 2007 14:55:48 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB1DtkdY002408;
	Sat, 1 Dec 2007 14:55:46 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <475154DB.4040606@imap.cc>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66716>

Tilman Schmidt <tilman@imap.cc> writes:

> I'm still learning my way around git and trying to understand how it
> works. So after reading
>   howto/rebase-from-internal-branch.txt
> I wanted to try and understand the command sequence
> 
> git fetch origin
> git rebase FETCH_HEAD
> 
> by looking at what it does with gitk. But after the first command I do
> not see any change at all in gitk. Only after the second one do the
> newly fetched objects appear in the gitk display.
> 
> Simple question: why?

Did you run just "gitk"? By default gitk displays only current branch,
while git-fetch changes remote-tracking branches only. Try 
"gitk --all", or "gitk origin/master ..." enumerating explicitely all
remote branches.

-- 
Jakub Narebski
Poland
