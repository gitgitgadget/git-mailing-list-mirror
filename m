From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: FEATURE REQUEST: Comment assignment on branches
Date: Tue, 16 Mar 2010 21:36:43 +0700
Message-ID: <fcaeb9bf1003160736w7749f358p6ee8f86e6c3a32c6@mail.gmail.com>
References: <be8f531d1003150133n3ea64109u7d573dbd533ffa48@mail.gmail.com>
	 <4B9EA22E.1010103@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Maxim Treskin <zerthurd@gmail.com>, git@vger.kernel.org
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Mar 16 15:44:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrY0Y-000529-8h
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 15:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934695Ab0CPOo3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Mar 2010 10:44:29 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:21848 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933060Ab0CPOo2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Mar 2010 10:44:28 -0400
Received: by qw-out-2122.google.com with SMTP id 8so145qwh.37
        for <git@vger.kernel.org>; Tue, 16 Mar 2010 07:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=byxz/ddCgFJK9HYIeNA5OjjitP4ES1OEta7TR3I9P/c=;
        b=FlH8EOaJhL2MRUnJmd3goWdTrqDKklQW2MreHCGE2BEnPRoa9DS/3JC0Jti9B8iRE9
         Ggz83t4SJ3BAwWcCWmXmQeCMOm+Vy0LRBHF4CKJ6IZRyW7XY64kcaiOGgtPS2KEn6vFa
         ba9cP4ZiLdMAhohX3FMfMEKpFiaUOftOk2gJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=baI7oMSqv702WTUeGiSY8r5UhWucYFaoDiZzYhx7zhMhE02PCkpkAt/hAA2DWTATVa
         1soz3lBJDCa/fm13xrQriFWXycH6dDYnAKSlVzdhQurlLtggq36Jzf2VvqQQfxt4jYEa
         ZeT6cHzHt213ektWFRGHPeD1s/v+cxPLLNKiw=
Received: by 10.229.130.206 with SMTP id u14mr2904qcs.74.1268750204266; Tue, 
	16 Mar 2010 07:36:44 -0700 (PDT)
In-Reply-To: <4B9EA22E.1010103@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142337>

On 3/16/10, Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
> Am 15.03.2010 09:33, schrieb Maxim Treskin:
>
> > Hello
>  >
>  > Is it possible to add comments assignment to branches?
>  > Something like:
>  >
>  > $ git branch --comment=3D"New branch with implementation of some f=
eatures" br14
>  >
>  > $ git branch
>  >   br14
>  > * master
>  >
>  > $ git branch --comments
>  >   br14           (New branch with implementation of some features)
>  > * master
>  >
>  > and when configuration variable branch.comments =3D=3D true, this =
behavior
>  > is default.
>
>
> Hmm.  You could name your branch
>  "br14/new-branch-with-implementation-of-some-features" instead of
>  "br14".  With command line completion you would only have to hit two
>  extra keys (slash tab) and could enjoy a meaningful branch name ever=
ywhere.

If only completion works across shells. Another idea: put notes in a
blob, tagged with "notes/branchname" or another convention.

Then if you want to see description of branch "br14", do "git show
notes/br14". Teaching "git branch" to show it is easy.
--=20
Duy
