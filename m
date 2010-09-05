From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Make commit help text more accurate for --verbose
Date: Sun, 5 Sep 2010 16:30:25 +0000
Message-ID: <AANLkTikLTykbgUjCK4H0cbF0QXZHOPYbLdptEKe4-rD5@mail.gmail.com>
References: <1283680383-12495-1-git-send-email-ramana.kumar@gmail.com>
	<AANLkTinEZ92S_XB4zrnb26eVR-MFsDQcSPAZ3RXj6ofH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramana Kumar <ramana.kumar@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 18:30:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsI71-0007ct-B5
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 18:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645Ab0IEQa0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 12:30:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65389 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993Ab0IEQaZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Sep 2010 12:30:25 -0400
Received: by iwn5 with SMTP id 5so3390508iwn.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 09:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Zs2KVZddicNsMdoW9Exoq8jUCSkNUy76/vyHrC7g3zE=;
        b=SI+VdwyOwqMmid1ik/oOygRDWL9F6Y5K4EGM1ebZp7ZS5vCLE1ovnFvwzar1vPAzKJ
         6QBV83unU28QbScw1b5G7izkZkSUpsjTAQnRye93Mv/ZYk06OWW6H0j0NBcYvUQWQPyM
         wzSiI2q/B0KjzEpeHxAf9cYYlhoaCX+09SNns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=c1vAj5nIHzhtBLshA6+w19H8obxVFyIFjGqt4OBMRArIsTyElXUTyBEc3ritYNh23C
         K3i4tDG5C6qnrwH0UekVM2YUv0DDAtxbAcPBguhCDu90/Ws8ScJ8wqiQXnafkQpEEBEG
         ghltk3qTADEEVfQ1aZw1EliLj60xl2oEoR7OI=
Received: by 10.231.37.10 with SMTP id v10mr4605346ibd.188.1283704225373; Sun,
 05 Sep 2010 09:30:25 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sun, 5 Sep 2010 09:30:25 -0700 (PDT)
In-Reply-To: <AANLkTinEZ92S_XB4zrnb26eVR-MFsDQcSPAZ3RXj6ofH@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155460>

On Sun, Sep 5, 2010 at 15:06, Thiago Farina <tfransosi@gmail.com> wrote=
:
> Hi Ramana,
>
> Some *style* comments below.
> On Sun, Sep 5, 2010 at 6:53 AM, Ramana Kumar <ramana.kumar@gmail.com>=
 wrote:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(fp,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0"\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0"# Please enter the commit message for your changes.");
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cleanup_mode =
=3D=3D CLEANUP_ALL)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cleanup_mode =
=3D=3D CLEANUP_ALL && !verbose)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0fprintf(fp,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0" Lines starting\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"# with '#' will be ignored, =
and an empty"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0" message aborts the commit.\=
n");
> The Documentation/CodingStyle says to avoid using braces unncessary.
> But since this is not a single line statement, like:
> if (foo)
> =C2=A0foo =3D x;
>
> Could you wrapp this into { } ?

The braces are still unncessary if the function call is spread across
a few lines. I haven't seen anything in the source that indicates that
we prefer braces when a braceless if/else has an associated statement
that exceeds 1 line.
