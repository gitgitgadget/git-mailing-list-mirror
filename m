From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] t3700: note a .gitignore matching fault
Date: Wed, 4 May 2011 07:41:21 +0700
Message-ID: <BANLkTinSx=MAkF5mt8gReNd1qEaeFTEBpA@mail.gmail.com>
References: <1304340464-14829-1-git-send-email-pclouds@gmail.com>
 <1304340923-15927-1-git-send-email-pclouds@gmail.com> <4DBEC766.8020008@viscovery.net>
 <BANLkTik=GYXUOeo3hA5yyXfOuBydT40koA@mail.gmail.com> <7voc3jis61.fsf@alter.siamese.dyndns.org>
 <BANLkTi=ZL5aPnPMXai==gyjYRT_LHovisA@mail.gmail.com> <7vd3jzgww8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 02:41:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHQA9-0000Ty-Im
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 02:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754849Ab1EDAlx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2011 20:41:53 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45146 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688Ab1EDAlw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2011 20:41:52 -0400
Received: by bwz15 with SMTP id 15so570096bwz.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 17:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=B6nZD0V26pjrGwMCEPE418mjRPK+bGfy8JyPNILHrxE=;
        b=bB0WhehRQPPAgw3rVst8CknTbWFm1/vTPdK4XUJFzdOkG0us6qBCdxGy1kXATnTR47
         TPlLKPwSRyOZUziKDQJ9zD13R6d+TA9CxO1++LpMFbNOba/xeiHDvfZovW9Zs5I0aOP9
         +xLh0plI08TngBD2ZpmwuhwlhlqLEYYDs0teA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=AOvKv5uw/Zw7cwq/FeIo6mQ1lig+QFmpSarnT6RzmnhkKMJ9lOtUx5O23HKsAMV+1L
         EGYaWsfmheSRQAhNnFLkcVGJVEX67BIKvILipkDjg5Gc5eXuHaaK3T5P/cBL3L0+N6rT
         eDQdBe9TyKhaYHkUX0Zq/L9EW5nOPjqbqR7r8=
Received: by 10.204.7.213 with SMTP id e21mr414104bke.209.1304469711176; Tue,
 03 May 2011 17:41:51 -0700 (PDT)
Received: by 10.204.53.13 with HTTP; Tue, 3 May 2011 17:41:21 -0700 (PDT)
In-Reply-To: <7vd3jzgww8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172707>

On Wed, May 4, 2011 at 6:57 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> Yes. But git still silently ignores some rules in the .gitignore.
>
> Do you want git to report each and every entry in .gitignore saying "=
this
> rule does not apply"? =C2=A0That sounds like madness to me.

This rule should apply, but not because of "efficiency reasons". Not
just about any rule.
--=20
Duy
