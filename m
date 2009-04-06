From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Mon, 6 Apr 2009 22:13:26 +0300
Message-ID: <94a0d4530904061213pabd87aj9db577aaa231945c@mail.gmail.com>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
	 <200904052358.53028.markus.heidelberg@web.de>
	 <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com>
	 <200904060117.24810.markus.heidelberg@web.de>
	 <fabb9a1e0904051622k66352ea4v542ecd99bd5d9c6@mail.gmail.com>
	 <20090406032457.GA14758@gmail.com>
	 <7v63hie4yh.fsf@gitster.siamese.dyndns.org>
	 <871vs5kjfw.fsf@krank.kagedal.org>
	 <7vy6ud4otd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	markus.heidelberg@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 21:15:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LquHr-0007mf-6e
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 21:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbZDFTNb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 15:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752997AbZDFTNb
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 15:13:31 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:45513 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428AbZDFTNa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2009 15:13:30 -0400
Received: by fk-out-0910.google.com with SMTP id 18so922431fkq.5
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 12:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+QGSUlYrUc9ObphuM3/fPQ7Q01gtjOm0oc/RGjMpV6c=;
        b=L2KuUGD+mhZnaScwH8oW+KsaHj3202h+N2pHWuvW5S6WZm4rdXKO0iM68P3X/MKSgo
         Lb/qYMgz9F1yhb0a21HJFRGPu9/dC4DuZ+Yj/C2MU9QWdqKMnHQRlHfxNbv1w9Xz2jwh
         noZwmJQgtueYcgR16fzwuiHu5SD5DcGv93x3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gqH2V83M5l5N17Eg7a4jRaiqs576VE/FCz/y0I5J02ID0zeMvd7jROVD+nB2cLwQpT
         pkwEnuY7rP+lcT++IZD7v5C5o2+c1qxaVVxQfMuVoVUUBiCT84qu1Wo3SXZdyW/I9fTt
         1hE19VlIn3CnqqvgFuY9URxEJUMay6dwvduXI=
Received: by 10.86.53.11 with SMTP id b11mr1989417fga.67.1239045207039; Mon, 
	06 Apr 2009 12:13:27 -0700 (PDT)
In-Reply-To: <7vy6ud4otd.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115871>

On Mon, Apr 6, 2009 at 9:30 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>
>> What do you mean? This was a suggestion for how git diff should
>> work. I fail to see how you would need a WORKTREEANDTHEINDEX there.
>
> You are talking only about "git diff". =C2=A0I am talking about the w=
hole git
> suite, because you have to worry about how such a proposal would affe=
ct
> other parts of the UI.

How do currently do you something like this:
git diff HEAD^..STAGE

You can't.

This is not an issue for any other git commands, that's why --stage,
--cache, --index make sense for _other_ commands, not 'git diff'.

--=20
=46elipe Contreras
