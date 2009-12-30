From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3] builtin-push: add --delete as syntactic sugar for :foo
Date: Wed, 30 Dec 2009 06:14:53 -0600
Message-ID: <fabb9a1e0912300414q329bff5fy95ace5a5ad44db08@mail.gmail.com>
References: <20091109130935.2bea7771@perceptron> <7v8wefy6pi.fsf@alter.siamese.dyndns.org> 
	<20091109192044.605e50ba@perceptron> <20091229200523.6117@nanako3.lavabit.com> 
	<7vvdfpg1je.fsf@alter.siamese.dyndns.org> <20091230105244.67f5969e@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Git ML <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Wed Dec 30 13:15:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPxSS-0003Yl-TT
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 13:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503AbZL3MPP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Dec 2009 07:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752598AbZL3MPP
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 07:15:15 -0500
Received: from mail-px0-f189.google.com ([209.85.216.189]:62466 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197AbZL3MPO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Dec 2009 07:15:14 -0500
Received: by pxi27 with SMTP id 27so6813297pxi.4
        for <git@vger.kernel.org>; Wed, 30 Dec 2009 04:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6hYEzeweW5OorUGmAYB1IPSlkhe0IGEZdJzrDAGZs6c=;
        b=g+ipSZTrQhbqf7aNjM1qlXQFFvJm26ND3TAKiRIito8Xw4bkIEqzSd1M0bH8nEpBaZ
         s3c2ia7c3I/QXR7+gGx29CwH+pbue/5EoLN4uGRNDKtrGJNknjFCXNrAgVXtCFtm8xMO
         VbeByTkAnTM63NBthY1Igcz6whkAu5Pud3mVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=m5JwmJ2L3SODRb2Sq5CPtPZWQ7gCkBMfdI0CUdotMzf74FyDyJpRWk+iW9mp69bqUs
         pqzwbWGLu5faXHAPrjupLWeSvh5Sw+dpZQqenLQrgn7m0FQiRh61Fgc2FhUpCwhLc1UQ
         /N2CnPSHkao3+vKfnnYVcetOLmmoMWj4tGgs4=
Received: by 10.142.6.42 with SMTP id 42mr12291058wff.88.1262175313102; Wed, 
	30 Dec 2009 04:15:13 -0800 (PST)
In-Reply-To: <20091230105244.67f5969e@perceptron>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135890>

Heya,

On Wed, Dec 30, 2009 at 03:52, Jan Kr=FCger <jk@jk.gs> wrote:
>> So if Jan or Sverre want to resurrect the topic, I am all for it.
>
> Alrighty. I assume by (3) you meant that it should be possible to use
> something like "push there --delete tag v1.0.0". Version 3 of the pat=
ch
> adds this, and it also includes updated tests and (brief) documentati=
on.

Thanks for picking this up.

--=20
Cheers,

Sverre Rabbelier
