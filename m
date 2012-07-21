From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: pushing branches
Date: Fri, 20 Jul 2012 23:10:56 -0300
Message-ID: <CACnwZYdUzk74znPs4F+xz3haA3QhA9-DbR3mWWEVMfnztp-oCA@mail.gmail.com>
References: <CACnwZYdqP_ptj0++dj5NkCoKWKHiLEj+c0t7zrmNidkHsyzMgw@mail.gmail.com>
	<7vhat2toz8.fsf@alter.siamese.dyndns.org>
	<CACnwZYchBpSsvfY_-cu33dmPateNPgYaPr822Ri=Xn6=V0OOnA@mail.gmail.com>
	<CAJsNXTkH6wRgH9g4BCZVxKz9ntf0P_Y81kc+bAhcchkQM3+3Bw@mail.gmail.com>
	<CACnwZYe03VzR0=m6oCo8X6y=iiLkZXi+xQpvW9goya0roU+PFQ@mail.gmail.com>
	<CAJsNXT=-Ap0zJqK2F_3uJ7secmq7uvnSc218x+NoYdO5pLJAMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: PJ Weisberg <pj@irregularexpressions.net>
X-From: git-owner@vger.kernel.org Sat Jul 21 04:11:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsPAM-0000Ii-Hk
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 04:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643Ab2GUCK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 22:10:58 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52117 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517Ab2GUCK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 22:10:57 -0400
Received: by obbuo13 with SMTP id uo13so5689947obb.19
        for <git@vger.kernel.org>; Fri, 20 Jul 2012 19:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0Tg+zk8tywssQtOUl1lyLyu85DeGssRBRXay/Z8nT7g=;
        b=kBQSuH8fmlXrZGuC6y3ujuWVDQxPLeMexIVPc/CsEC0WFbOWFCWi5bHXX8TQ7qiUZE
         OupLByoEpwlnvYgYZGYWvOe03MzsqQgG5yqgwGBQMS2MgjDwvhbcPahw6ylbCDZ5Tq4x
         IHTCQHio2x81KDPv9bHa0hb8svmubS0BF7vBCV6cgVUAwJEMlIfCoX/HnH1q9XM5DiKU
         74T1C73SrJqscecla4sgXPCuz+4XN3lxDixe/QsjBslB3YfsFl8SYTku0Q7B4lh0PHfq
         yhsKWM9c7mALn+LKVjbUmav91kURwVHJYryJPkUyRib/og0WhHkW104RW5rGEIiArJkd
         X0mA==
Received: by 10.60.30.101 with SMTP id r5mr9740059oeh.68.1342836656581; Fri,
 20 Jul 2012 19:10:56 -0700 (PDT)
Received: by 10.182.212.67 with HTTP; Fri, 20 Jul 2012 19:10:56 -0700 (PDT)
In-Reply-To: <CAJsNXT=-Ap0zJqK2F_3uJ7secmq7uvnSc218x+NoYdO5pLJAMg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201801>

On Fri, Jul 20, 2012 at 10:58 PM, PJ Weisberg
<pj@irregularexpressions.net> wrote:
> In your original email, you had one command that did what you wanted
> and one that didn't.
>
> $ git push origin master
> $ git push origin feature-work
>
> Can you spot the difference between them?
>
Do'h, now I can see the idiocy that I was doing.

If I'm understanding this better,
$ git push origin master
tells git to push to remote origin, the contents of my master branch.

And then,

$ git push origin feature-work
tells git to push to remote origin to push the contents of feature-work branch.

Hence does not make sense to ask git to do "push origin master" while
inside feature-work branch.

> Like Konstantin said, you can look into the different options for
> push.default, but don't expect Git to push one branch when you told it
> to push another.
>
> -PJ
>
> Gehm's Corollary to Clark's Law: Any technology distinguishable from
> magic is insufficiently advanced.
