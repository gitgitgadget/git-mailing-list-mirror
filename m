From: Andreas Ericsson <ae@op5.se>
Subject: Re: custom diff - text file diary entries
Date: Thu, 30 Dec 2010 13:22:17 +0100
Message-ID: <4D1C7979.9050400@op5.se>
References: <AANLkTimPTYEWr0qQwYM4jmJSLcrLRt27GC0nTVgVzHK2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Zenaan Harkness <zen@freedbms.net>
X-From: git-owner@vger.kernel.org Thu Dec 30 13:22:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYHWW-0003mA-Rs
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 13:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945Ab0L3MWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Dec 2010 07:22:23 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48364 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab0L3MWX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Dec 2010 07:22:23 -0500
Received: by eye27 with SMTP id 27so4903976eye.19
        for <git@vger.kernel.org>; Thu, 30 Dec 2010 04:22:21 -0800 (PST)
Received: by 10.213.14.7 with SMTP id e7mr14066473eba.18.1293711740034;
        Thu, 30 Dec 2010 04:22:20 -0800 (PST)
Received: from [192.168.1.186] (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id q58sm11386968eeh.21.2010.12.30.04.22.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Dec 2010 04:22:19 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Thunderbird/3.1.7 ThunderGit/0.1a
In-Reply-To: <AANLkTimPTYEWr0qQwYM4jmJSLcrLRt27GC0nTVgVzHK2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164355>

On 12/30/2010 12:33 PM, Zenaan Harkness wrote:
> Problem:
> Separate text file diary entries, committed in separate repos,
> cause merge clash when pushed to central repo,
> since git thinks the two entries are a single conflicting entry
> (since they begin at the same location in the same file).
> 
> What we need is two diary entries automatically detected and inserted
> into the one file, one above the other (ordering is not so important).
> 
> Desired outcome:
> Two new diary entries - two separate insertions into the text file,
> not the conflict.
> 
> Is there an easy way I can automate this diary entry merging, so my
> users don't have to manually resolve the conflict?
> 
> Please note: SOMETIMES, one user will go and correct spelling and/ or
> grammar fixes in another person's diary entry, or in their own older
> diary entry - this is quite common.
> 

It seems like what you really need is a database backend for this that
you simply take normal backups from every once in a while, or a script
that produces the desired output on the fly from many different files.

If you really, really want to use git for this, you could create your
own custom merge driver. How to do so is reasonably well documented in
examples and man-pages. You'll want to sneak a peak at the attributes
page.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
