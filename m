From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: Re: Git clone stalls at a read(3, ...) saw using strace
Date: Thu, 27 Jul 2006 13:17:27 -0400
Message-ID: <b8bf37780607271017p22fa908bt82a564a4a1a15a79@mail.gmail.com>
References: <b8bf37780607270516i7fbd8844he03e107b15fd2ed7@mail.gmail.com>
	 <1154018302.13273.0.camel@dv>
	 <b8bf37780607270943w562ec21fuab0eb882b3ccffeb@mail.gmail.com>
	 <Pine.LNX.4.64.0607270947540.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Pavel Roskin" <proski@gnu.org>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 19:17:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G69UK-00037K-0M
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 19:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbWG0RR3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 27 Jul 2006 13:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbWG0RR3
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 13:17:29 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:14274 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751790AbWG0RR2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 13:17:28 -0400
Received: by py-out-1112.google.com with SMTP id s49so366968pyc
        for <git@vger.kernel.org>; Thu, 27 Jul 2006 10:17:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h7ycoHk2IT3LsFReh6aBHJ9bH4O3yImds5J72FOJkwTFW+4e1dYz0PE/yk7iLD7AZGk7KmZx3jlH6cw7zL9wi9AUCDSqz84Xa7tnFro82crg7LGrBDaLAynCq+ePH+EtN7p4EdITBTI6DUNj8UPODsjA0StK75/UTu5LhvKQ2NI=
Received: by 10.35.127.7 with SMTP id e7mr13411178pyn;
        Thu, 27 Jul 2006 10:17:27 -0700 (PDT)
Received: by 10.35.128.2 with HTTP; Thu, 27 Jul 2006 10:17:27 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607270947540.4168@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24315>

On 7/27/06, Linus Torvalds <torvalds@osdl.org> wrote:
> On Thu, 27 Jul 2006, Andr=E9 Goddard Rosa wrote:
> > >
> > > Please try git 1.4.1.1, it fixes git-clone.
> >
> > Thank you so much, Pavel!
> >
> > Downloading it right now!
>
> The problem is that at least the timeout-fix is a server-side thing, =
it
> won't fix the client. So if a server is running the broken 1.4.1 rele=
ase,
> it will time out the clients after 10 minutes. It wasn't obvious brea=
kage,
> because most people do smaller fetches, and never even got close to t=
hat
> timeout (most of my connections tend to be in the seconds ;).
>
> I asked Kees to upgrade kernel.org, but he's apparently busy at OSCON=
 this
> week, so I'm bcc'ing the other admins here to ask them to upgrade to
> 1.4.1.1. That won't fix the montavista site, though.
>
> That said, I don't think the timeout problem should have caused a _st=
all_
> of the connection, it should have caused an early EOF and thus a unpa=
ck
> error.

Great! Thank you so much, I will try to contact Montavista.

Best regards,
--=20
[]s,
Andr=E9 Goddard
