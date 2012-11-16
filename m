From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] tcsh-completion re-using git-completion.bash
Date: Fri, 16 Nov 2012 22:46:16 +0100
Message-ID: <CAMP44s3pi0iDOho_qYZEutebDNDveWWv6wEAs-C1bs1A_yL+Sg@mail.gmail.com>
References: <1352980269-15569-1-git-send-email-marc.khouzam@gmail.com>
	<CAMP44s0Guq0nYJEfbvNDyt8Oqaux-cXbTsyro6pxUnEpA4+XOw@mail.gmail.com>
	<CAFj1UpEdft+L5KW+tMy6Lqm1eUkHQgwWuXaC0UTUdqwW=ohk-Q@mail.gmail.com>
	<CAMP44s1RtOj6LKCNJ8SX8KSA8eNCMZ+4D-VfQ+WtXju-KhG8ng@mail.gmail.com>
	<CAFj1UpHLf2je_+b1e5B_5thZ03UYVmW=CWhAh63kNRCbke0kQw@mail.gmail.com>
	<CAMP44s1RvMSBu2RJqKw9ne4cJyMO4dbFc-gW2HgsN2-uviv=fA@mail.gmail.com>
	<CAFj1UpHMc-bHJgSZKY13YH_69TXkz-50g5xpLA6C+Eh0aqcN9A@mail.gmail.com>
	<CAMP44s3S4c7ciJNurxGdS2o_TDJJDkGK73dtCGji+C1NoV+Jvw@mail.gmail.com>
	<20121116204017.GX12052@goldbirke>
	<CAMP44s2UVGKa7XkqPxdxQ2ueSMn=Xn4qihy5JWbDovH85n8BwQ@mail.gmail.com>
	<20121116212224.GA12052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Khouzam <marc.khouzam@gmail.com>, git@vger.kernel.org
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Nov 16 22:46:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZTk7-0005jm-Um
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 22:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612Ab2KPVqR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2012 16:46:17 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61768 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab2KPVqQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Nov 2012 16:46:16 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so3255128obb.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 13:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=eZqEIvBsoPGRCliawT/1xMg9yRfE8I1ldd7YAmsANxU=;
        b=hLN9JMMPEcqCxcpxk9BPpyNnc16P73WBq3bWeyEknqNeLLZ7mQ+F6rjFLSytivRZ1F
         7OfPaWyJFSaIvm0mABd/Y6lBQyV9F6WlDXCAtwxbvS4K3Y/2AsPgcZ9Rw/oICi6ThJ6j
         0Jmpo5JjRUIN+GK3yZmE+QngAP2ZUY0VM7Z3DY+90gXPRjkiddlfkydh1VSvdkXXxNKq
         VNGi9vBXLWdGOXPiDVBLX1BwY6Gu00xaCypwehMxpOmKyWi+vyHz8wD7FDd0n8oFwIMH
         8TUhNykApYV0dpo6b4+/i3GCXK95jV17Ju/nCAwF1/dKIdcQqdiD8CMshT4Khu0IFA3t
         VvMw==
Received: by 10.60.31.241 with SMTP id d17mr5002371oei.107.1353102376276; Fri,
 16 Nov 2012 13:46:16 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Fri, 16 Nov 2012 13:46:16 -0800 (PST)
In-Reply-To: <20121116212224.GA12052@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209916>

On Fri, Nov 16, 2012 at 10:22 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de>=
 wrote:
> On Fri, Nov 16, 2012 at 10:03:41PM +0100, Felipe Contreras wrote:

>> > As I understand the main issues with using the completion script w=
ith
>> > zsh are the various little incompatibilities between the two shell=
s
>> > and bugs in zsh's emulation of Bash's completion-related builtins.
>> > Running the completion script under Bash and using its results in =
zsh
>> > would solve these issues at the root.  And would allow as to remov=
e
>> > some if [[ -n ${ZSH_VERSION-} ]] code.
>>
>> We can remove that code already, because we now have code that is
>> superior than zsh's bash completion emulation:
>>
>> http://article.gmane.org/gmane.comp.version-control.git/208173
>
> Which depends on the completion script having a wrapper function
> around compgen filling COMPREPLY.

No, it does not. Previous incarnations didn't have this dependency:

http://article.gmane.org/gmane.comp.version-control.git/196720

I just thought it was neater this way.

> However, COMPREPLY will be soon
> filled by hand-rolled code to prevent expansion issues with compgen,
> and there will be no such wrapper.

I'm still waiting to see a resemblance of that code, but my bet would
be that there will be a way to fill both COMPREPLY, and call zsh's
compadd. But it's hard to figure that out without any code. Which is
why I'm thinking on doing it myself.

But even in that case, if push comes to shoves, this zsh wrapper can
ultimately read COMPREPLY and figure things backwards, as even more
previous versions did:

http://article.gmane.org/gmane.comp.version-control.git/189310

>> This is the equivalent of what Marc is doing, except that zsh has no
>> problems running bash's code. Note there's a difference with zsh's
>> emulation bash (or rather bourne shell, or k shell), and zsh's
>> emulation of bash's _completion_. The former is fine, the later is
>> not.
>
> There are a couple of constructs supported by Bash but not by zsh,
> which we usually try to avoid.

Yes, and is that a big deal?

Cheers.

--=20
=46elipe Contreras
