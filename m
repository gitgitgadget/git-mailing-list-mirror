From: Wes James <comptekki@gmail.com>
Subject: Re: error running git-completion.bash on snow leo
Date: Fri, 17 Sep 2010 20:55:56 -0600
Message-ID: <AANLkTimmWJ7ZM109GhmZiJJ9riv0LMcQ=vx+1f-uT+=_@mail.gmail.com>
References: <AANLkTi=VtE9OPKx0+HobC7hcOjeNNMXBG2aQ8vj1FwR1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 18 04:56:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ownb4-0006iE-6k
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 04:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487Ab0IRCz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 22:55:58 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44493 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753826Ab0IRCz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 22:55:57 -0400
Received: by vws3 with SMTP id 3so1969492vws.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 19:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=V3CB9aOzMkhmD4BFhPzncVoUI7JhIOrF8SWN+l4tk1M=;
        b=o/E/gjt2yN0Dum3IhTSWylP2ddN527Ngdoa+ysKRSi+rWC0xQJXJrs7FLKo14QCAbG
         AC1gBEkJRZTQU+7qS1tgRJEhukm3UUkOWBsTINyXjW8UHpxFiYtnRdyyGEhPM32L7aCe
         6EFc/qq7BkRZWXWTiEMbWHiB9sjo/R7HCcD44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=td2nk5YuoJTQbR/LFdPCZirezzIFOIFrHhbpRKxkZUkz36qqcI5xr/aHpKdchDKFsw
         x1zerIWD7UNiFpAH0nLZQp7nr55Puy3eOKzLa0I9fWnqRYZ1HNpeYpvMYxf/f3lH4v45
         cIBbo1gUpFnLeMbriKj7/FW8u0wojYwjBxaKk=
Received: by 10.220.98.146 with SMTP id q18mr3371637vcn.113.1284778556838;
 Fri, 17 Sep 2010 19:55:56 -0700 (PDT)
Received: by 10.220.64.131 with HTTP; Fri, 17 Sep 2010 19:55:56 -0700 (PDT)
In-Reply-To: <AANLkTi=VtE9OPKx0+HobC7hcOjeNNMXBG2aQ8vj1FwR1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156423>

On Fri, Sep 17, 2010 at 8:29 PM, Wes James <comptekki@gmail.com> wrote:
> When I
>
> source git-completion.bash
>
> I get:
>
> -bash: git-completion.bash: line 127: syntax error near unexpected token `done'
> -bash: git-completion.bash: line 127: ` done < <(git config -z
> --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null
> | tr '\0\n' '\n ')'
>

never mind.  I renamed my .bashrc to .bashrc.orig and opened a new
terminal window and sourced git-completion.bash and it completed with
no error.  I must have had something conflicting with the
git-completion.bash file.

-wes
