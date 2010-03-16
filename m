From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH v2] git checkout -b: unparent the new branch with -o
Date: Tue, 16 Mar 2010 15:18:02 -0300
Message-ID: <55bacdd31003161118m59bc6066id2aaf7b165a601a6@mail.gmail.com>
References: <1268173713-5224-1-git-send-email-erick.mattos@gmail.com> 
	<7vr5nqrpyg.fsf@alter.siamese.dyndns.org> <55bacdd31003120845kc980d16s1e6006d56d6f923a@mail.gmail.com> 
	<7v8w9whd3g.fsf@alter.siamese.dyndns.org> <7v4okkegdy.fsf@alter.siamese.dyndns.org> 
	<55bacdd31003141457t7d2cebe3u9854d3c0a55b7da0@mail.gmail.com> 
	<7vmxyajns5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 19:18:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrbLa-0004dG-0W
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 19:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966550Ab0CPSSY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Mar 2010 14:18:24 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:44483 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966497Ab0CPSSW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Mar 2010 14:18:22 -0400
Received: by gxk9 with SMTP id 9so78338gxk.8
        for <git@vger.kernel.org>; Tue, 16 Mar 2010 11:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=+Yl+7MVq9SldG9DTh9ZEVgkc7dnKwKuaSAqgVpt2xho=;
        b=h3j8tQZFvcRhAaYxQnqyI3aYJRnwtCPw1dL8p4W0GWMD6riU4w2EJRZcIHDcNebEs2
         Fwz1QxEqSi9hkL9OqpZvphPmzDSr4xgm01pob1biCLLs8VX0h2nz7ScP49s7UGc1bkBA
         SQhKjbCPtbuYzE5VFq6ZHZZvE0WU5ModZkY0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=pzGXdPzgXeo8x9kHf+zx3LX2M0Fh2fXho//CfiZ4grIM7oevwyRwIZGKwMZdyTUVQr
         rv33mwQeFq5ORaUnWrEU883YPFr8+El9rD3sZw8yOLMIE2AlyZKm30G31866Bva+rXlM
         yKasReFRJJPpE3unvgth9dyHlpoCogJ2tPSrI=
Received: by 10.150.101.38 with SMTP id y38mr4617116ybb.277.1268763502078; 
	Tue, 16 Mar 2010 11:18:22 -0700 (PDT)
In-Reply-To: <7vmxyajns5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142345>

2010/3/14 Junio C Hamano <gitster@pobox.com>:
> Erick Mattos <erick.mattos@gmail.com> writes:
>
>> As I see you have found a very good example under your common work
>> flow. =C2=A0Nice. :-)
>
> And realize that it does not help that you nuke the index while leavi=
ng
> the working tree files.
>
> I do not think you got my point at all, so let's try a different phra=
sing.
> I've already spent too much time on this thread, so this will be the =
last
> message from me on this topic for now. =C2=A0Hopefully you will under=
stand this
> time.
>
> I saw two potential workflows that could be useful:

It is an evolution we are not talking about its usefulness anymore.

However it is not a matter of understanding too. :-)  It is about opini=
on.

It is just that you do not like the actual behavior and I do.

But you rule and this is just a detail anyway so I will be sending a
new version in a few moments.

Regards
