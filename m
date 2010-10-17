From: =?ISO-8859-1?Q?S=E9bastien_Barth=E9lemy?= <barthelemy@crans.org>
Subject: Re: rebase converts merge commits
Date: Sun, 17 Oct 2010 10:04:56 +0200
Message-ID: <AANLkTinJPqnazW26KA3Heb1MSwaKYoBA2JRVZ0wFywkK@mail.gmail.com>
References: <AANLkTikz0yUv9+EcT-kVwniUf9xnRe=_y96euNb=stzP@mail.gmail.com>
	<523A21BF-F6A1-4BF2-8385-941B61BA769F@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 17 10:05:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7OF1-0006oI-Ea
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 10:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754969Ab0JQIFD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Oct 2010 04:05:03 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34620 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024Ab0JQIFA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Oct 2010 04:05:00 -0400
Received: by iwn35 with SMTP id 35so2710314iwn.19
        for <git@vger.kernel.org>; Sun, 17 Oct 2010 01:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=SUvE27dZ7QKQwIPchjv+LQ0whSa2GKGg2a8PfM5hthI=;
        b=CgvEtq6wN4b+5Szdy5Foj+WRYbnG9qPzlVth5yFr8P5OJjk2dzsaIbkriwa4mZZ+/R
         +cJhuMzWKVcDmXRxOZdb3M6191Y5Qm1ZSPQiSO2VeScvWFYTjoCT1H4gpuu0qiIXyOyk
         YdRCeGfBfR9iCorfLro1Ksi7CMLngpGMeQUSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=uLqzW5/sUQisynpMRqwVu4sCfPwNWoKmjhAsaFAzE6s94b4/TqRi2PIf/ZB0UIt5wd
         MESQHiXcgBsWqi9w7yzqP0q6Lay7CBwL4aOHP0KMC8PIngkE472KhRd65XVHA+1GS+t8
         jy/zq54IROV4och7zvAeXfBibx6W6Z5jgtLnc=
Received: by 10.42.8.14 with SMTP id g14mr1999301icg.165.1287302696778; Sun,
 17 Oct 2010 01:04:56 -0700 (PDT)
Received: by 10.231.19.138 with HTTP; Sun, 17 Oct 2010 01:04:56 -0700 (PDT)
In-Reply-To: <523A21BF-F6A1-4BF2-8385-941B61BA769F@sb.org>
X-Google-Sender-Auth: B2_ZO5-WCugf8Uvmn2OdmLInz0M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159198>

2010/10/12 Kevin Ballard <kevin@sb.org>:
> On Oct 12, 2010, at 7:55 AM, S=E9bastien Barth=E9lemy wrote:
>
>> By the way, if there is a way to do what I want, please tell me.
>
> Your history is short enough that if you can't get rebase to do what =
you want, you could always do it by hand.

Sure. Thank you for making it clear.
