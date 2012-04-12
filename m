From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: GSoC - Some questions on the idea of
Date: Thu, 12 Apr 2012 14:29:40 -0500
Message-ID: <4F872D24.8010609@gmail.com>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com> <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com> <loom.20120328T131530-717@post.gmane.org> <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com> <20120330203430.GB20376@sigill.intra.peff.net> <CA+M5ThR6jtxqs0-Kz-8fcRuOFRbLr-GvsJcTmrOQ7_geNspDLg@mail.gmail.com> <4F76E430.6020605@gmail.com> <4F772E48.3030708@gmail.com> <20120402210708.GA28926@sigill.intra.peff.net> <4F84DD60.20903@gmail.com> <20120411213522.GA28199@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Bo Chen <chen@chenirvine.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 21:29:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIPiO-0000ii-OT
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 21:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934629Ab2DLT3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 15:29:45 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49973 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934617Ab2DLT3n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 15:29:43 -0400
Received: by yhmm54 with SMTP id m54so1304175yhm.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 12:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ZJfTuMg0oRfTH+UjG3G3v4DJ8bSfyaVDG0IRspM9KkM=;
        b=fAHcSGpQP4o7ek2lSoe0YCyMYkpc4/t9wiEhMe5k3btoXkODhELIKQirnaG2mEZlSo
         Cq6XGCQ3Nbjz4pORHIshffe6x0O8fx3tkbLRJFpguLPfHirwE0AzxpoY9dacM3so5bBh
         EV+JpxFNc6qgJakpVHBION0ihB+NKIk72X60WeUurWIIxc5ikyM7wOLduBAaExIP86fL
         +00RxGNpdC+nG4FAo7q2vLxRCopbfLe+/9L85NM5+RzODcz4QlfAALxFiie609DfObl7
         cAYA2r4+cJkELSTBZPFSaa0i71LuFbBhyJRcP8rZxvFt+xAOd75InCRNc75XIVzm9XOl
         9Uyg==
Received: by 10.60.170.145 with SMTP id am17mr4696916oec.73.1334258982729;
        Thu, 12 Apr 2012 12:29:42 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id xb7sm7740100obb.10.2012.04.12.12.29.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Apr 2012 12:29:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <20120411213522.GA28199@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195357>

On 4/11/2012 4:35 PM, Jeff King wrote:
> On Tue, Apr 10, 2012 at 08:24:48PM -0500, Neal Kreitzinger wrote:
>
>> This is all theory to me, but the reality is looming over my head
>> since most of the components I should be tracking are binaries small
>> (large history?) and big (but am not yet because of "big-file"
>> concerns -- I don't want to have to refactor my vast git ecosystem
>> with filter branch later because I slammed binaries into the main
>> project or superproject without proper systems programming (I'm not
>> sure what the c/linux term is for 'systems programming', but in the
>> mainframe world it meant making sure everything was configured for
>> efficient performance)).
> So properly implemented, no, you would not have to ever filter-branch to
> tweak these settings. You might have to do a repack to see the gains
> (because you want to delete the old non-split representation you have in
> your pack and replace it with a split representation), but that is
> transparent to git's abstract data model.
>
I'm likely going to have to slam graphics files into the main repo in 
the very near future.  It sounds like once git.git is updated for 
big-file optimization I can just upgrade to that git version and repack 
to get the benefits.  Any idea when that version of git will come out 
release number wise and calendar wise?

(Don't read this next part if you just ate or are eating or drinking.  
You may throw-up from nausea or choke from laughing.)
(I am forced to deal with a mandated/micromanaged change control menu 
design from the powers-that-be that is based on cvs workflow and to 
wipe-your-nose-for-you.  It can't even cope with branches much less 
submodules so in that context there isn't time to implement the graphics 
tracking as a submodule.  This change control menu is designed to 
replace cvs commands with equivalent-results git-command sequences.  
While there are many git users who import from svn into git, do their 
work in git, and then export back into svn to get work done, ironically 
I am probably the only git user who has to import from git 
(powers-that-be mandated cvs-style menu controlled git-repo) into git 
(separate normal git repo and commandline), do the work in normal git, 
and then export it back into git (cvs-style menu controlled git-repo).)

v/r,
neal
