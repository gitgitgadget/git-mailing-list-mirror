From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] trace: omit repository discovery report
Date: Wed, 26 Jan 2011 08:53:11 +0700
Message-ID: <AANLkTimrRSkbzULnaQhrhA2LQSgEPH95cWFbJGsAmvC6@mail.gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-2-git-send-email-pclouds@gmail.com> <20110126004915.GA11230@burratino>
 <20110126005916.GC11230@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 02:53:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhuZw-0006s1-6D
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 02:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424Ab1AZBxn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Jan 2011 20:53:43 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62703 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab1AZBxm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jan 2011 20:53:42 -0500
Received: by wwa36 with SMTP id 36so485888wwa.1
        for <git@vger.kernel.org>; Tue, 25 Jan 2011 17:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=5w/214+TqGDHX6v2kM5yPDMG9PD9Eyd+0UDHptsJlVY=;
        b=ooGTGGybDCTXbAjnzy0LzF812pEfm/YZfNo9p3Zvwy/mCr2q8541i683JP2LHM2gRf
         Eg0QMFjPf91uwk/ucESawHoUfLmBY5IHjiJXbXsCidmvYtHApEDuGNGAU/ukCSPriXlV
         5J3vBKBk4g0NRjULQxnXAQI7po8n1+U8Be9g8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=aNvaeKlaxfKqir3pz9ZJNo7yLN1YPgzC9pHFhJAL35lmShm4dNn4FDlaLepYri/jOT
         0fIncNLQXveBOCBAGWyrUBQILQD1Ybg1xbJQM7J1d0Y+KlXhQroqcpfQXTcSfsNuG+vK
         u8IPpbv3QY28Kk2CHXz120M2Dab9mHxP6sWik=
Received: by 10.216.242.136 with SMTP id i8mr580791wer.19.1296006821430; Tue,
 25 Jan 2011 17:53:41 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Tue, 25 Jan 2011 17:53:11 -0800 (PST)
In-Reply-To: <20110126005916.GC11230@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165498>

2011/1/26 Jonathan Nieder <jrnieder@gmail.com>:
> +int main(int argc, char **argv)
> +{
> + =C2=A0 =C2=A0 =C2=A0 static struct startup_info test_startup_info;
> +
> + =C2=A0 =C2=A0 =C2=A0 startup_info =3D &test_startup_info;
> + =C2=A0 =C2=A0 =C2=A0 setup_git_directory();

I think you should do _gently() here (in future maybe, because t1510
does not use it yet).
Note to self, support for testing setup_work_tree() behavior.
--=20
Duy
