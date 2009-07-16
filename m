From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC 1/2] Add 'git subtree' command for tracking history of 
	subtrees separately.
Date: Thu, 16 Jul 2009 18:27:40 -0400
Message-ID: <32541b130907161527l1955bf06pf54b5099a5988c65@mail.gmail.com>
References: <1240784983-1477-1-git-send-email-apenwarr@gmail.com> 
	<32541b130904291927m33908bacg2dbafcf64877b88f@mail.gmail.com> 
	<20090430085853.GA21880@pvv.org> <32541b130904300732i691800f5kecc2f845584071c1@mail.gmail.com> 
	<loom.20090716T160021-218@post.gmane.org> <32541b130907161134n51e070a1l93690d1b8a63bee8@mail.gmail.com> 
	<cdea6cd10907161509g7771c72bl608b1924785b49fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andrey Smirnov <allter@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 00:28:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRZQv-0005xz-Iz
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 00:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933474AbZGPW2C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jul 2009 18:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933472AbZGPW2C
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 18:28:02 -0400
Received: from mail-yx0-f184.google.com ([209.85.210.184]:61411 "EHLO
	mail-yx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933471AbZGPW2A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jul 2009 18:28:00 -0400
Received: by yxe14 with SMTP id 14so762298yxe.33
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 15:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0r6YZ3+FDYg5pfDsOy2KtZ63I3jo80SzEz6ayV7/qFU=;
        b=phgTh8sDpNCWuu+6o5BWkyOOK3OSo/kWzfKS3RwR+OS0IPvrDTRuYlqxtqgP7rmx14
         Z+3HkSFoNmPdOU/AjTRI8jrAeKOt5gCMLRda/d4ZHImOaTmLSKuSi9Y23R3nrnABfd6A
         xRZO8ZOgycztPS3rBzDx5enw+AAphIdFCEnV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=js+4rTWgRAohJ9I35TuSzxNVSQivTfXTOxCLqAs1P62C9tgBOfX6ihnV/RzZ75KPMe
         VXLdlLj39x0/4WUA3jsVCNLi1QFwYMfzRfVuQ8DthT6LkZGANTSTMWh4O0IttXnO8mUB
         fsYDmML36TzND+1BVeORoWeSRctG/nZNgWDIw=
Received: by 10.150.123.18 with SMTP id v18mr702586ybc.104.1247783280088; Thu, 
	16 Jul 2009 15:28:00 -0700 (PDT)
In-Reply-To: <cdea6cd10907161509g7771c72bl608b1924785b49fc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123432>

On Thu, Jul 16, 2009 at 6:09 PM, Andrey Smirnov<allter@gmail.com> wrote=
:
> On Thu, Jul 16, 2009 at 10:34 PM, Avery Pennarun<apenwarr> wrote:
>> I don't think that's a good idea. =A0git-subtree is completely separ=
ate
>> from rebasing, and doesn't deal with patches at all. =A0Maybe there
>> should be some kind of "force-update" option that does what "git
>> subtree add" does, but wiping out everything in the subtree before i=
t
>> starts. =A0That would have simplified the above commands a bit.
>
> The only thing that links git-subtree with git-rebase is the fact, th=
at
> git-subtree "knows" the target commit for rebases dealing with subtre=
es.
> So if one knows commit of a subtree that he wishes to see in superpro=
ject
> (in my case "test-split") he could issue:
> =A0 =A0git subtree rebase --prefix=3Dlib OldProject test-split
>
> Though simple:
> =A0 =A0git rebase --onto OldProject test-split-old test-split
> worked for me, I think this was a lucky coincidence because of simpli=
city
> of my library commits.

I don't really understand what you're asking for here.  rebase doesn't
have any parameters called a "target."  What does git-subtree know
that you don't know?

Have fun,

Avery
