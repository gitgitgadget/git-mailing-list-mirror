From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 1/2] user-manual: Simplify the user configuration.
Date: Wed, 21 Jan 2009 22:13:10 +0100
Message-ID: <8C518E90-A7AE-48F0-A1A3-F333B21F468E@wincent.com>
References: <1232561365-5919-1-git-send-email-felipe.contreras@gmail.com> <7v8wp4e5wn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 22:15:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPkPr-000051-Kf
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 22:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbZAUVNZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2009 16:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752956AbZAUVNY
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 16:13:24 -0500
Received: from wincent1.inetu.net ([209.235.192.161]:44523 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750AbZAUVNX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2009 16:13:23 -0500
Received: from cuzco.lan (139.pool85-53-3.dynamic.orange.es [85.53.3.139])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n0LLDBki002607
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 21 Jan 2009 16:13:12 -0500
In-Reply-To: <7v8wp4e5wn.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106673>

El 21/1/2009, a las 21:54, Junio C Hamano escribi=F3:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> This is shorter, avoids the burder to think about the format of the
>> configuration file, and git config is already used in other places i=
n
>> the manual.
>
> I am moderately against changing this part to use "git config".
>
> We traditionally introduced how to set configuration variables first =
=20
> by
> editing it in an editor, and this was quite deliberate, in order to =20
> show
> how the configuration file looks like, to demonstrate that there is n=
o
> deep magic in the file format, and to explain that it is perfectly =20
> Ok to
> edit it without using "git config" command.

If that's the goal, why not do both?:

1. Show people how to use "git config" like this patch does (seeing as =
=20
it's easier and less error prone)

2. Tell people that they can inspect and even edit the config file by =20
hand if they want

The actual order of 1 and 2 depends on where you want to place more =20
emphasis:

Something like either:

> Before creating any commits, you should introduce yourself to git.  =20
> The
> easiest way to do so is to make sure the following lines appear in a
> file named .gitconfig in your home directory:
>
> [user]
> 	name =3D Your Name Comes Here
> 	email =3D you@yourdomain.example.com
>
> As a convenience you can use linkgit:git-config[1] to modify =20
> your .gitconfig
> instead of editing it by hand:
>
> $ git config --global user.name "Your Name Comes Here"
> $ git config --global user.email you@yourdomain.example.com


Or:


> Before creating any commits, you should introduce yourself to git.  =20
> The
> easiest way is to use the linkgit:git-config[1] command:
>
> $ git config --global user.name "Your Name Comes Here"
> $ git config --global user.email you@yourdomain.example.com
>
> Your settings are written to a file named .gitconfig in your home
> directory which you can inspect or even edit by hand. Settings look =20
> like this:
>
> [user]
> 	name =3D Your Name Comes Here
> 	email =3D you@yourdomain.example.com


Cheers,
Wincent
