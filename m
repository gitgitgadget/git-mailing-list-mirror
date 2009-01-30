From: Elijah Newren <newren@gmail.com>
Subject: Re: [ANNOUNCE] EasyGit (eg) 0.97
Date: Fri, 30 Jan 2009 11:35:50 -0700
Message-ID: <51419b2c0901301035g6867b9d8l2d4de9590035bd4e@mail.gmail.com>
References: <51419b2c0901300842rb993454u7e8b6d1032c12ac8@mail.gmail.com>
	 <e2b179460901300859r438a4230hc990305688b4f29e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 19:37:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSyEv-0003SJ-23
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 19:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbZA3Sfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 13:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbZA3Sfx
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 13:35:53 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:33974 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbZA3Sfw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 13:35:52 -0500
Received: by yw-out-2324.google.com with SMTP id 9so224352ywe.1
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 10:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PXUAxMB3pDZaKZ/Sml9Qn8DIatjQ6/c5DUrJ7fwyP70=;
        b=Qq3L7PwMHaXijAV91wxidqP2r3v6izGDpjHTGPefQOiWFfQDbq2kncNt9pibl+ycbt
         7EVp/7MtscoIH4siY155eaDNMM+XHMTRsK4WvAT3LxCJNh7zPhDNL1+uPX6xPjRRfASZ
         gD7f33LfiJhMwMjcm7AB8PU/q3lDMxAaof8Dw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jJ6eT4OzNfmPnHIIWouFZESo5flO4Ze/yaWzhdfAqds4NpSm89/PZCVstsB1wmW8ZW
         LYxHzU9TfUwwuPU5PSPVXY3N+jfrHq3PSNc/KnDLNGWWvI36MVmYH1DAgH/3J3jEK5Ni
         jPptLTVmhtY/BpdtLH97No4+GTJAY5HByQl70=
Received: by 10.151.26.12 with SMTP id d12mr1441405ybj.104.1233340551039; Fri, 
	30 Jan 2009 10:35:51 -0800 (PST)
In-Reply-To: <e2b179460901300859r438a4230hc990305688b4f29e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107861>

On Fri, Jan 30, 2009 at 9:59 AM, Mike Ralphson <mike.ralphson@gmail.com> wrote:
> 2009/1/30 Elijah Newren <newren@gmail.com>:
>> [5] The bug I can only occasionally trigger and which I don't know the
>> cause of yet: when exiting from eg log the terminal settings sometimes
>> are messed up (with echo off and such), requiring a "reset" to get the
>> terminal back to normal.
>
> Are you sure that isn't this bug in git.git ?
>
> pager: do wait_for_pager on signal death
> http://article.gmane.org/gmane.comp.version-control.git/106728

Interesting.  I just went and tried out next (git version
1.6.1.2.418.gd79e6), which I believe has this patch...and after a
while I was still able to duplicate the eg bug on one of my
machines[1].  So it doesn't seem to be that particular issue, at
least.

Thanks for the pointer.

Elijah


[1] Output of stty after I trigger the eg/git bug:
speed 38400 baud; line=0;
lnext = <undef>; min = 1; time = 0;
-icrnl
-icanon -echo
