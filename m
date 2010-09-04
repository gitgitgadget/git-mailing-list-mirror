From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Could #-ignoring in commit message be smarter?
Date: Sat, 4 Sep 2010 22:44:51 +0000
Message-ID: <AANLkTinRE9tLBxCXApvJ9dM9cAUVAAcAWn-N1AkW-bVz@mail.gmail.com>
References: <AANLkTimgt6kjTkc+gxyOmTz03bdnfiRzgt4p8vymQ=VY@mail.gmail.com>
	<AANLkTinTxFveiuJvCUyB5Hghj-Jy+=LfhPJhtW1UYkSH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramana Kumar <ramana.kumar@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 00:44:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os1Tl-0005ry-RF
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 00:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096Ab0IDWox convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 18:44:53 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38032 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178Ab0IDWow convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Sep 2010 18:44:52 -0400
Received: by iwn5 with SMTP id 5so2817629iwn.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 15:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Q9jzsoh62BzibTiTtQ6kk42htJMD5oP8wA9Ct8YieNo=;
        b=KFEBl+S5BVO7TO+eGrJ5PnxpavZe8swabxgB1OO5t7YTN4rTUFW5OLOzuZf6Nj+jA9
         G+EdIqz1H0Y1aM5YW4FcV4TMYRaN5LDyN/UawxdUhmsTko0K9CysGwII9+TdcigjlHVA
         XZGOAVBQc6DlwIperBv3PEdoQPV/oKM1wDaXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oKAGzvYXNv3/QaKvUd4ud3PDvS+4V2cek7xUgZXe9LEZ+vhia2oJ1kt+6jvuib2xKS
         7rjUDWUUxkFTjLifdon+yKZr3IV9x9HkL9UFoNQuVU01XsjUCgnXTiF5YOC++B7jlHTw
         a7fqwxQ7euw+TN2XCz0shnpiEsz7tE4Ly9fMk=
Received: by 10.231.60.4 with SMTP id n4mr3602486ibh.18.1283640291764; Sat, 04
 Sep 2010 15:44:51 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sat, 4 Sep 2010 15:44:51 -0700 (PDT)
In-Reply-To: <AANLkTinTxFveiuJvCUyB5Hghj-Jy+=LfhPJhtW1UYkSH@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155382>

On Sat, Sep 4, 2010 at 22:30, Sverre Rabbelier <srabbelier@gmail.com> w=
rote:
> Heya,
>
> On Sat, Sep 4, 2010 at 17:24, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>> Where I'm referencing the #-character in the commit message itself f=
or
>> some reason, and due to word wrapping it just *happens* to end up at
>> the start of a line. So the commit message silently becomes:
>
> Isn't this rare enough that it's not really a problem? I mean, sure,
> when it happens it's a PITA, but it's about as painful as doing `git
> commit -m "Yay, it works!"` and having bash history magic blow it
> away. After a while you get used to it and either remember to escape
> the bang, or not use it?

With the bash thing you *notice* it, but in most cases like these what
you actually do is *not* notice it, then scratch your head a month
later at a commit message that makes no sense.

Anyway, it's obviously not a huge issue since we don't have people
complaining about it more often. But it's really annoying when it
happens.
