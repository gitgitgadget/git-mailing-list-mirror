From: bill lam <cbill.lam@gmail.com>
Subject: Re: pre-commit hook
Date: Sat, 21 Feb 2009 11:57:48 +0800
Message-ID: <20090221035748.GC7409@b2j>
References: <20090220091127.GA7415@b2j> <7v63j5t6r3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 05:00:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Laj24-0006T2-3A
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 05:00:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803AbZBUD55 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Feb 2009 22:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752726AbZBUD55
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 22:57:57 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:48741 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbZBUD54 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 22:57:56 -0500
Received: by ti-out-0910.google.com with SMTP id d10so820770tib.23
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 19:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cZi4n74qrxqa74/ZXzG7XUrpfkl54t8DFgDBc19bqK8=;
        b=l1d5V+vRyipD64T5e1DduCf1jnza4F4t2I2/WYHhh4p2lu9CAPUqcc+UUu1a/gBQST
         aBoEHOydgO6iMUXez3QdP566V7L2bfC8BIp8q8fIt1HAFt7US30Qz7bm3cxTlxXU8FS8
         HL8tROX+jw8SlMIThXJa/2TzVQFFkp2rSDKqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=ROgOhkG5tRZvrXmww7mWNY2TBJJ4I4Cgd+0WnbeF/WcPlWqY58xMEo2wXgVRUqCBkd
         Cy4XAV4qKG6sKDEd+tO/Uj7KcuJE8fw8Kr2xxfApwYRIfnDuDJhFnjF2kReEBV3ViJJR
         vEXt5z4RcOFNe8kN5A03OmhS2+SecF8fK5U2Y=
Received: by 10.110.84.3 with SMTP id h3mr2121830tib.5.1235188674586;
        Fri, 20 Feb 2009 19:57:54 -0800 (PST)
Received: from localhost (pcd431208.netvigator.com [203.218.221.208])
        by mx.google.com with ESMTPS id a14sm2541917tia.7.2009.02.20.19.57.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Feb 2009 19:57:53 -0800 (PST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v63j5t6r3.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110924>

On Fri, 20 Feb 2009, Junio C Hamano wrote:
>     if git-rev-parse --verify HEAD 2>/dev/null

Isn't git-rev-parse (and all git-??? ) was deprecated in 1.6.2 ?

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9311 =E7=84=A1=E5=90=8D=E6=B0=8F  =E9=9B=9C=E8=A9=A9
    =E7=9B=A1=E5=AF=92=E9=A3=9F=E9=9B=A8=E8=8D=89=E8=90=8B=E8=90=8B  =E8=
=91=97=E9=BA=A5=E8=8B=97=E9=A2=A8=E6=9F=B3=E6=98=A0=E5=A0=A4  =E7=AD=89=
=E6=98=AF=E6=9C=89=E5=AE=B6=E6=AD=B8=E6=9C=AA=E5=BE=97  =E6=9D=9C=E9=B5=
=91=E4=BC=91=E5=90=91=E8=80=B3=E9=82=8A=E5=95=BC
