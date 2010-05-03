From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: rev-parse vs. rev-list --no-walk
Date: Mon, 3 May 2010 11:22:40 -0400
Message-ID: <t2z76718491005030822l469c720ag1466ecd2bad31f32@mail.gmail.com>
References: <4BDC7471.9030107@drmicha.warpmail.net>
	 <7v1vdv4ccz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 03 17:22:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8xTr-00050S-Oc
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 17:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932808Ab0ECPWn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 May 2010 11:22:43 -0400
Received: from mail-iw0-f202.google.com ([209.85.223.202]:36827 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932791Ab0ECPWl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 May 2010 11:22:41 -0400
Received: by iwn40 with SMTP id 40so3359839iwn.1
        for <git@vger.kernel.org>; Mon, 03 May 2010 08:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bJk4vqrBqqqs80H4H/HX4TJSvuEDGALMAURo976Ta5Y=;
        b=dOyIKmC7cQh9T8z+9KNzxVgPVfF3LCIQfYkZ+BzWenPw4346sGy7Q2Qrh+StngjkDW
         B2pomAiL60KYw9iTHShXm2wFS3efCzCC/Q1Jy577o1wNLlw6iTLhzDVSMtTIK/ureAQQ
         mSVsiFhndndtLfEPbbIjHtToYUISolR4qr9UA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CjPb8HjvMhhfe1Hx35JChmnowYVoNJhfZq1dxBi165RZJC62JN4DF6wPTTlJl38WsH
         e1cD5siO+8pMGoQL6ea2XCX3/x5wOCfJOAMdnvHG0+C+kMCMDRHuC5KyS+uEwx6To6iC
         CXyiG6jzqveEd1jGFCQY7s6sYSvXayS+Inw1M=
Received: by 10.231.184.74 with SMTP id cj10mr871425ibb.19.1272900161042; Mon, 
	03 May 2010 08:22:41 -0700 (PDT)
Received: by 10.231.34.8 with HTTP; Mon, 3 May 2010 08:22:40 -0700 (PDT)
In-Reply-To: <7v1vdv4ccz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146238>

On Sat, May 1, 2010 at 4:05 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> I think one sane thing to do is to stop adding new rev-flags revision=
=2Ec
> supports to rev-parse (it already lags behind and nobody complained t=
hat
> rev-parse doesn't understand --first-parent as a rev-flag), and keep =
its
> use as "revision and non revision option sifter" only to support olde=
r
> scripts written back in v1.0.0 days. =C2=A0Its primary use these days=
 is "turn
> symbolic object names into 40-letter SHA-1", but "option sifter" aspe=
ct of
> the command seems to have outlived its usefulness.

We tell scripters to be careful to use the plumbing and not the
porcelain. From that standpoint, shouldn't we do our best to prevent
the plumbing from falling into disrepair?

(Or perhaps I'm reading too much into what you say.)

j.
