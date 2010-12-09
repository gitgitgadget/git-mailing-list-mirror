From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other operators
Date: Thu, 9 Dec 2010 07:30:45 +0700
Message-ID: <AANLkTi=AyCxn=dcKQQmT0_6Oc36AX6XDA4Dhhk7WLSN0@mail.gmail.com>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com> <201012082047.44022.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 01:31:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQUPq-0005bj-Qf
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 01:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755318Ab0LIAbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 19:31:17 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51849 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905Ab0LIAbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 19:31:16 -0500
Received: by wwa36 with SMTP id 36so1828704wwa.1
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 16:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=4xLUixttpCm+idYf8f6zisYq6W7sfa/bVFO3sXQh0f8=;
        b=f8/X4nxms+9qo3qSgSOMvFpmmCO06+vLQxDlBd8bkv/DRyEfb8xUoPcV2Ek5xyiXBl
         yUTgOZ70hVL0f/k720tTRFbS8MFIiy6zLv3pEdzy14bSR+R4bYQIoRpz9FdDsloagmmM
         Lt0ykIRE8vn7zRoPu/+fzu9hfr+Ii0ViOohAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=f2HXUmv5OKWhDqbdcy0nz+GZEBNy3DaJ1Bi8zuNliFPJ18yEAWdJ5GDhIbmL+2bVQ8
         PtP665B6PU7MEJKFL3e1hM/q69HcBHudNpLfn9KIiva5Q4SZgK/+M8uVWsK71s4pfKdx
         XJdds5F8k6QcOMUZDnsMQgjN0SUa1heXkREsw=
Received: by 10.216.188.131 with SMTP id a3mr1269843wen.4.1291854675516; Wed,
 08 Dec 2010 16:31:15 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Wed, 8 Dec 2010 16:30:45 -0800 (PST)
In-Reply-To: <201012082047.44022.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163248>

2010/12/9 Jakub Narebski <jnareb@gmail.com>:
> I wonder if it would be possible to make :/<regex> (which looks a bit
> like searching the index) to be an alias to --all^{/<regex>}...

It looks a bit strange to my eyes to merge normal option name with
revision syntax. But I think it's possible. Do we allow branch/tag
name with leading '-'?

> Or if we can make ^{/<regex>} to act on revision range specified by
> earlier commits, so for example foo..bar^{/<regex>} would work.

There is another case: branch/tag selection. Instead of looking in all
refs, people may want to look only in nd/* branches. My branches are
almost flat, so I don't find any use. But someone might. And we can
solve the "all branches" case above with simply "*". The exact syntax,
I don't know.

> As to :/!<regexp> form: isn't it reserved for non-match?

It is reserved and not attached with any meaning.

> Thank you for working on this.

You're welcome. I needed to look for my branches in pu and was tired
of copy/paste.
-- 
Duy
