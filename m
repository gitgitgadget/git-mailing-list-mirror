From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: Re: Git clone stalls at a read(3, ...) saw using strace
Date: Thu, 27 Jul 2006 13:57:37 -0400
Message-ID: <b8bf37780607271057i22c700e0hde1c0893cd638f25@mail.gmail.com>
References: <b8bf37780607270516i7fbd8844he03e107b15fd2ed7@mail.gmail.com>
	 <1154018302.13273.0.camel@dv>
	 <b8bf37780607270943w562ec21fuab0eb882b3ccffeb@mail.gmail.com>
	 <Pine.LNX.4.64.0607270947540.4168@g5.osdl.org>
	 <b8bf37780607271017p22fa908bt82a564a4a1a15a79@mail.gmail.com>
	 <b8bf37780607271025m1a611006x65a900e9e487ce1b@mail.gmail.com>
	 <Pine.LNX.4.64.0607271049460.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Pavel Roskin" <proski@gnu.org>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 19:58:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6A7C-0002KI-7g
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 19:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbWG0R5j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 27 Jul 2006 13:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbWG0R5j
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 13:57:39 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:4925 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751902AbWG0R5i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 13:57:38 -0400
Received: by py-out-1112.google.com with SMTP id s49so380618pyc
        for <git@vger.kernel.org>; Thu, 27 Jul 2006 10:57:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BOWIWFtarxspSmJkcFx68O7JM+RqDJll54ID7BTbWwZ8qESpaxkjGnho2TL5U/NNPz9zjQG9Ws6khC87RZYjpcfyVTQHMQZlDchc+o3ZFKgtfgpFkcG3UTSuvn19Yq9GfV0El52Q/EAnqbIRW0aqc2WLQQVkVWWZuq7sPk/4zh8=
Received: by 10.35.126.7 with SMTP id d7mr13511695pyn;
        Thu, 27 Jul 2006 10:57:38 -0700 (PDT)
Received: by 10.35.128.2 with HTTP; Thu, 27 Jul 2006 10:57:37 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607271049460.4168@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24326>

On 7/27/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Thu, 27 Jul 2006, Andr=E9 Goddard Rosa wrote:
> >
> > The problem happened again, and it stalls AFAICS.
> > Can you reproduce there?
> >
> > # git clone git://source.mvista.com/git/linux-davinci-2.6.git
>
> Nope. I have a fairly constant 120kbps, and:
>
> [torvalds@g5 ~]$  git clone git://source.mvista.com/git/linux-davinci=
-2.6.git
> Checking files out...)
>  100% (19754/19754) done
> here

Do you think you can reproduce the server timeout by CTRL + Z and
stopping the process for a while?

I sent an email to the last one who commited in that tree asking for
updating the git version there. I also sent and email to the maillist
owner asking this.

Thanks again,
--=20
[]s,
Andr=E9 Goddard
