X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sam Vilain <sam@vilain.net>
Subject: Re: selective git-update-index per diff(1) chunks
Date: Sun, 03 Dec 2006 10:08:47 +1300
Message-ID: <4571EB5F.7030300@vilain.net>
References: <b6fcc0a0612010323x7554e47m5e6bdafe85fc8224@mail.gmail.com> <slrnen04os.a5.Peter.B.Baumann@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 2 Dec 2006 21:09:05 +0000 (UTC)
Cc: git@vger.kernel.org, "Alexey Dobriyan" <adobriyan@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
In-Reply-To: <slrnen04os.a5.Peter.B.Baumann@xp.machine.xx>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33052>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqc6V-0005Nf-Uj for gcvg-git@gmane.org; Sat, 02 Dec
 2006 22:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162477AbWLBVI4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 16:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162478AbWLBVI4
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 16:08:56 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:54467 "EHLO
 magnus.utsl.gen.nz") by vger.kernel.org with ESMTP id S1162477AbWLBVIz (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 16:08:55 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534) id ECF3C139B0D;
 Sun,  3 Dec 2006 10:08:54 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.magnus.utsl.gen.nz [192.168.253.12])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by magnus.utsl.gen.nz (Postfix) with ESMTP id
 DF3691380C2; Sun,  3 Dec 2006 10:08:50 +1300 (NZDT)
To: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Sender: git-owner@vger.kernel.org

Peter Baumann wrote:
>> Now I want to commit them as two separate commits. So far, it's
>> * getting full diff
>> * cp(1)
>> * hand-edit both diffs
>> * commit first
>> * commit second

I made a patch to 'cg-commit -p' to do this, check the archives.

>> Relying on diff(1) definition of chunks is sorta hacky, though... I admit it.
> 
> I don't think it belongs in the plumbing, the git-update-index but I
> think something like this would be very usefull.
> 
> AFAIR darcs has this functionality. It selectively ask for each hunk if
> it should be commited. This would be awfull to have in git.

darcs and SVK both have this "interactive commit".

darcs also does something very useful with this; what amounts to
automatically making topic branches.  Currently there is no easy way to
manage that, either.

Sam.
