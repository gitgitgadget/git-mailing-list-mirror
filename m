X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: git newbie problems
Date: Wed, 06 Dec 2006 10:39:52 +0100
Message-ID: <45768FE8.2030202@xs4all.nl>
References: <4574AC9E.3040506@gmail.com> <4574BF70.8070100@lilypond.org> <457611B9.9020907@gmail.com> <el55to$952$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 09:40:17 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 24
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82-171-213-190.dsl.ip.tiscali.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <el55to$952$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33410>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrtGB-0005GF-HD for gcvg-git@gmane.org; Wed, 06 Dec
 2006 10:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760380AbWLFJkM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 04:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760384AbWLFJkM
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 04:40:12 -0500
Received: from main.gmane.org ([80.91.229.2]:57941 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760383AbWLFJkK
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 04:40:10 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrtFs-0003tN-In for git@vger.kernel.org; Wed, 06 Dec 2006 10:39:56 +0100
Received: from 82-171-213-190.dsl.ip.tiscali.nl ([82.171.213.190]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 10:39:56 +0100
Received: from hanwen by 82-171-213-190.dsl.ip.tiscali.nl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006
 10:39:56 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


Jakub Narebski escreveu:
>> 84219bb don't have input/templates/ any longer.
>> fatal: Entry '.gitignore' would be overwritten by merge. Cannot merge.
>> No merge strategy handled the merge.
>>
>> As a git newbie, I'm quite confused.  OK, there's no merge strategy...
>> so what do I do now?  With cvs, the changes would be dumped into the
>> file.  I look at the file, found the conflict, and tried it again.  I
>> got the same error message, and then it occurred to me that although I
>> changed the files in my ~/usr/src/lilypond, git might be storing these
>> files somewhere else.
> 
> Yes, the git error messages certainly needs to be made more user-friendly.
> What git says here that one version has '.gitignore' file handled by version
> control, and second has it outside version control. At least I think what
> it does.

Which is actually not true. .gitignore has been in the repo since we
started using git.  I have also seen this message pop up a few times
in the beginning, but I can't recall why they happened.

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
