From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 04/20] t5800: document some non-functional parts of
 remote helpers
Date: Mon, 4 Jul 2011 13:19:00 +0200
Message-ID: <CAGdFq_iaGRnfkf=2vxDe--E3oP1CFCvDarkhKJxdgNzGq+KqcA@mail.gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
 <1308496725-22329-5-git-send-email-srabbelier@gmail.com> <20110619220246.GE23893@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 04 13:19:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdhBt-00036d-B8
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jul 2011 13:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754494Ab1GDLTl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jul 2011 07:19:41 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54586 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364Ab1GDLTk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2011 07:19:40 -0400
Received: by pvg12 with SMTP id 12so4279039pvg.19
        for <git@vger.kernel.org>; Mon, 04 Jul 2011 04:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=fXi1yIfCC9pM5Bs1TBh0A2y/pOhs3n3Vk5v22eMESIQ=;
        b=beikLadjofWJuatubSuA3aRfuNuaqUdPen2wDBKs5ubU0d/Hl+ZEBhXeiEHSnQ86YG
         lWQkINoBLgZ+cyDiVAbd6SJkZtASxqWShIWNWMIe3Rv3sEDaV/ANpY71PitcvNh4+vhC
         2HvGDq075LMoZd9p4bcjrvgd1LiW7TJSgk8Fc=
Received: by 10.68.51.162 with SMTP id l2mr3287854pbo.100.1309778380057; Mon,
 04 Jul 2011 04:19:40 -0700 (PDT)
Received: by 10.68.21.106 with HTTP; Mon, 4 Jul 2011 04:19:00 -0700 (PDT)
In-Reply-To: <20110619220246.GE23893@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176595>

Heya,

On Mon, Jun 20, 2011 at 00:02, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Looks good. =C2=A0What happened to the extra tests (e.g., push tag)
> mentioned in the last round?

Do you think they should be added as test_expect_fail targets? I
didn't add them because they didn't work, but I suppose it might make
sense to at least document these missing features.

--=20
Cheers,

Sverre Rabbelier
