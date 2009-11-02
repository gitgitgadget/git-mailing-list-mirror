From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] commit -c/-C/--amend: acquire authorship and restamp time 
	with --claim
Date: Sun, 1 Nov 2009 22:54:34 -0200
Message-ID: <55bacdd30911011654k22eb6b13r28897bf71fc5e11b@mail.gmail.com>
References: <1257099580-7365-1-git-send-email-erick.mattos@gmail.com> 
	<1257101127-8196-1-git-send-email-erick.mattos@gmail.com> 
	<7vr5sixbd1.fsf@alter.siamese.dyndns.org> <55bacdd30911011257m22ee85f2wc5d51865f7f2aadd@mail.gmail.com> 
	<7vbpjlycqc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 01:55:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4lCG-0005kG-33
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 01:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076AbZKBAyu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Nov 2009 19:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753070AbZKBAyt
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 19:54:49 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:49093 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbZKBAyt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Nov 2009 19:54:49 -0500
Received: by ywh40 with SMTP id 40so4099966ywh.33
        for <git@vger.kernel.org>; Sun, 01 Nov 2009 16:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=pQkT5pStK8bWThY1vFSyq2aQdm2Kn36djgK/46V1b6s=;
        b=M+INGZlTaEqAzZF59avMHkdBC2SY41sm3n4YepwTPsfgDSZ2Vi16oWv3XVjbZ5+Gcc
         HNEricD1gY/M79y3Bj811Kxo9xbyQ5gEucxfNUul70JaiFkxolKh9hioHk/wxOTHbxJc
         340Dfo3Xs9lhXswdouIUhQ+jraxFjgfqb0v4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DxX78p91C3QPIFuXzdoBSkyLnjSZpImMDqu78FC/7mCH69Ml/7mNZ5SvBy2S2jX0Fp
         362S0lmEJ6oMIFddopxAXBqPMtZyJIn2Wrikc7KGErOGPpZtFvXzHdBlEN2RwZkjOPE+
         h9DoVKKLrNzixH6VKwqh6Y+BThbLYkh4Kewe4=
Received: by 10.150.107.4 with SMTP id f4mr7272456ybc.286.1257123294078; Sun, 
	01 Nov 2009 16:54:54 -0800 (PST)
In-Reply-To: <7vbpjlycqc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131888>

2009/11/1 Junio C Hamano <gitster@pobox.com>:
> Erick Mattos <erick.mattos@gmail.com> writes:
>
>>> =C2=A0 =C2=A0% git commit --claim --author=3D'Erick Mattos <eric@ma=
ttos>' -C HEAD
>>>
>>> Should you detect an error? =C2=A0Does your code do so? =C2=A0Do yo=
u have a test
>>> that catches this error?
>>
>> It works as intended. =C2=A0Both together.
>
> That does not make any sense. =C2=A0If you are saying this is yours a=
nd it is
> his at the same time, there can be no sane way to work "as intended",=
 no?.

I am adding a new option not changing the option --author already in
git.  So it does work together.

>>>> + =C2=A0 =C2=A0 git commit -c HEAD <<EOF
>>>> + =C2=A0 =C2=A0 "Changed"
>>>> + =C2=A0 =C2=A0 EOF &&
>>>
>>> What editor is reading this "Changed"?
>>
>> Nobody cares... =C2=A0Just a text to change the file.
>
> I actually care. =C2=A0Who uses that Changed string, and where does i=
t end up
> with? =C2=A0At the end of the log message? =C2=A0At the beginning? =C2=
=A0What "file"?
>

I didn't get it.  -c option does not accept -m option and starts an
editor to change the message.  The text "Changed is just a forced
message.  I can not use an editor in interactive mode in a script...
What I am losing here??
