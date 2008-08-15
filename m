From: Marcus Griep <neoeinstein@gmail.com>
Subject: Re: Empty Directories
Date: Fri, 15 Aug 2008 17:42:46 -0400
Message-ID: <48A5F856.5050205@gmail.com>
References: <4b6f054f0808151420t59001ba3k2fecb19a73e5addb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Trans <transfire@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 23:43:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU75N-0007bG-Gc
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 23:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754015AbYHOVmu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2008 17:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753937AbYHOVmu
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 17:42:50 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:52706 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868AbYHOVmt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 17:42:49 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1223332wri.5
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 14:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=8Y86RGHjsLExvBoiWrh1Sr2ONLYRxKKa9C0prINBi0U=;
        b=d82DCHb/om9MHR2yAmHXsKKfJYyU6dOGzXaJLHwrKEu1eg+wZEssSowy6rqw8FypF5
         l/4HPXHy4MZu5m2tLIgtp4aOFEMa9hO10cAfhjIKeiaY0b+4MzyMkLhZq3Hc4AnnzlTA
         ZYg80qDrDdb/3Rg8RyeW/4s/BvKC5OBMVJE7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=VtRXei3ZXkHcHwQ0A7Ud4Gxkc6OdBf/jOrzvUhJNzD/+7lSxNBEPW8vQHlTyf3E67U
         87gkq54bqznDCFe08YOYdfCJTSrmacNCc/44I8UJRV9kpVuWnAXvyF9FFUak/rC0slt1
         DBm5lk60WrnHc06ke5GKKeOfT8ti28utBshnI=
Received: by 10.90.67.10 with SMTP id p10mr4316843aga.70.1218836568926;
        Fri, 15 Aug 2008 14:42:48 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id 5sm5972460wrh.24.2008.08.15.14.42.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Aug 2008 14:42:47 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <4b6f054f0808151420t59001ba3k2fecb19a73e5addb@mail.gmail.com>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92520>

Directly, no.  An easy workaround is to drop an empty file
(such as a .gitignore) into the directory and track that.
Then the directory will come along for the ride.

Trans wrote:
> New to git...
>=20
> Is it true there is no way to track empty directories?
>=20
> Thanks,
> T.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
