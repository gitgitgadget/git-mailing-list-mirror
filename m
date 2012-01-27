From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] git-completion: workaround zsh COMPREPLY bug
Date: Fri, 27 Jan 2012 18:33:50 +0200
Message-ID: <CAMP44s1hdFDfs=a-3XNCYpLUqGw4rq5spsO6qesvP5sp-A1fJw@mail.gmail.com>
References: <1327455422-22340-1-git-send-email-felipe.contreras@gmail.com>
	<7v4nvi2kgq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <matthieu.moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 17:33:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqokP-00069X-F7
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 17:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756241Ab2A0Qdw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jan 2012 11:33:52 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:35066 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754352Ab2A0Qdv convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 11:33:51 -0500
Received: by lagu2 with SMTP id u2so1061454lag.19
        for <git@vger.kernel.org>; Fri, 27 Jan 2012 08:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=IwAucj/7aYia0exQoEx/Ef7tCVT5Q6a/OxJrEL3/GHc=;
        b=oiZv+g9k8Y+rlNpGYIAtJjTLyy0+Hhn1PMO8pem8U3fMKVLELgAzbc+Q2JDgoHRlZ3
         kZkoWoVCCSl+Bbyku/RDEu01Hi3diRkJJXgizCt32C5UEXiMAuYbwQ/bdKmjIsWUNgmV
         6xsQcBN3u3l/GwPa/djWc/007TOW1YqV/aVz0=
Received: by 10.112.47.232 with SMTP id g8mr808432lbn.65.1327682030069; Fri,
 27 Jan 2012 08:33:50 -0800 (PST)
Received: by 10.112.10.169 with HTTP; Fri, 27 Jan 2012 08:33:50 -0800 (PST)
In-Reply-To: <7v4nvi2kgq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189224>

On Fri, Jan 27, 2012 at 12:00 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> zsh adds a backslash (foo\ ) for each item in the COMPREPLY array if=
 IFS
>> doesn't contain spaces. This issue has been reported[1], but there i=
s no
>> solution yet.
>> ...
>> Once zsh is fixed, we should conditionally disable this workaround t=
o
>> have the same benefits as bash users.
>>
>> [1] http://www.zsh.org/mla/workers/2012/msg00053.html
>> [2] http://zsh.git.sourceforge.net/git/gitweb.cgi?p=3Dzsh/zsh;a=3Dco=
mmitdiff;h=3D2e25dfb8fd38dbef0a306282ffab1d343ce3ad8d
>
> That 2e25dfb8 only says:
>
> =C2=A0 =C2=A0Rocky Bernstein: 29135 (plus tweaks): compgen -W in bash=
 completion
>
> without any explanation, which is not very useful.

Yeah, they development practices leaves a lot to be desired.

> Do you have a bug tracker ID or something for [1] above, with which I=
 can
> amend the patch as Matthieu suggests?

I don't think there's something like that, but here's the original disc=
ussion:

http://thread.gmane.org/gmane.comp.shells.zsh.devel/22541

--=20
=46elipe Contreras
