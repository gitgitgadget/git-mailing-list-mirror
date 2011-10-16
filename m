From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCHv3] daemon: give friendlier error messages to clients
Date: Sun, 16 Oct 2011 07:21:31 +0530
Message-ID: <CAMK1S_iHCUrKc24kYqfUnmgEQ8yeAHiQ2StQAcPRknJ8-CvyFw@mail.gmail.com>
References: <20111014192326.GA7713@sigill.intra.peff.net>
	<20111014210251.GD16371@elie.hsd1.il.comcast.net>
	<20111014211244.GA16429@sigill.intra.peff.net>
	<20111014211921.GB16429@sigill.intra.peff.net>
	<CAMK1S_g0aKUa=+ndAm7rqeoPAobjVb6oJ1Z4DqSeNrdauXNH3w@mail.gmail.com>
	<7vk486x0hq.fsf@alter.siamese.dyndns.org>
	<CAMK1S_gkB49qhnt8U=3G3UPnjo2vzFx5mL4cOM1Ubu68ySJrDA@mail.gmail.com>
	<m3r52e7js7.fsf@localhost.localdomain>
	<20111015082647.GA7302@elie.hsd1.il.comcast.net>
	<7vzkh1vrdq.fsf@alter.siamese.dyndns.org>
	<20111015221711.GA17470@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 03:51:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFFt3-0001Cn-Qv
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 03:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943Ab1JPBvc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Oct 2011 21:51:32 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62673 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489Ab1JPBvb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Oct 2011 21:51:31 -0400
Received: by ywp31 with SMTP id 31so1309026ywp.19
        for <git@vger.kernel.org>; Sat, 15 Oct 2011 18:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=f8r6zdmv4wPNCq2ru8UKVdWHSUuqkQ6cwocYRXYPfsE=;
        b=Xjq3RPDlIIvW4AugEEDa4I4H8SVRbRO/g+MHkgMp5xxzM0FakraKV4cTIoCTP5SDpI
         hOCO2CETKk15kdgLR6Fo9Hoi+gyuGpXyQKMmc5Bv2egisqNLfpGqhzKRq7lu/voJ9qdX
         S02IV9wOQXEKuSx1DSd7Ea8dTi8HP1jiTEjAw=
Received: by 10.182.131.34 with SMTP id oj2mr7925665obb.71.1318729891184; Sat,
 15 Oct 2011 18:51:31 -0700 (PDT)
Received: by 10.182.53.73 with HTTP; Sat, 15 Oct 2011 18:51:31 -0700 (PDT)
In-Reply-To: <20111015221711.GA17470@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183684>

On Sun, Oct 16, 2011 at 3:47 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Junio C Hamano wrote:
>
>> The admin has access to logs that record the real cause anyway, no?
>
> Yes, you're right. =C2=A0If this is a good admin then she will look a=
t the
> logs, preventing the back-and-forth Sitaram described.

Actually, even if it's a good admin, you're adding to her load needless=
ly.

> Though that doesn't really change anything fundamental. =C2=A0It seem=
s nice
> to remind the end user to check for typos, too.

Yup.

DId I mention "been there, done that" in my earlier email?  I'm not
bike-shedding -- there *is* an impact on productivity in terms of how
people troubleshoot when they run across a problem, and I really *do*
feel strongly about this in principle (even though I don't use
git-daemon myself so it doesn't bother me how you decide in this
*specific* case)

I'll shut up now... :-)

--=20
Sitaram
