From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: git-svn condenses history when dcommit is interrupted
Date: Sat, 17 May 2008 10:35:06 +0600
Message-ID: <7bfdc29a0805162135m2758171dva6a6594239733bd8@mail.gmail.com>
References: <7bf6f1d20805150206j231eeea6pb7c608a713dd202c@mail.gmail.com>
	 <7bfdc29a0805150224j30db42d5te1f386efee0ff7a0@mail.gmail.com>
	 <7bf6f1d20805161402m4fa473f5w198bc8cb055eb95f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Jo=E3o_Abecasis?=" <joao@abecasis.name>
X-From: git-owner@vger.kernel.org Sat May 17 06:36:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxE9I-0000Ch-KW
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 06:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbYEQEfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 00:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbYEQEfJ
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 00:35:09 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:17652 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbYEQEfI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 00:35:08 -0400
Received: by yw-out-2324.google.com with SMTP id 9so695660ywe.1
        for <git@vger.kernel.org>; Fri, 16 May 2008 21:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RkLWllaSH7IZ9Eckxe2aqTIo9Gc3/uKruBG4RYHiIjk=;
        b=NJD4xkSXfrvtI6Y67oj1avrLpON+MdHPVx6qqwXZqMuXJ4S1a0FZsXnZS35XgWUkP7FAT7swifQCwtgdprjFwkCd9O7qIZ2i+yfhdb85bPsvyqQF2ucUSUwZQFeZAo3NdnTJvCZhc4yLKfo0cDY4HTHTcD7RjhrHZ1QglHBy6Rg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MGNw4BceigQH3BLWCM2ix4leORE0retxheKZjA4Y/QqX9uotO8XcfWtZLl4qXOmNPDRvGIrr99LBSWEmGQdaj/j83dkO4rOul3u87bX6rDmUEeXvbNeXDs4s9yCruGbc0UeRYj+uhLXuAxjLLoDhyZi4j12SmtYAc58YBmsh/Mg=
Received: by 10.150.83.29 with SMTP id g29mr4299934ybb.136.1210998906840;
        Fri, 16 May 2008 21:35:06 -0700 (PDT)
Received: by 10.150.54.11 with HTTP; Fri, 16 May 2008 21:35:06 -0700 (PDT)
In-Reply-To: <7bf6f1d20805161402m4fa473f5w198bc8cb055eb95f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82334>

>> Whenever my commit is not completed successfully I can thus easily
>> reset, rebase and follow the command sequence again. This way I have

I forgot to mention 'git svn fetch' if the commit succeeds and the update fails

> But that doesn't help with the problem I have faced, which is when
> dcommit fails *after* some change has already been committed to the
> subversion repository. At that point, the local copy of the subversion

Did you try 'git svn fetch' at this point

> history is broken since git thinks it has got the fetched the
> committed revision but it's not in the history.
> ....
> I think this is a bug with git-svn that should be fixed and I will
> gladly help fix it in any way I can. Do you think I should be more
> explicit and focus on the broken history instead of the "condensed
> merges"?

It could be a bug but I am not sure, what I am sure of is that I faced
a *similar* (not sure identical) problem and 'git reset' and 'git svn
fetch' followed by rebase, merge and dcommit was successful in my
case.

Best regards,

-- 
Imran M Yousuf
Email: imran@smartitengineering.com
Mobile: +880-1711402557
