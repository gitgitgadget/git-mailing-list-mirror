From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH en/and-cascade-tests 0/7]
Date: Fri, 22 Oct 2010 18:23:48 +0700
Message-ID: <AANLkTimm0_L9EwhcXu7DbJVdG8kO+qL7RuMa-x4RfM_e@mail.gmail.com>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com> <20101022063837.GA6081@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 13:24:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Fjd-0003pR-BS
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 13:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221Ab0JVLYM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 07:24:12 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57895 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275Ab0JVLYK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Oct 2010 07:24:10 -0400
Received: by wyf28 with SMTP id 28so715580wyf.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 04:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=4jMSyoXz68FgUgjdCwdTkruPMRUNu7/yCI+E6mySeX8=;
        b=VDKRL1xYyOsD4Q5shaWynVDJ4a6iDwzrbU1YV7vp18ufwlsnVG2r3CuHD0CAw8bcs4
         HSl6NAazkg5FvJGtnMW65vxB0E/oM4aF0M+0cPtGYIb6POeMi+SdGCswMYUwDNkRAwuF
         PGUvmVXhG1xdPp3Z/oqt4gBhclKuAvNepAMr0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=C+sDR+kfeQifUFj/T93HwYHAO8HzqNIIeSqtgogvgGTsTXCC5YipO+fAh00n9TPj67
         r3D5RJA1YvDGT2QprCJcE8JlWgAWUmwr2W6CfxnT6iw6Rb4POd2+5AwYVthpAsVT7sJt
         dV7faPA5EsUb0UEqdtwWcyBaD01BSaTkuyXZ0=
Received: by 10.216.157.81 with SMTP id n59mr2368613wek.84.1287746648730; Fri,
 22 Oct 2010 04:24:08 -0700 (PDT)
Received: by 10.216.171.207 with HTTP; Fri, 22 Oct 2010 04:23:48 -0700 (PDT)
In-Reply-To: <20101022063837.GA6081@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159680>

2010/10/22 Jonathan Nieder <jrnieder@gmail.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (7):
> =C2=A0branch -h: show usage even in an invalid repository
> =C2=A0checkout-index -h: show usage even in an invalid repository
> =C2=A0commit/status -h: show usage even with broken configuration
> =C2=A0gc -h: show usage even with broken configuration
> =C2=A0ls-files -h: show usage even with corrupt index
> =C2=A0merge -h: show usage even with corrupt index
> =C2=A0update-index -h: show usage even with corrupt index

You should take the credit. I bet my code change does not take as much
time as your writing tests. Nice tests by the way. Inspiring.
--=20
Duy
