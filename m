From: "Zorba" <cr@altmore.co.uk>
Subject: Re: user manual question
Date: Mon, 29 Dec 2008 16:38:30 -0000
Message-ID: <gjauel$94s$4@ger.gmane.org>
References: <gj7mmo$fvk$4@ger.gmane.org> <slrnglf3qh.c7j.sitaramc@sitaramc.homelinux.net> <gj96pl$885$4@ger.gmane.org> <slrnglg90m.olt.sitaramc@sitaramc.homelinux.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 17:40:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHLAE-0003bu-1i
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 17:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbYL2QjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 11:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbYL2QjD
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 11:39:03 -0500
Received: from main.gmane.org ([80.91.229.2]:33964 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846AbYL2QjB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 11:39:01 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHL8n-0000bZ-V6
	for git@vger.kernel.org; Mon, 29 Dec 2008 16:38:54 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 16:38:53 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 16:38:53 +0000
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104110>

so a detached HEAD is just a HEAD that is not sitting on a tip ?

i.e. if I do $ git reset --hard HEAD^

...pointing HEAD to the previous committ

this is a detached HEAD

(I thought a detached HEAD was maybe a head somewhere on another branch not 
"reachable", i.e. a sibling, not a ancestor...
or something like that)


thanks guys

"Sitaram Chamarty" <sitaramc@gmail.com> wrote in message 
news:slrnglg90m.olt.sitaramc@sitaramc.homelinux.net...
> On 2008-12-29, Zorba <cr@altmore.co.uk> wrote:
>> Hi Sitaram!
>>
>> Thanks for clearing that one up.
>
> you're welcome; we've all done a bit of struggling I guess!
>
>> Also, I did wonder about HEAD and head. One can move, the other doesn't!
>> (well, acually it does - head moves "forward", as the tip of the branch
>> grows)
>
> Here's an extract from my notes/internal talks on this:
>
>    === basic concepts
>      * a branch is "an active line of development"
>      * //master//: default branch in a project, by convention
>      * //head//: tip of a branch
>      * a repo can track many branches, but the working tree is associated 
> with
>        only one branch at a time
>      * //HEAD//: tip of the branch associated with the working tree; this 
> is
>        where commits go
>        ** except when it's "detached"
>
>> Thanks for your other post/reply too - I will be getting back to you on 
>> that
>> one
>
> Glad to be of help.  I don't consider myself a guru, and am
> constantly waiting for one of the real gurus to strike me
> down with a thunderbolt for saying something stupid :-)
> 
