From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] commit: teach --gpg-sign option
Date: Fri, 7 Oct 2011 22:18:43 +1100
Message-ID: <CACsJy8CJ-c7bL37L64-Z_s=75Bgfj4cMhmB4J2s=dH=v_mGYhw@mail.gmail.com>
References: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org> <robbat2-20111006T221637-481195848Z@orbis-terrarum.net>
 <4E8EBAFE.8020805@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 07 13:19:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RC8SX-0004wv-Qu
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 13:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759915Ab1JGLTQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Oct 2011 07:19:16 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35282 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759808Ab1JGLTO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2011 07:19:14 -0400
Received: by bkbzt4 with SMTP id zt4so4740325bkb.19
        for <git@vger.kernel.org>; Fri, 07 Oct 2011 04:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MxoI/9fR2wdd6/JTp0l2zMuQBCHvFuTmYmO/o2R4D6Q=;
        b=qSTFG58QsB4MFQXjq6kfqPFMBvHLy7rtO4gD0nhSYxmyn/iRRzU3FhVCPWfRwnJ4wj
         FQwmA1R5gznaoOoEfVjGUCED2QyOyx/Brb/1FfA9TigGVPD21uG+E4UnfvPx35CA/MUX
         eD+bh9LMuVKG4tA34lCa10A6b0aMatxxMgs5w=
Received: by 10.204.6.210 with SMTP id a18mr1280164bka.303.1317986353340; Fri,
 07 Oct 2011 04:19:13 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Fri, 7 Oct 2011 04:18:43 -0700 (PDT)
In-Reply-To: <4E8EBAFE.8020805@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183074>

On Fri, Oct 7, 2011 at 7:40 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>> 3. If I have prepared a series on a local branch, and I want to sign=
 all
>> =C2=A0 =C2=A0of them, is this a variant of rebase or?
>
> If you really want to sign all you can rebase-i and use "exec" to do
> that automatically, but there's no point: signing the top-most commit
> serves the same purpose.

I think Gentoo wants identity, who (typically a Gentoo dev) signs this
particular commit and takes responsibility for making sure the commit
follows all kinds of Gentoo requirements. Commits can be passed
around, author and committer are not a reliable source.
--=20
Duy
