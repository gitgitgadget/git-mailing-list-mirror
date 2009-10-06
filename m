From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] Documentation - pt-BR.
Date: Tue, 6 Oct 2009 12:20:00 -0300
Message-ID: <a4c8a6d00910060820se973fcci31c94c42937c7eb2@mail.gmail.com>
References: <1253730339-11146-1-git-send-email-tfransosi@gmail.com>
	 <7vhbuek3ma.fsf@alter.siamese.dyndns.org>
	 <20091005100910.GA866@coredump.intra.peff.net>
	 <20091006094701.GG32702@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Oct 06 17:22:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvBrO-00024N-Nt
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 17:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755129AbZJFPUj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Oct 2009 11:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754168AbZJFPUj
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 11:20:39 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:42009 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbZJFPUi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Oct 2009 11:20:38 -0400
Received: by bwz6 with SMTP id 6so3340723bwz.37
        for <git@vger.kernel.org>; Tue, 06 Oct 2009 08:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NNfeq8KaRw8ONv6bzrjan3zegsc2A5sbLDcN4cY9p6Y=;
        b=N2nTaGrJzYCoChyS0iqCgDJaEUb1XZBBThSAp899s/RaGMWhlWtk5iDkfRV54f71eN
         qSL142mjUqxQUQ2ELX4BP5Qzmn94jA0GnWADUz9LTzf8W6jrrvqIgUIuHTTBr1Il/OTb
         ukGmfnOXwVok3cCVWEx+3QwMIG5s4vKsZopx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rtgyUOkRY20o8N1O0mMiJJtn4IfNy5LNrm9Ikbl88lwQpa5DOK1VYoDGXt7V38UG3r
         ZvqnRrRFjwZdXumAKP89ZhPEKH2jLq7RRSw1EBfeJubfKzGhpOGeBiPd04PQbQ/EI3Oo
         UlTkGKIZ05oqy9gAy80KzIr/fS+nSKsbaKNqs=
Received: by 10.204.21.4 with SMTP id h4mr4882926bkb.58.1254842400701; Tue, 06 
	Oct 2009 08:20:00 -0700 (PDT)
In-Reply-To: <20091006094701.GG32702@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129629>

Hi Miklos,
On Tue, Oct 6, 2009 at 6:47 AM, Miklos Vajna <vmiklos@frugalware.org> w=
rote:
> On Mon, Oct 05, 2009 at 06:09:10AM -0400, Jeff King <peff@peff.net> w=
rote:
>> > Has anybody actually tried to format this document, either before =
or after
>> > your patch?
>>
>> No, I didn't, and I should have when I picked up the patch in the fi=
rst
>> place. You are right, asciidoc barfs (both for html and xml generati=
on):
>>
>> =C2=A0 ERROR: gittutorial.txt: line 5: first section must be named N=
AME
>> =C2=A0 ERROR: gittutorial.txt: line 9: second section must be named =
SYNOPSIS
>
> Ah, there is no language config for pt_BR.
>
> $ ls -1 /etc/asciidoc/lang-*
> /etc/asciidoc/lang-de.conf
> /etc/asciidoc/lang-en.conf
> /etc/asciidoc/lang-es.conf
> /etc/asciidoc/lang-fr.conf
> /etc/asciidoc/lang-hu.conf
> /etc/asciidoc/lang-ru.conf
In my system I only have installed lang-es.conf, how I could install th=
e others?
>
> Once asciidoc will have a lang-pt_BR.conf, we could just use -a
> lang=3Dpt_BR and it would happily accept this input.
>
> Thiago, could you make a lang-pt_BR.conf? It's less than 100 lines, s=
o
> it should be easy for you. (If you can send it to the asciidoc list
> directly, it's even better.)
Sure, I made the lang-pt-BR.conf, and I sent it to asciidoc@googlegroup=
s.com.
