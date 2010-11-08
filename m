From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: history missing
Date: Mon, 8 Nov 2010 09:14:27 -0500
Message-ID: <AANLkTi=eFJ5qTWLD-AdczeDtSAtxs9xihuO+QQ8tVLyj@mail.gmail.com>
References: <AANLkTikFB5HNOmg0iTdjHxtrhU9vdua5O8btgFzpg-2F@mail.gmail.com>
	<m3mxpkeyh4.fsf@localhost.localdomain>
	<AANLkTin2-WAHMjKFKVqq7Wbzvjg-KzMkBh1kCGxDH6Mf@mail.gmail.com>
	<201011081448.10723.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Vitaliy Semochkin <vitaliy.se@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 15:14:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFSUh-00008G-L7
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 15:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754459Ab0KHOO3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Nov 2010 09:14:29 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61683 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754252Ab0KHOO1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Nov 2010 09:14:27 -0500
Received: by vws13 with SMTP id 13so1795718vws.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 06:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Lchzinc12vA6RGqrB45x1xaNokKWqhpj6tlKTzLab7o=;
        b=hbKcz4dFf4fQH9aINIp49GwlCshAvTxfRlclsJOOdQ/cZNcuatCiAjhvYfD2E+fKkj
         b8BIrydEAHJF/PibnLc22zPJHq8PeY/kNJSJ8mBjCQUOYRLWJBFSK5a/oSpuZ1/HCxRO
         VPIFs+5zorjGd7a/wz/4T9r+/qx2pSLKST8C4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jU4b3ZX9vvKUO0nFWNHoX5jifdbRc1nvkZD/yGeAB7N5oTMTLu8PwCm8zGCwKI3EUO
         rQ8DE3TuN/qPqjQnkD2KjJoZq+MIE87S1MULeCYkxdpzkMqyE84bp+QvlUTHPj9d/6uM
         hbp6Y/1LepgaFLFJmiawxa0A4otk/7YlqJbG8=
Received: by 10.224.188.198 with SMTP id db6mr4181164qab.290.1289225667252;
 Mon, 08 Nov 2010 06:14:27 -0800 (PST)
Received: by 10.224.20.82 with HTTP; Mon, 8 Nov 2010 06:14:27 -0800 (PST)
In-Reply-To: <201011081448.10723.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160942>

On Mon, Nov 8, 2010 at 8:48 AM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> On Mon, 8 Nov 2010, Martin von Zweigbergk wrote:
>> Sorry, maybe I misunderstood what the confusion was about. What I wa=
s
>> referring to was the confusion caused by 'git fetch origin master' n=
ot
>> updating 'refs/remotes/origin/master'.
>
> Should it really do it? =A0What if it does not exist? =A0What if <rem=
ote>
> is specified via URL?

I would probably not expect it to be updated (even if the URL matches a
configured remove). If the reference does not yet exist, I think I woul=
d
expect it to be created.

> If I understand correctly current behavior of 'git fetch <remote> <br=
anch>'
> wrt. FETCH_HEAD was meant for one-off 'git pull <remote> <branch>', o=
r
> rather 'git pull <URL> <branch>'.

Also see http://thread.gmane.org/gmane.comp.version-control.git/127163/=
=2E
Junio, Jeff and Avery can argue much better for and against this than I
can. I read it at some point, but I don't quite remember now if they di=
d
discuss the historical reasons for the current behavior in that thread.

/Martin
