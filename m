From: Andreas Ericsson <ae@op5.se>
Subject: Re: Inexplicably deteriorating performance of Git repositories on
 Windows
Date: Wed, 24 Nov 2010 12:34:15 +0100
Message-ID: <4CECF837.1080404@op5.se>
References: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 12:34:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLDcR-0007kq-Du
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 12:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947Ab0KXLeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 06:34:20 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41678 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938Ab0KXLeT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 06:34:19 -0500
Received: by eye27 with SMTP id 27so5268839eye.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 03:34:18 -0800 (PST)
Received: by 10.213.14.148 with SMTP id g20mr488537eba.66.1290598458051;
        Wed, 24 Nov 2010 03:34:18 -0800 (PST)
Received: from clix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id b52sm6847895eei.7.2010.11.24.03.34.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Nov 2010 03:34:16 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10 ThunderGit/0.1a
In-Reply-To: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162059>

On 11/23/2010 08:08 PM, Dun Peal wrote:
> Hey,
> 
> We have a bunch of Windows users, unfortunately, and they're using the
> latest msysGit release (Git-1.7.3.1-preview20101002).
> 
> An interesting issue we've noticed is that the Time To Complete of
> their common operations start deteriorating inexplicably, and
> severely, some time after the clone.
> 
> For instance, immediately after a clone, `git status` takes about
> 5-6s. Which is slow compared to Linux (consistent 1-2s), but still
> usable (it's a BIG repo).
> 

How many refs (tags and branches) do you have?
Are the refs packed or loose?
If they are loose, does packing them resolve the issue?
Are you using network-mounted or local storage?
What does the .git/config file look like for a user where git status
is excruciatingly slow?
Does copying the config file from a windows user to a linux user make
timings somewhat consistent between various systems?
Do older version of git perform as poorly?
How is the repository laid out (ie, are there any directories with
a ton of files in, or are they spread across multiple directories)?
How many .gitignore files are you using, and what do they look like?

> However, after a reboot (of all things), `git status` latency
> skyrockets to 14-15s, making the repo unusable.
> 

That's just plain weird, and is almost certainly a system issue.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
