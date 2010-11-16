From: demerphq <demerphq@gmail.com>
Subject: Re: Bogus error: Untracked working tree file '....' would be
 overwritten by merge. Aborting
Date: Tue, 16 Nov 2010 11:38:44 +0100
Message-ID: <AANLkTimAgDDkPowrfF2QNDdLaxHEyOPVgFy=5rafPWoj@mail.gmail.com>
References: <AANLkTinv7XsXNR2MMbaGAUo2=WgL6SEWkuzwGU_7YVn0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 16 11:38:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIIw7-0006sL-TW
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 11:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934230Ab0KPKir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 05:38:47 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43431 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932793Ab0KPKiq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 05:38:46 -0500
Received: by wwa36 with SMTP id 36so586979wwa.1
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 02:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Oa4GfVirVsOr4N8HavrTqOCv0or7NwCC615sp9Jelyw=;
        b=vGEBAxgV2sG+26czVMSYD0XW09CyhREXzCFkdxHV3xcLEItOGUudwXM8pqTM4mEvbd
         lmjJRTTt9B/nvyygJ2UxXM1QL2HmgDA1aGNtf7Bj7SQQak7zUqk1xju/ll1di2EGdg6P
         WF8GG74wjZDUuPvzeVmWJU+RhOzljJnkzfJeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=DVYHtHqf7Dg++3BW6aH7aveTbkatZXIIqSOH3AHzRzb7/4Dc1/F4CZp5mW8R0lHaNX
         2Eq6cmumbDtYDG6XAp2DjcwZ8We99vrDteE/u/ttVV6o4Us9UBXgAPK0ejP1u7k+mf/a
         wM1y2sOt3WYC++/HEepBIFZmO8K10l+EnHIOU=
Received: by 10.216.49.145 with SMTP id x17mr6394894web.55.1289903924470; Tue,
 16 Nov 2010 02:38:44 -0800 (PST)
Received: by 10.216.159.11 with HTTP; Tue, 16 Nov 2010 02:38:44 -0800 (PST)
In-Reply-To: <AANLkTinv7XsXNR2MMbaGAUo2=WgL6SEWkuzwGU_7YVn0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161554>

On 16 November 2010 11:26, demerphq <demerphq@gmail.com> wrote:
> The error in the subject line is generated if one has a git repo
> checked out to a commit that adds a new file and one does something
> like:
>
> git reset HEAD^
>
> and then a merge operation that involves going forward onto or past HEAD.

In fact there are more operations where this can happen.  A
failed/aborted rebase. A failed/aborted merge.  etc.

All of them, so far in my experience, resulting in this bogus error
about overwriting a file with itself.

cheers,
Yves



-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
