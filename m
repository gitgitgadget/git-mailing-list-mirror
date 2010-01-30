From: Mark Lodato <lodatom@gmail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 20:01:40 -0500
Message-ID: <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <fabb9a1e1001291332w1d161f8at58aa6fe6908bd77f@mail.gmail.com> 
	<alpine.LFD.2.00.1001291641200.1681@xanadu.home> <7viqakh8ty.fsf@alter.siamese.dyndns.org> 
	<alpine.LFD.2.00.1001291716070.1681@xanadu.home> <7vaavwh6yh.fsf@alter.siamese.dyndns.org> 
	<alpine.LFD.2.00.1001291833580.1681@xanadu.home> <7vy6jgcutb.fsf@alter.siamese.dyndns.org> 
	<fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com> 
	<7viqakcu56.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 02:02:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb1iy-0003R5-Rd
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 02:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872Ab0A3BCD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 20:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754373Ab0A3BCD
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 20:02:03 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:61639 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869Ab0A3BCA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2010 20:02:00 -0500
Received: by pxi12 with SMTP id 12so2166489pxi.33
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 17:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=REFRgC3/GX5keRKwJSF55JH1xHupfyCaQlb54x1kKU4=;
        b=OjnDbk31mIagplNtpYknGyOCgCgIONzu8wPhriFAMksEsKbDP0/RZjsbg2LYkIOAEU
         4xsgCv8pSyntf0lZxW/nOsosxPpVmrB8iR2jnC1i6e4spzXXCE+cqRfMxPtElxoS72Bg
         HdL7XmW/2dAfO09GANFYPyx2rf4woI9rkS8aM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=btbzqyjJOs6XNinubgl3pRHPfZWbY3gordQr99iPoQF6YOcDYpxdMTzv6hFYNNeLE6
         kJwp8srHIZF4Cg/OvKGEYDfszkgK4Z8vGsINjBgJAoI+yHD2NMel/HoIIN35vV5pL2fA
         zr2q+FOPKAlp7vAjS0kFHPbOr/OvdJW/CL6Yc=
Received: by 10.115.64.6 with SMTP id r6mr1058600wak.85.1264813320133; Fri, 29 
	Jan 2010 17:02:00 -0800 (PST)
In-Reply-To: <7viqakcu56.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138414>

On Fri, Jan 29, 2010 at 7:29 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> How about this?
>
> -- >8 -- not a patch -- >8 --
> Note: 'master^0' isn't a local branch head;
>
> You are in 'detached HEAD' state. You can look around, make experimen=
tal
> changes and commit them, and you can discard any commits you make in =
this
> state without impacting any branches by checking out another branch.
>
> If you want to create a new branch to retain commits you create, you =
may
> do so (now or later) by using -b with the checkout command again. Exa=
mple:
>
> =C2=A0git checkout -b <new_branch_name>
>
> HEAD is now at a9d7c95... Merge branch 'maint'
> -- 8< -- not a patch -- 8< --

=46irst off, I would like to voice support for such a warning.  This is
so much more clear than the current message.

Still, I find it slightly confusing and unfriendly.  How about the foll=
owing?

-- >8 -- not a patch -- >8 --
Checking out commit 'master^0'.

Since this is not a local branch head, any commits you make will be los=
t
when you check out another branch or commit.  (In git terminology, HEAD
is detached.)  If you just wish to look at files without committing,
this is fine.  If you wish to make commits and retain them, you may
create a new branch by running:

  git checkout -b <new_branch_name>

HEAD is now at a9d7c95... Merge branch 'maint'
 - 8< -- not a patch -- 8< --

I think the above wording is fine for both commits (e.g. master^0) and
remote branches (e.g. origin/pu).  With other wording, we may wish to
have two slightly different messages depending on what the user typed.

Also, I am not a big fan of "local branch head".  How about "not the
name of a local branch"?  I'm not sure...
