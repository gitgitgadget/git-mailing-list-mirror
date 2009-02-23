From: bill lam <cbill.lam@gmail.com>
Subject: [tig] how to format main view
Date: Mon, 23 Feb 2009 13:35:22 +0800
Message-ID: <20090223053522.GA7435@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 23 06:37:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbTUx-0006HA-9V
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 06:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbZBWFfa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Feb 2009 00:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbZBWFfa
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 00:35:30 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:25863 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbZBWFf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 00:35:29 -0500
Received: by ti-out-0910.google.com with SMTP id d10so1320817tib.23
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 21:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=HyTK6YbT0lMv/gLg0arg4MKXgflhst/gB2yMixJnm2A=;
        b=jnth8DbZV/cN5fVWf2a8K1DbrLyk8n6IXWdLNbkUWHOZSLNLtNqYCQ4NmBz5bUA/7U
         clYVQqU5GQgT44SU9UkWNb4U4zZTdmhROGgxSfiEgyKt1+Y9Us+YRPZuUUt0K8dJUI4m
         X7dwFY6TXb5gg/LERDETb0PfXq+4mRAgefRb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        b=Im0KZzSRH/1rDh6smFqEK+fbzkb0SaV9K5GA4T3xTViAq9RcTAex5mRuodilnbNZZ7
         xc5o+2NkkBblwmC274ZRaCWKrqkgBinJOVGuZwJWwSmg7MvvvB+aGoSlbhHo1LFXeH2H
         gW9ByVk+e+oy3uY0pwWK5i2vjz/zVV+PPyWdo=
Received: by 10.110.68.10 with SMTP id q10mr5288949tia.32.1235367327854;
        Sun, 22 Feb 2009 21:35:27 -0800 (PST)
Received: from localhost (n219078081066.netvigator.com [219.78.81.66])
        by mx.google.com with ESMTPS id y5sm139893tia.37.2009.02.22.21.35.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 21:35:27 -0800 (PST)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111087>

In the main viewi, it default to show date and author but not sha1.
How to set it to format as in

git log --graph --pretty=3Dtformat:'%h %s' --decorate

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9134 =E5=8A=89=E5=B8=B8=E5=8D=BF  =E9=80=81=E6=9D=8E=E4=
=B8=AD=E4=B8=9E=E6=AD=B8=E6=BC=A2=E9=99=BD=E5=88=A5=E6=A5=AD
    =E6=B5=81=E8=90=BD=E5=BE=81=E5=8D=97=E5=B0=87  =E6=9B=BE=E9=A9=85=E5=
=8D=81=E8=90=AC=E5=B8=AB  =E7=BD=B7=E6=AD=B8=E7=84=A1=E8=88=8A=E6=A5=AD=
  =E8=80=81=E5=8E=BB=E6=88=80=E6=98=8E=E6=99=82
    =E7=8D=A8=E7=AB=8B=E4=B8=89=E9=82=8A=E9=9D=9C  =E8=BC=95=E7=94=9F=E4=
=B8=80=E5=8A=8D=E7=9F=A5  =E8=8C=AB=E8=8C=AB=E6=B1=9F=E6=BC=A2=E4=B8=8A=
  =E6=97=A5=E6=9A=AE=E5=BE=A9=E4=BD=95=E4=B9=8B
