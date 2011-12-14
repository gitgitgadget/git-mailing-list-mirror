From: Andreas Ericsson <ae@op5.se>
Subject: Re: Is it "GIT" or "Git" or "git"? Standardize documentation?
Date: Wed, 14 Dec 2011 02:01:21 +0100
Message-ID: <4EE7F561.2040601@op5.se>
References: <20111214004332.GA8464@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sebastian Morr <sebastian@morr.cc>
X-From: git-owner@vger.kernel.org Wed Dec 14 02:01:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RadDx-0006Fn-SC
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 02:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756240Ab1LNBB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 20:01:29 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:47042 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753563Ab1LNBB3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2011 20:01:29 -0500
Received: by lagp5 with SMTP id p5so109965lag.19
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 17:01:27 -0800 (PST)
Received: by 10.152.104.6 with SMTP id ga6mr284114lab.45.1323824487363;
        Tue, 13 Dec 2011 17:01:27 -0800 (PST)
Received: from vix.int.op5.se (m83-182-21-101.cust.tele2.se. [83.182.21.101])
        by mx.google.com with ESMTPS id jb5sm726099lab.15.2011.12.13.17.01.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Dec 2011 17:01:26 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.24) Gecko/20111108 Fedora/3.1.16-1.fc14 Thunderbird/3.1.16 ThunderGit/0.1a
In-Reply-To: <20111214004332.GA8464@thinkpad>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187088>

On 12/14/2011 01:43 AM, Sebastian Morr wrote:
> Okay, I'd like to hear opinions on this before creating a patch.
> 
> My perception is that "Git" is the name of the software, whereas "git"
> is used to refer to the actual command. But "GIT" is all over the
> documentation as well, most prominently at the top of README.
> Would anyone mind if we replaced all occurrences of "GIT" in the
> documentation with "Git"?
> I suppose the release notes shouldn't be touched for historical reasons.
> 

I doubt anyone cares all that much. I for one have absolutely no clue
what you're talking about, but if you think it looks better one way
than the other and care about it enough, just make the patch and send
it in for review. Consensus is never reached before there's code, and
hardly ever after either, but discussing something that *might* happen
and still doesn't affect my daily life feels utterly pointless.

> Completely unrelated: Why is it "Documentation/RelNotes" and not
> something like "documentation/release-notes"? Almost everything else is
> spelled either all-lower- or all-uppercase.
> 

For tab-completion and directory listing reasons. Uppercase-D+tab puts
you in the right directory and uppercasing RelNotes makes it easy to
find among its many companions in that directory. It's fairly standard
procedure in the unix world to uppercase or camelcase the more important
documents, and especially when there's more than a small handful of files
in a single directory.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
