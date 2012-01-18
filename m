From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] branch: borrow --sort and --count from for-each-ref
Date: Wed, 18 Jan 2012 08:20:05 +0700
Message-ID: <CACsJy8An5oYv_Ki2oFezykSDFXmprPq07G7G4xq+srhcpP+OHg@mail.gmail.com>
References: <1326805907-19416-1-git-send-email-pclouds@gmail.com> <7vvcoaqe9h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 02:20:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnKCj-0000Sx-GA
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 02:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755464Ab2ARBUi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jan 2012 20:20:38 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64977 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418Ab2ARBUh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2012 20:20:37 -0500
Received: by bkas6 with SMTP id s6so2280353bka.19
        for <git@vger.kernel.org>; Tue, 17 Jan 2012 17:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=c6CO6BskZohcLo1h64J0FWa6xbGT0nevwWEGYktZcUM=;
        b=YeVhaZGLc7g2Wx00VLTiHzAMkKNow+ob4ToDCaNhDeSUw2w3bfzQs2iLpKtbXhYwZ8
         pM6Do7WCBbtgxAmyrpXuPZIQF0FPE3t/uvR/JBgxsIybK2NyGSZq8ZVhOoOnQg07BGds
         wAv5ktMxmBr4kOvVStbuSyvaS2d9r0a1bMDFM=
Received: by 10.205.128.140 with SMTP id he12mr1568555bkc.76.1326849636168;
 Tue, 17 Jan 2012 17:20:36 -0800 (PST)
Received: by 10.205.123.145 with HTTP; Tue, 17 Jan 2012 17:20:05 -0800 (PST)
In-Reply-To: <7vvcoaqe9h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188733>

2012/1/18 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> =C2=A0Some time ago, I posted a patch that added date sort to git-br=
anch
>> =C2=A0and Peff pointed me to for-each-ref. I did not look at it clos=
ely.
>> =C2=A0Now it does not seem hard to lend some code from for-each-ref =
to
>> =C2=A0git-branch. I can list 10 most recently touched branches with
>>
>> =C2=A0 git branch --sort=3D-committerdate -v --count=3D10
>>
>> =C2=A0kind of cool. I don't think adding --format is necessary becau=
se
>> =C2=A0git-branch already has its own formatting.
>
> Why do we even need this for "git branch", when "git for-each-ref
> refs/heads" already does this?

coloring, current branch marking, "branch -v", more accessible command
(I did not know about for-each-ref until Jeff told me)
--=20
Duy
