From: "Zorba" <cr@altmore.co.uk>
Subject: Re: getting started, happy with cmd line on windows [Scanned]
Date: Sat, 27 Dec 2008 02:18:45 -0000
Message-ID: <gj43am$fu6$3@ger.gmane.org>
References: <BB5F02FD3789B54E8964D38D6775E718242D07@ALTMORE-SVR.altmore.local> <495508B9.7070103@lsrfire.ath.cx> <gj3of4$pr3$3@ger.gmane.org> <7v4p0qlcnc.fsf@gitster.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 27 03:22:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGOpN-0006vQ-RH
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 03:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282AbYL0CTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 21:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752209AbYL0CTQ
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 21:19:16 -0500
Received: from main.gmane.org ([80.91.229.2]:50651 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752118AbYL0CTP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 21:19:15 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LGOlh-0000pV-OF
	for git@vger.kernel.org; Sat, 27 Dec 2008 02:19:09 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Dec 2008 02:19:09 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Dec 2008 02:19:09 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81.135.227.136
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103982>

> Drop "rm *.*".  Instead, probably what you want is
>
>> $ <import code>
>> $ git init
>> $ git commit
>
> which is a good way to make an initial import.
>
>> $ git tag versionA <commitID>
>> $ hack hack hack
>> ...
>
> and you futzed with the codebase without any intention of committing;
> it is nice to be able to experiment freely.
>
> After you are done experimenting,
>
> $ git reset --hard versionA
>
> if you did not make any commit, or even if you did commit while you were
> experimenting, if you do not want these experimental commits at all.
>
> No need for "rm *.*" anywhere.

Hi Junio,

Yes, I had not considered the possibility of being able to reset to last 
commit (as manual page talked about UNDOing commits). $git reset -hard HEAD 
= This is great, and gives me the functionality I want, get back to the last 
conscious commit after hacking.

I've noticed since discovering this that the Reset function on the Win GUI 
will ONLY let you reset as far as but not beyond the last commit (i.e. 
unable to undo any commits) so I can use that too.

The other functionality I was looking for is being able to handle a changing 
"portfolio" of files from version to version:

e.g.
version A = ABC.txt, AB.txt, AC.txt
version B = ABC.txt, AB.txt
version C = ABC.txt, AC.txt
version D = no files

I'm sure this is a common scenario, for ppl starting out with git as they 
load up versions that till now have been sitting in file systems.

By using git-add and git-rm (or git-commit -a) I was able to have my 
add/remove files to the index in "staging" and in the end the versions in 
the repo match up to real life example. Then I can --hard reset back to any 
of these, and ONLY got the files that were in that version.

Its a shame though that git-commit -a only removes files from the index, and 
doesn't add files to the index, otherwise creating new versions is just a 
case of importing the files needed for eacch version and cranking..

$ git commit -a

repeatedly.

But thanks to all who helped me on this one, and who knows maybe this post 
will help some other pilgrim following after me
:-)
Season's geetings,
CR 
