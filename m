From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: git to libgit2 code relicensing
Date: Fri, 14 Nov 2008 22:46:31 +0100
Message-ID: <bd6139dc0811141346w194ae4c5m9f7b0fdb106108fc@mail.gmail.com>
References: <491DE6CC.6060201@op5.se>
	 <20081114213352.GA12134@auto.tuwien.ac.at>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Martin Koegler" <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Fri Nov 14 22:47:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L16W4-0006Qg-EG
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 22:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbYKNVqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 16:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbYKNVqd
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 16:46:33 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:8708 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbYKNVqd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 16:46:33 -0500
Received: by yw-out-2324.google.com with SMTP id 9so717935ywe.1
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 13:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=dHmm87wiNbhZ1dx7mIR8nUrJLwgdIvP6uUmnNc3rcQk=;
        b=FSmk0Jwe9g8CxcIoPNQOTZSBsufuZMcvP5hW9zWIWbuoWLQ0vfnnK5XpH6dXZyUkdj
         vfbqJeMw9SCceTvxiJII8Wp+iXlx5ikDNDZmo9m0y96lUyU95dtgJ9A2EeKHr2Q0+uXf
         Nh4Hpj+NUALG3EEZNWZvPeAnFannH9lt8kcnY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=s0sttwJf6gfy3JW2ormBLPrGnS7H1RtUs99HersECz+kj4jxwSxTCF4miAMufWcOgb
         1E4WQMeryP1rMOKzoyLNPpQFFhymPWrN+VvInfWTufrBJgpUSKR8QiH3icu/RAjCRHpC
         5IgdiIi443G4atFDJGIyHNzYGd39u5GN6vNk8=
Received: by 10.151.15.9 with SMTP id s9mr2614701ybi.70.1226699191650;
        Fri, 14 Nov 2008 13:46:31 -0800 (PST)
Received: by 10.150.149.14 with HTTP; Fri, 14 Nov 2008 13:46:31 -0800 (PST)
In-Reply-To: <20081114213352.GA12134@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101019>

On Fri, Nov 14, 2008 at 22:33, Martin Koegler
<mkoegler@auto.tuwien.ac.at> wrote:
> On Fri, Nov 14, 2008 at 09:59:56PM +0100, Andreas Ericsson wrote:
>> I've put everyone who "owns" more than 500 lines of code
>> on the bcc list, figuring your permission is important
>> but that you don't want the hundreds (well, one can hope)
>> of emails from people saying "ok". The list of major owners
>> was generated with "git showners *.c" in a worktree from
>> the next branch of git.git.
>
> I don't think, that your way for relicensing is bullet proof:
>
> I consider many of my GIT patches as derived work from other parts of
> GIT, even if git blame is stating me as author. I can gurantee you,
> that I comply with the "Developer's Certificate of Origin 1.1" point
> b, as its based on code out of git.git. But I can't tell you, from
> which files I reused code anymore.
>
> Probably other people did the same.
>
> Your method is ignoring such derived code.

Perhaps git stats can be of assistance here, it can summarize how much
lines a person changed (per file, or in total), that should be a
better metric (at least for code reused from within git.git, ofcourse
GPL-ed code taken from somewhere else is not covered).

-- 
Cheers,

Sverre Rabbelier
