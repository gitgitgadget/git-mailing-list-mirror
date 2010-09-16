From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: git-p4
Date: Thu, 16 Sep 2010 15:54:03 +0200
Message-ID: <AANLkTik-jATT0vJagsXWfexPyKHFZ0oo7Qp95vpiqmCd@mail.gmail.com>
References: <4C8A8CE8.90600@borg.org>
	<20100910235323.773d2c5b@varda>
	<AANLkTinmG5BU+yswWQ8=cRKT5WL_h8vWuUCu2PjZYb87@mail.gmail.com>
	<4C8CF231.6090403@borg.org>
	<AANLkTi=yJ5kVA17+40xc6NpEczFjgmYh7=w5k=GL_U9w@mail.gmail.com>
	<4C8D14F9.90705@borg.org>
	<AANLkTi=NGsY3wDiTLwNLpw4TJMpiSY8A=az_=v2fYDLj@mail.gmail.com>
	<4C8D3303.1030302@borg.org>
	<AANLkTikrSt4djXep-o4Hr8EZAsiNXnqCHa2fLrys8T==@mail.gmail.com>
	<4C8E33DF.7010904@borg.org>
	<AANLkTimL3mB8LeUOANsJO7p9uwqDCN9wKnLVMTq_-=3H@mail.gmail.com>
	<4C8E511F.8000400@borg.org>
	<AANLkTingvEFDygkKipBXfCHJr2=oMQrYv3FKpxpo+TkW@mail.gmail.com>
	<4C920A1B.1030707@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kent Borg <kentborg@borg.org>
X-From: git-owner@vger.kernel.org Thu Sep 16 15:54:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwEuh-0004Kn-Vt
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 15:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811Ab0IPNyG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 09:54:06 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54125 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360Ab0IPNyF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 09:54:05 -0400
Received: by ywh1 with SMTP id 1so403410ywh.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 06:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=M7v63Qw7fDdIKDDb8I8qyfDiMRKBrabgRZ6vJPk0sk8=;
        b=Iv3hsTfAlp4ceEotEN+9iHDZLNvyYhRUrP/MrY8JEYGLXJZCSmXWhgE7CXdVNTaqrt
         ZJOf/g1VEvzYCMr+bodgXzQ4wsFC6aCUc/1TJefhqwsoxmViyM2z/7DAtWgW+bPm86Cl
         sno/suG0KuyI0nSxDJOJhB9o9jvHaH8BfSmwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YlbEih7UEoBrLV7obUUqfzrgOjc+XNRzjzIaVTJx/D2uLyjUMA7Lx8Lj0tymIEaBr4
         idMClAzLo4Zp5jF5JcXnk07xpAbC+gzyocQA3kL8lNIFzRctQ57iPa2DTvI2PlfD4FPZ
         5V5t1T1pPq/htf6VppkyWJ5G4CZBc94oFf6mM=
Received: by 10.150.157.7 with SMTP id f7mr3611334ybe.153.1284645243482; Thu,
 16 Sep 2010 06:54:03 -0700 (PDT)
Received: by 10.231.178.139 with HTTP; Thu, 16 Sep 2010 06:54:03 -0700 (PDT)
In-Reply-To: <4C920A1B.1030707@borg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156331>

On Thu, Sep 16, 2010 at 2:14 PM, Kent Borg <kentborg@borg.org> wrote:
> One odd thing that had me worried was seeing the git side of the gate=
way
> repository show a single history back and then show a short split
> history and then a single history, flopping as I ran transactions
> through it. =C2=A0I am not sure what was going on, but I think git-p4=
 is
> doing an amend of the last commit to put its notes in the message, an=
d
> if I have anything newer hanging from that commit this is a very bad
> thing. =C2=A0I am still worried but less so as long as I behave mysel=
f about
> not expecting it to make amendments to anything but the newest commit=
s.

This is true. git-p4 does rebase (which usually rewrites history) the
active branch as the last step when you do git-p4 submit. So, as you
say, it is important to be aware of this.

If HEAD points to X, and you do git-p4 submit, then if you have
another branch YY on top of X, you may want to checkout YY and do git
rebase X' (where X' is what git-p4 produces after it amends its
[git-p4: ...] stuff).

> Part of the consideration is to simply be very aware of those "[git-p=
4:
> ..." notes and decide where this should propagate to and design the
> workflow accordingly. =C2=A0(lkml probably won't want to see p4 notat=
ions...)
>
> But anyway, I seem to have git-p4 working in both directions, with a
> complete beginning-of-time history on the git side.

Good stuff! Congrats :)

> Tor Arvid: I owe you a beer (or whatever you drink when someone offer=
s
> you a beer), how often do you visit Boston?

Appreciated :) Well, its been ~9 years, so maybe I should go again
soon :) Otherwise, say hello whenever you're in Oslo ;)

-TA-
