From: "Alexandre Dulaunoy" <adulau@gmail.com>
Subject: Re: git-branch --print-current
Date: Sun, 4 Jan 2009 11:07:20 +0100
Message-ID: <1baa801f0901040207r64195594m64359dbc60a5f662@mail.gmail.com>
References: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git mailing list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 04 11:08:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJPuW-0002Vz-Tm
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 11:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbZADKHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 05:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbZADKHY
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 05:07:24 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:2871 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbZADKHX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 05:07:23 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2468686fgg.17
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 02:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2/gAdcCpBGq9hkL1UNuY5gChb66+6s91lJN1IH05VWc=;
        b=Qb3kme+tpKr+lb3A8ggrq4JNRDX8rX+vgHFx6VYotVEy+oEcacR2UBhS9mRIJc9eZV
         WEbAO/BaNmlnO6vl4BJLeFYpaQUX/7ktO4pczrgbPHPq7L7z+PjoNmxBP5mVict4oJu9
         yd8+hoVeB3u/qYf9ZO2J2c+yBy3u8y0ByQGnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Z9veL5TcHzIlZve5298feC3YOTMNr4h8FPswkL/NKqJ0A9RJ/MpuAOsEvSPa1HbrWw
         N/XEax9/xuFk488QbStBJOnTcSXygUhoQf6uKg7nyBBa5HRzbdD7k0o0TAmjMEXDb1CE
         wdnblSzteQ/bJPaS0bRwuEZLLiYuttd1xlpoA=
Received: by 10.86.4.14 with SMTP id 14mr4179437fgd.27.1231063640442;
        Sun, 04 Jan 2009 02:07:20 -0800 (PST)
Received: by 10.86.29.10 with HTTP; Sun, 4 Jan 2009 02:07:20 -0800 (PST)
In-Reply-To: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104504>

On Fri, Jan 2, 2009 at 4:28 AM, Karl Chen <quarl@cs.berkeley.edu> wrote:
>
> How about an option to git-branch that just prints the name of the
> current branch for scripts' sake?  To replace:
>
>    git branch --no-color 2>/dev/null | perl -ne '/^[*] (.*)/ && print $1'

I tend to support your request especially that extracting the current
branch is something that is done regularly. Looking in my own scripts/aliases
and some of my colleagues, there are plenty of variation using Perl,
sed, awk, tr
and Python to extract the current branch.

Using git-symbolic-ref is not obvious, especially that the summary/name
 of the man page is :

"git-symbolic-ref - Read and modify symbolic refs"

But the description is pretty clear :

"Given one argument, reads which branch head the given symbolic ref refers to
and outputs its path, relative to the .git/ directory. Typically you
would give HEAD
as the <name> argument to see on which branch your working tree is on."

But naturally, as a lazy user, you will pick git-branch especially
that's the tools is listed
with the most commonly used git commands with a very attractive description :

"branch     List, create, or delete branches"

On an user perspective, having the option in git-branch seems more natural.

Just a comment,

-- 
--                   Alexandre Dulaunoy (adulau) -- http://www.foo.be/
--                             http://www.foo.be/cgi-bin/wiki.pl/Diary
--         "Knowledge can create problems, it is not through ignorance
--                                that we can solve them" Isaac Asimov
