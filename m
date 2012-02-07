From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] commit: introduce a config key to allow as-is commit
 with i-t-a entries
Date: Tue, 7 Feb 2012 07:43:14 +0700
Message-ID: <CACsJy8Be=WLv1Zz5CqQMYfi8dJN6M980kVuckAQKAujVo8xFkQ@mail.gmail.com>
References: <1328525855-2547-1-git-send-email-pclouds@gmail.com>
 <1328525855-2547-3-git-send-email-pclouds@gmail.com> <7vhaz37nce.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 01:43:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuZ9y-0008BN-NX
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 01:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756136Ab2BGAnq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 19:43:46 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44793 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820Ab2BGAnp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 19:43:45 -0500
Received: by wgbdt10 with SMTP id dt10so6761763wgb.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 16:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=NFVNvjwupmzMCN7h9wdkdXyCHieZFdl72AfIeHlqWoU=;
        b=EmApAduoG4IVBecAhJOC6P44GSef5oT26pwTh2UFkR0hf28HzJW1tZ3eivX2UJ9dzS
         rxgxpffKeoPfNk2Ws1bvNnYI0Yas2DO884izCIBTxAwK3z23UC6gZ8X4B1E+ZHwRkaQ2
         EQeaVMZJpQBdsMyuoGwyU4sqq1YPeBZeH+I5E=
Received: by 10.181.13.113 with SMTP id ex17mr30798809wid.15.1328575424198;
 Mon, 06 Feb 2012 16:43:44 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Mon, 6 Feb 2012 16:43:14 -0800 (PST)
In-Reply-To: <7vhaz37nce.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190125>

2012/2/7 Junio C Hamano <gitster@pobox.com>:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (i < active_nr)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 warning(_("You are committing as-is wit=
h intent-to-add entries as the result of\n"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "\"g=
it add -N\". Git currently forbids this case.
>
> Can we phrase this a bit better?
>
> It is not like "forbids", but is "giving up because you didn't tell m=
e
> what content to include in the commit, even though you said you will =
tell
> me later".

"rejects"? I would rather say "see `git add -N` man page for more
explanation" than putting it here. The warning is quite long as it is
right now.
--=20
Duy
