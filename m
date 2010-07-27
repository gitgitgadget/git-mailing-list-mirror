From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/24] Documentation: Move variables from config.txt to 
	separate file
Date: Tue, 27 Jul 2010 01:48:17 -0500
Message-ID: <AANLkTi=Ykc1UQDo_dqUxGmmPKRunRbpqd2qfpetEC7p1@mail.gmail.com>
References: <cover.1280169048.git.trast@student.ethz.ch> <75c9db91f5ab43ebb60cace0d20389462a2ab02c.1280169048.git.trast@student.ethz.ch> 
	<20100726193841.GB1043@burratino> <AANLkTikANkubcJ2x5lDLKsKSiOAfMC1QaIoaTaEotN_l@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 08:48:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oddxz-0003mz-KH
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 08:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365Ab0G0Gsi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 02:48:38 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45512 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab0G0Gsh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 02:48:37 -0400
Received: by ywh1 with SMTP id 1so475508ywh.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 23:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=F4jnxkQA7WpgiHr3Qf42oJH8Xyj5KW3lx/FfCUhMV50=;
        b=qSZ+TrdFqt9K7qN8kzHYbJXGzyBLM2hoXOs1gOhQWqAQbZU89Z5tDvnNtv1WZwu0rL
         XRJDHpsc209qLMFaT4zS+x1B85bzjCZ3aGbtGSs4eoAvafYS8IVwdipWL2TsVKYvDFZS
         leknTnLsDcpRKAfGRBpPs7YZs01DQdMvb4CiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=aq+6vWpPlFllj7hdvM6XwN8MTrSbS7EODqbQiXkICgjcEWXAUPu9VYcFAlKgZo9zVC
         ftYnhdKXDf3wrxG86zbzdWx5TygEUeZZ6mGHc2B6/ppUg0F6kgH9Ts9Tm7iqYuDv4Jwc
         a9p6tojkG13gOg6wq8EYwfqaOWKV4PXxB62K4=
Received: by 10.150.7.16 with SMTP id 16mr5620463ybg.92.1280213317248; Mon, 26 
	Jul 2010 23:48:37 -0700 (PDT)
Received: by 10.150.66.12 with HTTP; Mon, 26 Jul 2010 23:48:17 -0700 (PDT)
In-Reply-To: <AANLkTikANkubcJ2x5lDLKsKSiOAfMC1QaIoaTaEotN_l@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151916>

Heya,

On Mon, Jul 26, 2010 at 15:18, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> On Mon, Jul 26, 2010 at 19:38, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>> Scary. =C2=A0Does -B -M -C -C -C make it any better?
>
> It makes it even scarier:

So, should we somehow allow the user to tell us that yes, really, we
want to treat these two files as a move for the purpose of generating
a patch diff?

--=20
Cheers,

Sverre Rabbelier
