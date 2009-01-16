From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: how to edit commit message in history
Date: Fri, 16 Jan 2009 03:18:37 -0800 (PST)
Message-ID: <m34ozzzegn.fsf@localhost.localdomain>
References: <20090116035714.GA6984@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 12:20:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNmkA-0003EP-Fr
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 12:20:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763196AbZAPLSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 06:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762920AbZAPLSl
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 06:18:41 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:32931 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762706AbZAPLSk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 06:18:40 -0500
Received: by ewy10 with SMTP id 10so1834814ewy.13
        for <git@vger.kernel.org>; Fri, 16 Jan 2009 03:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=IOThPcQJmWbLHmgAKDRT8ri+QIHzJXSNtWByvKuGwII=;
        b=JGaCNxYIqEKYhiqHaPW+ZDRsWqdpWYNbMO7ax2etqtFhkDQ/xmT4+wqeLF0qwyfeNZ
         KnYVP6NH/CsfB0HoHHR/bzWNRRUIjJKnbQ3v0K7YjTsUHDk62fnyGXr9SfoHAhXD8QvR
         jU5xFxpLiIMz//HbpynM1NauZgDxb71inX7PE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=InHMUvHW4RXpLVm6bJVNHdSiNTurDylwT2XZIpyfaGFTmHXenJt/8w2UxZxacevwaS
         8/oLeP96xkxZyZ4FHZWqijaUYu01zYGjmZ5QOJOogCpyhmlm6cRYs9c0NX15to7jBwxo
         GFKfxaNwplbi6vxuLhfJf6w8lzfYEyaRHNCTc=
Received: by 10.210.127.10 with SMTP id z10mr2984779ebc.125.1232104718256;
        Fri, 16 Jan 2009 03:18:38 -0800 (PST)
Received: from localhost.localdomain (abrz200.neoplus.adsl.tpnet.pl [83.8.119.200])
        by mx.google.com with ESMTPS id 10sm2067739eyz.59.2009.01.16.03.18.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Jan 2009 03:18:37 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n0GBIZg8031784;
	Fri, 16 Jan 2009 12:18:35 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n0GBIWaW031781;
	Fri, 16 Jan 2009 12:18:32 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090116035714.GA6984@b2j>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105938>

bill lam <cbill.lam@gmail.com> writes:

> I made some typos in commit messages, how to edit them without
> affecting everything else?

If it is last commit that you want to edit, and if you didn't publish
this commit to soem public repository, you can simply use

  $ git commit --amend

If the commit is deeper in history, use "git rebase --interactive".
If you published commit, you are out of luck.

See http://git.or.cz/gitwiki/GitTips
-- 
Jakub Narebski
Poland
ShadeHawk on #git
