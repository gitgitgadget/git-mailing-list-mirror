From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Changing indents
Date: Fri, 21 May 2010 09:30:13 -0700 (PDT)
Message-ID: <m3vdahqkuw.fsf@localhost.localdomain>
References: <C0CDDC0A-A813-41C3-8CEC-40EFADFB5A4A@kellerfarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Fri May 21 18:30:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFV7G-0001Oz-0Q
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 18:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933741Ab0EUQaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 12:30:19 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40113 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758503Ab0EUQaP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 12:30:15 -0400
Received: by fxm5 with SMTP id 5so1021981fxm.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 09:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=EDKJql973VOJieWq3RrVfd75W3J+fA351pGymeZUV6o=;
        b=ST7IwkZCFwWGf3Mk4ptSG0ZODIff4U+x+7UBzICcXFf/wmsZa+kz5kvXWIlaTETAVZ
         wwIrmEp1SmFykILvU7E5C4oWY+MlE+lkQD66XBnvVsWhvJRDhLdG6Bvo/Yjh34ZYX98K
         4/Ulj9Kl+RVa/0tWK9YMUuzHtaLd/a2PlCM/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=N+RKH1yjQbV//ykGpe3vO0xKfh90TuLG19y2qE/IURzrouYAaxnqtXjn9HWO+lKymW
         HK6zuF7nWXkVHghGyIyKB4jUCk9CTdlFCySjF708QF9PhjMGrN1a53MZQkLE5RqZQqf+
         a6YCjS1RyHXCNUzlVNY40KbQj+SgNE21pCpsw=
Received: by 10.223.54.140 with SMTP id q12mr1691357fag.50.1274459413687;
        Fri, 21 May 2010 09:30:13 -0700 (PDT)
Received: from localhost.localdomain (abvl111.neoplus.adsl.tpnet.pl [83.8.209.111])
        by mx.google.com with ESMTPS id j23sm5239509faa.2.2010.05.21.09.30.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 May 2010 09:30:13 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o4LGThs0011557;
	Fri, 21 May 2010 18:29:54 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o4LGTRdx011552;
	Fri, 21 May 2010 18:29:27 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <C0CDDC0A-A813-41C3-8CEC-40EFADFB5A4A@kellerfarm.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147481>

Andrew Keller <andrew@kellerfarm.com> writes:

> Is it possible to change the indent of a line (or multiple lines)
> without rewriting the whole line?  Or, more specifically, can a
> commit exist that modifies the leading whitespace of a line but
> still allows you to trace the origin of the line to a previous
> commit?

Whatever for?  Use "git blame -w <file>" (ignore whitespace).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
