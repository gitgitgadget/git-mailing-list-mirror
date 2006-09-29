From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git and time
Date: Fri, 29 Sep 2006 22:58:14 +0200
Message-ID: <200609292258.14294.jnareb@gmail.com>
References: <20060926233321.GA17084@coredump.intra.peff.net> <20060927002745.15344.qmail@web51005.mail.yahoo.com> <7vodt2nmft.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 29 22:58:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTPQz-0001PL-EB
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 22:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWI2U6H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 16:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWI2U6H
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 16:58:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:55136 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751102AbWI2U6E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Sep 2006 16:58:04 -0400
Received: by ug-out-1314.google.com with SMTP id o38so315768ugd
        for <git@vger.kernel.org>; Fri, 29 Sep 2006 13:58:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nZNfbF3spbtXJqG75jkZn/AG+jkiSMqp2hq7eYFOm8lK5KxIhsJO1doHQbiUFwGTRvv7nEff4KZnxkVuJmp+CUxfKh69MebynAdx4EZgj8ztdLYE8+T7AsiCbkIb1vAnjlMgvSnvE8ZWwlYEfyg04f8k7URijbsNI9xvpwbWCDQ=
Received: by 10.67.100.17 with SMTP id c17mr269823ugm;
        Fri, 29 Sep 2006 13:58:02 -0700 (PDT)
Received: from host-81-190-23-206.torun.mm.pl ( [81.190.23.206])
        by mx.gmail.com with ESMTP id x26sm2131408ugc.2006.09.29.13.58.01;
        Fri, 29 Sep 2006 13:58:02 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <7vodt2nmft.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28130>

Junio C. Hamano wrote:
> I somehow thought that it was possible to get "the latest tag
> that precedes this commit" (aka "git describe") for each commit
> by visiting its commitdiff_plain page, but I do not see it now.
> Can somebody tell me if I am hallucinating?

No, as of now "commitdiff_plain" or "commit_plain" view shows either 
git-name-rev information, or just tag if the tag points exactly at 
given [child] commit, not git-describe information. Although it would 
be fairly easy to add this information, though...
-- 
Jakub Narebski
Poland
