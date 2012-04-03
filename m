From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv2 0/2] fast-import: tighten parsing of mark references
Date: Mon, 2 Apr 2012 21:00:58 -0500
Message-ID: <CAGdFq_h-x9bi35=HTuYnFVNb=ZPH04BjbZcz8_996ENXYQBNPw@mail.gmail.com>
References: <20120401225407.GA12127@padd.com> <1333417910-17955-1-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	David Barr <davidbarr@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 04:01:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEt44-0007Nk-SF
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 04:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575Ab2DCCBk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Apr 2012 22:01:40 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:46907 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694Ab2DCCBj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Apr 2012 22:01:39 -0400
Received: by vbbff1 with SMTP id ff1so2087879vbb.19
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 19:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=dXuTFNN0ggf7DslNKmEsr60BracCRJdIZ7ENNshEY7w=;
        b=mVppkjC+BYcDloOFrZPxfpZleeid523HHjvW/WVaXVzgKsxTb4ySuEJjYBHb2x4fHS
         araMyxqQmLWI0FGwGNO/Ppzi1B+A20/UMoHFyIPNTwrLfjY1mkpUCdj1D8NdT23rmbwt
         +xM0+gF9wpYenm5/i1uffcOKLLU5nh2QGkk6wDfrGY5w0JIQRR3VCBDGBMYTtEApmssV
         VMscjjxChFIG/a97BKzEEzZfq413DDHzaCBc3whQovDzulYL0h+Y+m/d7hw2TSMLoDEf
         avkDYGiaAEKLbAi7n5E93qz539HFOEJU/bTSRSoLbRv1uDiZRaUKcXeL/y/8hgKyxi8E
         MRcA==
Received: by 10.52.18.212 with SMTP id y20mr4318431vdd.50.1333418498725; Mon,
 02 Apr 2012 19:01:38 -0700 (PDT)
Received: by 10.220.118.206 with HTTP; Mon, 2 Apr 2012 19:00:58 -0700 (PDT)
In-Reply-To: <1333417910-17955-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194587>

On Mon, Apr 2, 2012 at 20:51, Pete Wyckoff <pw@padd.com> wrote:
> Also, I did the unit tests first, to make sure things were broken
> as I expected. =C2=A0You can squash it all together if you prefer.

Nice series. I agree that it's good to be strict in what we accept
(breaking from the "be liberal in what you accept" mantra), due to the
importance of the input stream being parsed exactly right (as opposed
to a browser, where it's better to not render something bold than to
just break because a </b> was missing).

--=20
Cheers,

Sverre Rabbelier
