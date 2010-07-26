From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/24] Documentation: Move variables from config.txt to 
	separate file
Date: Mon, 26 Jul 2010 20:18:00 +0000
Message-ID: <AANLkTikANkubcJ2x5lDLKsKSiOAfMC1QaIoaTaEotN_l@mail.gmail.com>
References: <cover.1280169048.git.trast@student.ethz.ch>
	<75c9db91f5ab43ebb60cace0d20389462a2ab02c.1280169048.git.trast@student.ethz.ch>
	<20100726193841.GB1043@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 22:18:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdU7l-0001wa-4s
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 22:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843Ab0GZUSD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 16:18:03 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35092 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab0GZUSB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jul 2010 16:18:01 -0400
Received: by iwn7 with SMTP id 7so3009377iwn.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 13:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HQHiWDDlPgIWGVJ90CIzT+IEGBoQ9ywjSkn4/5vGMuw=;
        b=CbHxrXhSlbcYpmcfZrbXPJA1KerVsVft08uOhyq3mUkLjHJFeyjKKuNltfSwd6sPIh
         5Ct+wb7A3qjMQWfl+RKNk9LNDD4VyHXidL5egcsTeIr9BOx/dH3T4Wb3GmchiypLgWMT
         u6WW71ZBBm7qI1DilNlch01WyM2qp23dihb30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=a9qeGgB0NUgmopstLtkxWA9F3niSDESQtsZE+vpUC2RjCpnc2HzBxDJJa9cBGUbtdm
         yrfDaarBEPumAUwQfK0SLXHhNLVAw+FdSLlKMKJLp3Z09YR43ODYh0UqlI4m20pz54yZ
         u5Ip0qCs3hYldwoDJX5e+2dnpZ0XtB3CVS3qw=
Received: by 10.231.184.156 with SMTP id ck28mr8316908ibb.168.1280175480348; 
	Mon, 26 Jul 2010 13:18:00 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 26 Jul 2010 13:18:00 -0700 (PDT)
In-Reply-To: <20100726193841.GB1043@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151891>

On Mon, Jul 26, 2010 at 19:38, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Thomas Rast wrote:
>
>> =C2=A0Documentation/config-vars.txt | 1691 +++++++++++++++++++++++++=
+++++++++++++++
>> =C2=A0Documentation/config.txt =C2=A0 =C2=A0 =C2=A0| 1693 +---------=
-------------------------------
>
> Scary. =C2=A0Does -B -M -C -C -C make it any better?

It makes it even scarier:

 Documentation/{config.txt =3D> config-vars.txt} |  223 ++--
 Documentation/config.txt                      | 1923 ++---------------=
--------
