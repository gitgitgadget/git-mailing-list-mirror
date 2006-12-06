X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Graham Percival <gpermus@gmail.com>
Subject: Re: git newbie problems
Date: Wed, 06 Dec 2006 00:01:01 -0800
Message-ID: <457678BD.3050609@gmail.com>
References: <4574AC9E.3040506@gmail.com> <4574BF70.8070100@lilypond.org> <457611B9.9020907@gmail.com> <el5608$952$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 08:01:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ue77Ydi9z+8zstqLoJdvL/xy+ykL3s4Oj6yem6oJ7W6yjI/eoyjHV+KK9eTbewHdlpbqVZQorLtCPSBuHj4r5GLu5JEkNxbrMC8/1xyv70amz5lc1ct0Abe/xcYLSswebzB8wcEh78m2d6ZfpouSkmtmOzjrJqm/LIPgA6T3s3w=
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
In-Reply-To: <el5608$952$2@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33406>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrriV-0002nK-2m for gcvg-git@gmane.org; Wed, 06 Dec
 2006 09:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760290AbWLFIBH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 03:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760287AbWLFIBH
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 03:01:07 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:34809 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760290AbWLFIBG (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 03:01:06 -0500
Received: by ug-out-1314.google.com with SMTP id 44so65803uga for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 00:01:04 -0800 (PST)
Received: by 10.78.128.11 with SMTP id a11mr351426hud.1165392064256; Wed, 06
 Dec 2006 00:01:04 -0800 (PST)
Received: from ?192.168.1.139? ( [207.216.3.102]) by mx.google.com with ESMTP
 id y18sm31362894hua.2006.12.06.00.01.03; Wed, 06 Dec 2006 00:01:04 -0800
 (PST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> Graham Percival wrote:
> 
>> flailed around looking for magic commands to make things work.  By "make 
>> things work", I mean imitating my work style with cvs:
> 
> Perhaps it would be better to at least read cvs-migration.txt
>   http://kernel.org/pub/software/scm/git/docs/cvs-migration.html
> and all tutorials.

I skimmed through the cvs-migration, the tutorial (part 1 and 2), and 
the "everyday git".  I didn't notice any "how to deal with merges 
problems"... it was unfortunate that the merge problems arose the very 
first time I tried to upload my changes.  If I had used git for a few 
days before it happened, I would have had more confidence to track down 
the problem (or email for help earlier!).

> There are some commands which CVS didn't have, and which are very useful
> with git: I'm talking here about "git show" (show latest change), "git
> log" (show kind of changelog), and gitk (graphical history viewer) or qgit
> (alternate graphical history viewer in Qt).

Yes, I don't doubt that git has many improvements -- the main developers 
of my project must have had some reason for moving away from cvs!  I'm 
speaking as a new user who wants to get very simple work done.  All I 
wanted to do was to fix a few typos in the lilypond documentation; the 
information about importing cvs projects or changing branches obscured 
the stuff I really wanted.


> Yes, the git error messages certainly needs to be made more user-friendly.
> What git says here that one version has '.gitignore' file handled by version
> control, and second has it outside version control. At least I think what
> it does. "git ls-files --unmerged" or "git diff --merge --summary" should
> show 'true conflicts'.

Thanks for the suggestions!

> By the way, which version of git do you use? I think this particular check
> (if it is the case of this error) was relaxed.

git version 1.4.4.1
I installed it via fink/unstable on OSX.

Cheers,
