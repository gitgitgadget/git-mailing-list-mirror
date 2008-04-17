From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: crlf with git-svn driving me nuts...
Date: Thu, 17 Apr 2008 23:03:10 +0100
Message-ID: <320075ff0804171503g6dc04aa5pb7c9c362e31ce942@mail.gmail.com>
References: <20080416200107.GG3133@dpotapov.dyndns.org>
	 <20080416203923.GH3133@dpotapov.dyndns.org>
	 <320075ff0804161447u25dfbb2bmcd36ea507224d835@mail.gmail.com>
	 <20080416223739.GJ3133@dpotapov.dyndns.org>
	 <320075ff0804161607p3f9e983ehb75aae4e0bfe8837@mail.gmail.com>
	 <20080417004645.GK3133@dpotapov.dyndns.org>
	 <320075ff0804170007k5171eb72n68882679f62fa238@mail.gmail.com>
	 <20080417094342.GM3133@dpotapov.dyndns.org>
	 <320075ff0804170309h4232463fk984f362e6cf0a259@mail.gmail.com>
	 <20080417185357.GO3133@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 00:06:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmcD2-00040k-6C
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 00:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038AbYDQWDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 18:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753920AbYDQWDN
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 18:03:13 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:53239 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038AbYDQWDL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 18:03:11 -0400
Received: by fk-out-0910.google.com with SMTP id 19so321249fkr.5
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 15:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=IpArXbk2ZUPDZrJx1VUOVFoyzCqzgMibT6E16P3L0hs=;
        b=BLDqjNnx2A/wi2lvZzahcCEzyiuHxjoYTIr2M0N7pNIcoMsERy0oDVPQDf7oQPBeWKl8iTPaH5aZZ88rlBKnagM7hy3vKiGacx7Vrg32jXeHkkQ+LLTC7W69W7HCinWOQhg1DSUCzrNh58FZCKkaT3eHYApAwdAgpoOfSwRqWYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tRcacDOFu/hOUc5GBCPTsub6PQ49bTBJTi+Jf80z0kgiJLxX+9DlWj7vSszVjsqj3bSGZiEHXWN9KJyflBSBkNe8vnafRQunAmWlHm8ogRqm/BkXSD5TePAIcQJq1b6J176nDykzHS4Zkj0Hc/ShUW452xiWEr+IZyD29fhlhSg=
Received: by 10.82.123.8 with SMTP id v8mr3153263buc.83.1208469790603;
        Thu, 17 Apr 2008 15:03:10 -0700 (PDT)
Received: by 10.82.168.20 with HTTP; Thu, 17 Apr 2008 15:03:10 -0700 (PDT)
In-Reply-To: <20080417185357.GO3133@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79838>

>  lose anything and you can set eol=native later. Unfortunately, now SVN
>  users forget to set eol=native a way too often. So, IMHO, Git approach
>  based on heuristic is much better when most of stored files are text.
>

I agree - since the forgetful users includes us!

>
>  > so maybe it's just easier to coax those projects into fixing
>  > their svn repos (but of course it's not really an issue for them, so
>  > it might be a bit of a hard sell).
>
>  If they care about support different platforms then it _is_ issue
>  for them too. On the other hand, if everyone uses Windows with CRLF,
>  you can do that with Git too just by setting autocrlf=false.
>

Actually it seems to be less of an everyday issue- but I think it's
because the diff tools in use by programs downstream are probably
stripping CRs anyway before presenting diffs, so it all 'appears' to
be right. Certainly I've been sharing via a svn repo through Eclipse
with windows users for ages without it being a problem. Either way,
the problem in touched/untouched-files was the majority of my
confusion as I wasn't expecting to find a bug and was assuming I was
doing something wrong...

>
>  >
>  > Yes, in the sense that git is primarily a *nix tool, so it treats LF
>  > as canon
>
>  and perhaps even more important, it is written in C and where LF has
>  always been considered as EOL since the first Hello-World program was
>  written in C:
>
>    printf("Hello world!\n");
>  -----------------------^^
>
>  So, naturally LF is considered as EOL inside of Git. Actually, CVS does
>  so, and even SVN does if you set eol=native.
>
>
>  > and CRLF as somehow 'stupid' (I.E you could make an equally
>  > valid argument for the reverse position, it just depends on your
>  > perspective ;-)) ;
>
>  There is no good technical reason to have two symbols as the end-of-line
>  marker instead of one. Most programs on Windows just remove CR when read
>  from a file and then adding it back before LF when writing it back. So,
>  CR is clearly redundant.
>

Well.... Newline = LF vs CRLF (vs CR for early mac.. erk) dates to
well before C and UNIX; back into the days of baudot codes and
teletype printers that couldn't physically newline in the time taken
for 1 character to be processed; LF is meant to mean Line Feed and CR
is meant to mean "Carriage Return", so CRLF is in that sense quite
logical. But that's standards committees and backwards compatibility
for you :-/
