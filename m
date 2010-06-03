From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: [PATCH] documentation: git-mergetool updated to warn against 
	builtin tools invocations
Date: Thu, 3 Jun 2010 12:55:52 +0200
Message-ID: <AANLkTikPHdRWsHUI-YwEkECtIbj425hKxzy8_JrA4_ny@mail.gmail.com>
References: <1275501453-13081-1-git-send-email-srabot@steek.com>
	<7vbpbt9f9j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sylvain Rabot <srabot@steek.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 12:56:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OK85f-0007Y7-NX
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 12:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201Ab0FCKzz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 06:55:55 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56416 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab0FCKzy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 06:55:54 -0400
Received: by wyi11 with SMTP id 11so2640531wyi.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 03:55:52 -0700 (PDT)
Received: by 10.216.168.81 with SMTP id j59mr991425wel.61.1275562552512; Thu, 
	03 Jun 2010 03:55:52 -0700 (PDT)
Received: by 10.216.154.211 with HTTP; Thu, 3 Jun 2010 03:55:52 -0700 (PDT)
X-Originating-IP: [80.13.22.90]
In-Reply-To: <7vbpbt9f9j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148307>

On Thu, Jun 3, 2010 at 01:38, Junio C Hamano <gitster@pobox.com> wrote:
> Sylvain Rabot <srabot@steek.com> writes:
>
>> +Be aware that 'git mergetool' has some predefined invocation comman=
ds builtin
>> +for known diff tools like meld, diffuse, p4merge ... etc. It means =
that if
>> +you set the merge.tool configuration to one of these tools, the
>> +mergetool.<tool>.* configurations will not be taken care of. If you
>> +really want to customize the invocation of one of these tools,
>> +set `merge.tool` to "custom" or whatever you want and `mergetool.cu=
stom.cmd`
>> +to "/usr/bin/<tool> $LOCAL $MERGED $REMOTE"
>
> Two half-points and three points (that makes them four in total ;-):
>
> =A0o If I read the above without "It means that", it still makes sens=
e;

Ok

>
> =A0o "If you really" can go without "really";

Ok

>
> =A0* I had to read "will not be taken care of" twice; "are ignored" i=
s
> =A0 probably easier to understand;

Ok

>
> =A0* The description and the example makes it sound as if the command=
 line
> =A0 has to have these three tokens in the given order, but the whole =
point
> =A0 of this mechanism is that you can launch whatever external comman=
d with
> =A0 a custom command line, so "and `mergetool.custom.cmd` to a comman=
d line
> =A0 to invoke the command. =A0$LOCAL $MERGED and $REMOTE on this comm=
and line
> =A0 are substituted by ...." may be more reader-friendly.

Ok

>
> =A0* As a documentation update it is perfectly fine to describe this =
glitch,
> =A0 but I wonder if we might want to lift this restriction (read: con=
sider
> =A0 this as a bug and fix it).

I agree, I wil take a look, I'm not a sh expert but I can try.
If I succeed I will send you a patch, otherwise I will send you a
corrected version of this patch.

>
>> ++
>> +-------------
>> +[merge]
>> + =A0 =A0tool =3D diffuse-custom
>> +[mergetool "diffuse-custom"]
>> + =A0 =A0cmd =3D diffuse $LOCAL $MERGED $REMOTE
>> +-------------
>> ++
>
> Thanks.
>

--=20
Sylvain
