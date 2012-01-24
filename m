From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/2] add a Makefile switch to avoid gettext translation in
 shell scripts
Date: Tue, 24 Jan 2012 21:00:10 +0100
Message-ID: <CALxABCaGMabTLcCiYLv31YCiVY4OK7yEr4KL6e-0UMttMjGA_g@mail.gmail.com>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
 <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com>
 <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
 <CALxABCbaBmP6k5TYrYLCYm8oiv=9cF=N7_opSTKUnbkz5b-cwg@mail.gmail.com>
 <20120119195222.GA5011@blimp.dmz> <7v1uqq84es.fsf@alter.siamese.dyndns.org>
 <7vwr8i6prk.fsf_-_@alter.siamese.dyndns.org> <7vr4yq6poy.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 21:00:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpmXk-0004Pt-Ju
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 21:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755085Ab2AXUAc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jan 2012 15:00:32 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:51579 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754885Ab2AXUAb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 15:00:31 -0500
Received: by obcva7 with SMTP id va7so4683345obc.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 12:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=TK1NBbkax9aZnidDasjZWLoQVOD+G5sukiyl5IXFuXk=;
        b=VZGD0UEnnwIcTe6phU1v3jcVG0eDtD8mfAlJ+N4vYvkvejo9eN7C3bEAjgpiNM5Vs8
         C8qztDEhlfmI9TTCwdGcXyPExUFJvl56rQOKThLsoxP334sxOwRCAl72s4qcrqFaozfQ
         qkEFQmkg2SBB44zZTUkoZssvqsjOFyzvBLnWg=
Received: by 10.182.226.6 with SMTP id ro6mr13041865obc.3.1327435231124; Tue,
 24 Jan 2012 12:00:31 -0800 (PST)
Received: by 10.182.226.41 with HTTP; Tue, 24 Jan 2012 12:00:10 -0800 (PST)
In-Reply-To: <7vr4yq6poy.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189061>

On Mon, Jan 23, 2012 at 23:04, Junio C Hamano <gitster@pobox.com> wrote=
:
> From: Alex Riesen <raa.lkml@gmail.com>
>
> Some systems have gettext.sh (GNU gettext) installed, but it is eithe=
r
> broken or misconfigured in such a way so its output is not usable. =C2=
=A0In
> case the users of these systems are unable or not interested in fixin=
g
> them, setting the new Makefile switch should help:
>
> =C2=A0 =C2=A0make USE_GETTEXT_SCHEME=3Dfallthrough
>
> This will replace the translation routines with fallthrough versions,
> that does not use gettext from the platform.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Amen :)
