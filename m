From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [RFC/PATCH] doc: git-foo was obsoleted several years ago
Date: Thu, 17 Oct 2013 14:06:42 +0200
Message-ID: <CALWbr2yctBwGaA=9RK6ujDvcn29VvN0KPGAmBNfUVx1W5D67MA@mail.gmail.com>
References: <1379763429-3443-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq7gdc7v70.fsf@gitster.dls.corp.google.com>
	<525FC659.8020608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 17 14:06:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWmLn-0000tc-Ts
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 14:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618Ab3JQMGo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Oct 2013 08:06:44 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:39644 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373Ab3JQMGn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Oct 2013 08:06:43 -0400
Received: by mail-qa0-f42.google.com with SMTP id w8so5468044qac.1
        for <git@vger.kernel.org>; Thu, 17 Oct 2013 05:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=pfvZhxKiEb2Vd16h2iVolLjP8aKE85v4Q5mXYM6/hrY=;
        b=MV4UZduMGlQ6K3vHTIXjnU0g/+YVz2pgv14DcJ781XOm+5hz/z1/vG5VyFneUtTdVN
         734ULv8dvOudGvP2pHaU49HQE5awunF77shzbc5dtH2Q01dljq1EOaXk3zgzceJmsbAA
         jnxtTtgaz8ELHerq02ruUhRc/xNT5/IexbOHispLnnV5xkASPSYjg7ZDfF4zCMeDCwRK
         z/TfzOwIuUDEvMoWtCPYM6Py2q/QPQEaRWtCjeHqxmOEY/7icsImWd4Hdmtq7rEIpS9O
         TVjQ9Sfki+NDFIyKknSSslKLES4GXWDJ3ES35+AmkBfpwTh7vQwg/XzF++cjGH9MwwT2
         7pGQ==
X-Received: by 10.49.108.135 with SMTP id hk7mr3246311qeb.33.1382011602745;
 Thu, 17 Oct 2013 05:06:42 -0700 (PDT)
Received: by 10.49.104.211 with HTTP; Thu, 17 Oct 2013 05:06:42 -0700 (PDT)
In-Reply-To: <525FC659.8020608@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236294>

On Thu, Oct 17, 2013 at 1:13 PM, Jakub Nar=C4=99bski <jnareb@gmail.com>=
 wrote:
>> Felipe Contreras<felipe.contreras@gmail.com>  writes:
>>> diff --git a/Documentation/git-checkout.txt
>>> b/Documentation/git-checkout.txt
>>> index ca118ac..8d98383 100644
>>> --- a/Documentation/git-checkout.txt
>>> +++ b/Documentation/git-checkout.txt
>>> @@ -1,9 +1,9 @@
>>> -git-checkout(1)
>>> +git checkout(1)
>>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> I wonder if it wouldn't be better to leave as is, in dashed form,
> as the manpage file name is git-checkout.1, and this manpage is
> invoked as "man git-checkout", not "man git checkout"
> or "man 'git checkout'".

This is partly true, as you can also run it with `git checkout --help`
