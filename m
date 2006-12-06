X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git newbie problems
Date: Wed, 6 Dec 2006 11:17:31 +0100
Message-ID: <200612061117.32903.jnareb@gmail.com>
References: <4574AC9E.3040506@gmail.com> <el55to$952$1@sea.gmane.org> <45768FE8.2030202@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 10:15:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PytFWgzBxSnEfryyblosKWPdCMl2AnaXTF2Z7It4q+NQ0T2f8diclR/WEjsmhJuvbbdiai7O3rsvOWumoHhWb9qrYA6qTKjV3BMT9b+ea7I9Oz/jsyZDFC23M5iawYuqFrs1PSywHGZ5TBeJgB4L1aJk7vzkxnxGKh8HhEeRgnw=
User-Agent: KMail/1.9.3
In-Reply-To: <45768FE8.2030202@xs4all.nl>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33424>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrtoK-0001Kt-Tx for gcvg-git@gmane.org; Wed, 06 Dec
 2006 11:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760430AbWLFKPa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 05:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760431AbWLFKPa
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 05:15:30 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:22991 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760427AbWLFKP3 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 05:15:29 -0500
Received: by ug-out-1314.google.com with SMTP id 44so93919uga for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 02:15:28 -0800 (PST)
Received: by 10.67.19.20 with SMTP id w20mr462368ugi.1165400128084; Wed, 06
 Dec 2006 02:15:28 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id c1sm29984617ugf.2006.12.06.02.15.27; Wed, 06 Dec
 2006 02:15:27 -0800 (PST)
To: Han-Wen Nienhuys <hanwen@xs4all.nl>, Graham Percival <gpermus@gmail.com>
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys wrote:
 
> Jakub Narebski escreveu:
>
>> Graham Percival wrote:
>>
>>> 84219bb don't have input/templates/ any longer.
>>> fatal: Entry '.gitignore' would be overwritten by merge. Cannot merge.
>>> No merge strategy handled the merge.
>>>
>>> As a git newbie, I'm quite confused.  OK, there's no merge strategy...

There is no merge strategy used, because problem (conflict) doesn't stem
from what was committed, but from what was in working directory.

>>> so what do I do now?  With cvs, the changes would be dumped into the
>>> file.  I look at the file, found the conflict, and tried it again.  I
>>> got the same error message, and then it occurred to me that although I
>>> changed the files in my ~/usr/src/lilypond, git might be storing these
>>> files somewhere else.
>> 
>> Yes, the git error messages certainly needs to be made more user-friendly.
>> What git says here that one version has '.gitignore' file handled by version
>> control, and second has it outside version control. At least I think what
>> it does.
> 
> Which is actually not true. .gitignore has been in the repo since we
> started using git.  I have also seen this message pop up a few times
> in the beginning, but I can't recall why they happened.

I don't know if git allows to pull into dirty tree with impunity. If I
remeber correctly Cogito (alternate UI for git) allows this[*1*], there is
currently work on this in git (but it is not as far as I remember in
git 1.4.4.1). So another possibility is induced by CVS "update then commit"
mentality pulling changes _before_ commiting changes.

If this is the case, committing changes _then_ pulling would solve this
problem.

Footnotes:
----------
[*1*] This is a bit error prone.
-- 
Jakub Narebski
