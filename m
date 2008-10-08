From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Feature Request: Branch Annotations
Date: Wed, 8 Oct 2008 19:21:33 -0400
Message-ID: <32541b130810081621k32493e20occba9cd97671775d@mail.gmail.com>
References: <d2115f4f0810080341m27c4ca9bv9b1e9b66704ef3fa@mail.gmail.com>
	 <d2115f4f0810080348t62e18b14x1dfe798974332b05@mail.gmail.com>
	 <d2115f4f0810080349o30b6bc2labc2745b8d981e0d@mail.gmail.com>
	 <48ECB5CB.4010703@gmx.net> <7vwsgiptph.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Soria Parra" <sn_@gmx.net>,
	"Rotem Yaari" <vmalloc@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 01:22:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KniMg-0000Af-HF
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 01:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628AbYJHXVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 19:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754670AbYJHXVg
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 19:21:36 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:36523 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355AbYJHXVf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 19:21:35 -0400
Received: by gxk9 with SMTP id 9so9048971gxk.13
        for <git@vger.kernel.org>; Wed, 08 Oct 2008 16:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Ra22IGIfTmCaiBBPF9x7r2QkX89gx/wDnO48uPqVKdY=;
        b=hyf0a9djWjmp73TpyjqJn3EOtlRFzODuogHIAyaHSJlF6njiUHAyqyHFsRddbA9Xqz
         qbJ1qcJJjlZH2+gZHWd3ck5wslWKwWRw2ygtTe94l2xc8EF5JhN0srewLNBkoXr1+Pdb
         3QLxFamYjRww+FQ4jGG7QxjWUdlkMnh7AIxBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=lA7DTxpr3Ls8z82n6LBBoUkU4VWlNJxmj+NV0vsjFQMjHf2UTgPJTcshoLX/HTohH8
         XqeseDKoTmyS0C8FuCg1ZsrabpoDt5bHYderZTyrPCsUIb1fUPM8TjqVlClAD/7WnBsI
         Zmz1DeF6T38e8bKl5rt/+3u5si9DunYI/BCCA=
Received: by 10.151.158.2 with SMTP id k2mr11836624ybo.54.1223508093896;
        Wed, 08 Oct 2008 16:21:33 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Wed, 8 Oct 2008 16:21:33 -0700 (PDT)
In-Reply-To: <7vwsgiptph.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97810>

On 10/8/08, Junio C Hamano <gitster@pobox.com> wrote:
> David Soria Parra <sn_@gmx.net> writes:
>
>  >> Any opinions on this?
>  >
>  > would be great to have something like that build in git-core like
>  >
>  > git branch -i 'Fix bla' ds/fix next
>  > git branch -i
>  >  ds/fix (Fix Bla)
>
> Haven't people watched Linus on google tech talk?  Here is an excerpt from
>  the transcript (http://git.or.cz/gitwiki/LinusTalk200705Transcript):
>
>     ... well actually you shouldn't call it "test", you should basically
>     name your branches the way you name your functions, you should call
>     them something short and sweet and to the point -- What is that branch
>     doing.
>
>  IOW, why did you name the branch "ds/fix" and not "ds/fix-bla"?

Because it would be excessive typing every time you want to do
something to that branch?

I guess bash completions would help with this (if you're using bash),
but even then it's kind of unreasonable to name branches something
like "bug-111234-widget-performance-improvements-for-customer-x",
which is the sort of information that would be awfully helpful two
months later when you're looking at old unmerged branches.

Avery
