X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: master and origin
Date: Sun, 29 Oct 2006 22:29:32 +0100
Message-ID: <4d8e3fd30610291329n7fe59873r87cbee9ccbd4b720@mail.gmail.com>
References: <4d8e3fd30610291253s2d8000dfx942e0fa20e0057f6@mail.gmail.com>
	 <ei34qd$emn$1@sea.gmane.org>
	 <4d8e3fd30610291307v24f5aab8l3f447a1bfdf86ab4@mail.gmail.com>
	 <200610292219.21823.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 29 Oct 2006 21:29:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oOoVrXakgd+XVYmZhd7VMIPyo+RKgae7+tKJIKfZkeZn/lZVdD9Wet/k5gzNZVMtJOHK188HKuYiZSxQXGu7/EdMYpRhvcbNRnoOHyybfaxcmXXecuOPZKPwZ88kNna1Yn/jDIkuUTEgsRaYs5ZmVbj2AsRHI3YThs984DSjPOI=
In-Reply-To: <200610292219.21823.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30463>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeIDq-0001tD-4G for gcvg-git@gmane.org; Sun, 29 Oct
 2006 22:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030332AbWJ2V3f convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006 16:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbWJ2V3e
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 16:29:34 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:890 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1030332AbWJ2V3e
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006
 16:29:34 -0500
Received: by nf-out-0910.google.com with SMTP id c2so1990723nfe for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 13:29:32 -0800 (PST)
Received: by 10.78.151.15 with SMTP id y15mr3666952hud; Sun, 29 Oct 2006
 13:29:32 -0800 (PST)
Received: by 10.78.165.3 with HTTP; Sun, 29 Oct 2006 13:29:32 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On 10/29/06, Jakub Narebski <jnareb@gmail.com> wrote:
> > There is still one thing I don't understand, if I pull the git or
> > kernel repository all the local branches are updated according to t=
he
> > remote branches, right? If I'm hacking on master what will happen t=
o
> > my local changes?
>
> With the default setup (git clone without --use-separate-remote), the=
n
> all local branches are updated according to remote branches... with t=
he
> exception of remote 'master' branch which updates local 'origin' bran=
ch.

OK, I see.

> pull =3D fetch + merge, so if you pull when you are on your local 'ma=
ster'
> branch (and 'master' branch is first in the .git/remotes/origin file =
I think)
> you would fetch remote 'master' into local 'origin' and merge what yo=
u
> have in 'origin' into your 'master' (or merge remote 'master' into
> your local 'master' if you want to think like that).

So in this case, there is a difference between doing my local
development under master or myownlocalbranch. Right?
I mean, if I do my own development under master and I pull, the master
branch will include origin and my local changes. Corret?
While if I work in my local branch the datas are not modified with a
pull, because pull will update only the local copy of the remote
branch. Correct?

> If you have uncommitted changes git would probably refuse the merge.
> If you made changes to one of the tracking branches (e.g. 'next' or
> 'origin'), git would refuse to fetch into this branch (unless forced)=
=2E
>
> HTH

It does, a lot!

Ciao,
--=20
Paolo
http://docs.google.com/View?docid=3Ddhbdhs7d_4hsxqc8

Non credo nelle otto del mattino. Per=F2 esistono. Le otto del mattino
sono l'incontrovertibile prova della presenza del male nel mondo.
