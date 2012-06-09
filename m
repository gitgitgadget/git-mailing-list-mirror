From: Leila <muhtasib@gmail.com>
Subject: Re: [PATCH] git-status: Show empty directories
Date: Sat, 9 Jun 2012 17:24:36 -0400
Message-ID: <CAA3EhHLzGG2pz27+_k6s92VC+u2S==ADyVMdCawES-=ZFt4fhg@mail.gmail.com>
References: <1339270806-65013-1-git-send-email-muhtasib@gmail.com>
 <20120609221315.Horde.fN5FP3wdC4BP065b3FviijA@webmail.minatec.grenoble-inp.fr>
 <CAA3EhHJ9WnisF21iFfsjQKYFSY0t0jFvNV3aBjx0eGFPm8aoGg@mail.gmail.com> <877gvgrxw7.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: konglu@minatec.inpg.fr, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jun 09 23:25:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdT9d-0002rP-GE
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 23:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238Ab2FIVY6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Jun 2012 17:24:58 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:57883 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401Ab2FIVY5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jun 2012 17:24:57 -0400
Received: by vbbff1 with SMTP id ff1so1686689vbb.19
        for <git@vger.kernel.org>; Sat, 09 Jun 2012 14:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=D1Cb6V0IWkYF3ogSkbZs7bZjgeCvKek7JgNMdlBSymE=;
        b=N1NtYdV/tqW+M7Og2ImEB3RLl5rfPdWEUKrKS08QjXmoV8aaO7o+vUsp/J7ss3Rweg
         zEhJ/p1c1L84xcTy4F+8nHEKeys/8GdRFHnAM/T3uP/sDDxmF8aWp4gnL91GbIBXFXaD
         YncggQ0jTCtVjY2OKDtfV6TfDqINFmy+Uy5A2IhYQfEREnPt51HXBpKAyPMKvLtmYksi
         cE4cWbDbFtHa6KEGh0ihxljAoW/zaiEgv9FX3heTa9HiJIFviAGPohdA175i0wUO3P++
         18yisL3EpLHall+ywNDWTw25fUzjAcKTPDYx1KDAUIRum+7WAqxCQUhbKEBCMClLho+T
         Rigg==
Received: by 10.52.73.42 with SMTP id i10mr8122571vdv.116.1339277096685; Sat,
 09 Jun 2012 14:24:56 -0700 (PDT)
Received: by 10.52.37.233 with HTTP; Sat, 9 Jun 2012 14:24:36 -0700 (PDT)
In-Reply-To: <877gvgrxw7.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199559>

On Sat, Jun 9, 2012 at 5:14 PM, Thomas Rast <trast@student.ethz.ch> wro=
te:
> Leila <muhtasib@gmail.com> writes:
>
>>> The structure is
>>> =A0 =A0 =A0if (...) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 /*code*/
>>> =A0 =A0 =A0} else {
>>> =A0 =A0 =A0 =A0 =A0 =A0 /*code*/
>>> =A0 =A0 =A0}
>>>
>>> Do not forget braces in the "else" part as the firt block needs it.
>>
>> I was under the impression that one liners didn't require parenthesi=
s
>> according to the style guidelines. I didn't realize that if the 'if'
>> required it, then the else required it. I will make that change and
>> remember it for the future. Thanks!
>
> It's not required, there's plenty of precedent, even one case within
> wt-status.c, of '} else'. =A0Try running
>
> =A0git grep '} else$'
>

I ran the command and was able to see that. Thanks Thomas. I'm fine
following whichever style you guys prefer.
