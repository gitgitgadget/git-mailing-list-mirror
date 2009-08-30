From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: Anyone meet DNS fail translate repo.or.cz
Date: Sun, 30 Aug 2009 12:50:02 +0200
Message-ID: <237967ef0908300350k4e06b522x9baa7aa5528d32d@mail.gmail.com>
References: <1976ea660908292120r7e7ec941he7573671251451f5@mail.gmail.com>
	 <40aa078e0908300339j74e9c542x3436ec2e58e4b874@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 12:50:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhhzG-0002RC-8q
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 12:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210AbZH3KuE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Aug 2009 06:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753096AbZH3KuD
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 06:50:03 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:37518 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139AbZH3KuC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Aug 2009 06:50:02 -0400
Received: by fxm17 with SMTP id 17so2286652fxm.37
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 03:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZwL0h5RcbLwL54GkVIJuSSkbK4OWstZqCRBJhnQgrAQ=;
        b=x1TK3TBkSxD/2/67CBIsPqUf7NQ0hSAGMMVJXGtVJCaIC5mHTnRf/8twlqnbDL7A+k
         +bivl7wLDEDaS/8+G6eBDFoyTMdXw4bkx29svjIqO6dY4gfdOiOI/cg3IYJKtD2kYoy1
         E7kbE18XZxqjqr6lC8acXN+spe7VjKLIYPvNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cbDn18TRFkaMRvNRecwYTpAAUY/koQYxKK8k9M651Ocgy4rGy65nZpGsS7iXU/w5oO
         gRkbw+ZqkWpl3QfHoWtTN9MKIE9qgouEZHfwW+sgxabQ/Bl5F11s7qc/YSPX4kKSC5ym
         cqoeypdyZf1w1ETiZ2aYiff34RcTuL2wTMazE=
Received: by 10.204.7.195 with SMTP id e3mr3027795bke.118.1251629402965; Sun, 
	30 Aug 2009 03:50:02 -0700 (PDT)
In-Reply-To: <40aa078e0908300339j74e9c542x3436ec2e58e4b874@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127409>

2009/8/30 Erik Faye-Lund <kusmabite@googlemail.com>:
> On Sun, Aug 30, 2009 at 6:20 AM, Frank Li<lznuaa@gmail.com> wrote:
>> ALL:
>> =C2=A0 =C2=A0 =C2=A0 I can't access repo.or.cz from yesterday.
>> =C2=A0 =C2=A0 =C2=A0 DNS can't translate repo.or.cz.
>> =C2=A0 =C2=A0 =C2=A0 Even
>> =C2=A0 =C2=A0 =C2=A0 http://www.dnswatch.info/dns/dnslookup?la=3Den&=
host=3Drepo.or.cz&type=3DA
>>
>> =C2=A0 =C2=A0 =C2=A0 It also can't recognize repo.or.cz.
>>
>> =C2=A0 =C2=A0 =C2=A0 Anyone meet the same problem?
>
> Yeah, I've been seeing the same problem here.

The IP for both repo.or.cz and git.or.cz is 62.24.64.27
If you add this to /etc/hosts you can still access both fine.
62.24.64.27             repo.or.cz git.or.cz

--=20
Mikael Magnusson
