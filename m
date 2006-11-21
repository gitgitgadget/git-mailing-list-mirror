X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: Some tips for doing a CVS importer
Date: Tue, 21 Nov 2006 21:56:18 +0200
Message-ID: <456359E2.8010403@cc.jyu.fi>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com> <46a038f90611201503m6a63ec8ct347026c635190108@mail.gmail.com> <9e4733910611201537h30b6c9f4oee9d8df75284c284@mail.gmail.com> <46a038f90611201629o39f11f42ye07b86159360b66e@mail.gmail.com> <87vel9y5x6.wl%cworth@cworth.org> <9e4733910611201740i348302e6r84c3c27dc27e5954@mail.gmail.com> <20061121063934.GA3332@spearce.org>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 21 Nov 2006 19:56:52 +0000 (UTC)
Cc: Jon Smirl <jonsmirl@gmail.com>, Carl Worth <cworth@cworth.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Virus-Scanned: amavisd-new at cc.jyu.fi
User-Agent: Thunderbird 1.5.0.8 (X11/20061109)
In-Reply-To: <20061121063934.GA3332@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32030>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmbjD-0003cc-AM for gcvg-git@gmane.org; Tue, 21 Nov
 2006 20:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031356AbWKUT4U (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 14:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031360AbWKUT4U
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 14:56:20 -0500
Received: from posti5.jyu.fi ([130.234.4.34]:33495 "EHLO posti5.jyu.fi") by
 vger.kernel.org with ESMTP id S1031356AbWKUT4T (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 14:56:19 -0500
Received: from localhost (localhost.localdomain [127.0.0.1]) by posti5.jyu.fi
 (8.13.6/8.13.6) with ESMTP id kALJu9X1024684; Tue, 21 Nov 2006 21:56:09 +0200
Received: from posti5.jyu.fi ([127.0.0.1]) by localhost (posti5.jyu.fi
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 5V8ikpAhljN2; Tue, 21
 Nov 2006 21:56:08 +0200 (EET)
Received: from aragorn.kortex.jyu.fi (aragorn.kortex.jyu.fi
 [130.234.182.120]) by posti5.jyu.fi (8.13.6/8.13.6) with ESMTP id
 kALJu7pG024679; Tue, 21 Nov 2006 21:56:08 +0200
Received: from [127.0.0.1] (aragorn2.kortex.jyu.fi [127.0.0.1]) by
 aragorn.kortex.jyu.fi (Postfix) with ESMTP id B688A468EFB; Tue, 21 Nov 2006
 21:56:18 +0200 (EET)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
>   
>> brendan said SVN is likely for the main Mozilla repo and monotone for
>> the new Mozilla 2 work. No native win32 caused git to be immediately
>> discarded.
>>     
>
> Yea, that lack of native win32 seems to be one of a number of
> blockers for people switching their projects onto Git.
>
> I think there's a number of issues that are keeping people from
> switching to Git and are instead causing them to choose SVN, hg
> or Monotone:
>
>   - No GUI.
>   
QGIT allows using some commands. I plan to try out the GIT eclipse
plugin in near future myself.
This mail list have some discussion and download link to it's repo in
archives.
(title: Java GIT/Eclipse GIT version 0.1.1, )

>   - No native win32 installation.
>   - CVS import fails on some projects (e.g. Mozilla).
>   
Well, committing the files from Mozilla cvs to svn has also own problems.
SVN accepts only a text files which have either a "Unix" or DOS style
line endings.
If file contains a both some lines using "Unix" way and others using dos
way SVN roll's
back the commit and you need to tools like "dos2unix" or "unix2dos" to
manipulate those.
(And randomly changing all to either of those is propably not a good idea)

