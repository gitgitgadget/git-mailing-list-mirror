From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Help with a possibly corrupt repo
Date: Tue, 11 May 2010 01:28:01 +0400
Message-ID: <20100510212801.GJ14069@dpotapov.dyndns.org>
References: <AANLkTiks5g7BvLXBrUcb0m5dCiIrBifjDUKBDScXd1dw@mail.gmail.com>
 <20100510201720.GH14069@dpotapov.dyndns.org>
 <AANLkTinYj624545WtRf8TayNkm6a_z3e6kiwRyHCjqtv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Cc: git@vger.kernel.org
To: Jonathan Leto <jaleto@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 23:28:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBaWT-0005SB-Pz
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 23:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159Ab0EJV2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 17:28:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:15989 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702Ab0EJV2F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 17:28:05 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1808444fga.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 14:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=RxOilHDWjnZA4PqC7o1GoNbedxnWpn/oK7DSNsl5o6o=;
        b=FbCoUby4/37oY82JS3nckhLhhwFKkoRRowMe49+EvjfRqP5qs7/eU33gBfqvBDhnNR
         WvOxzbz0lM26CGjlROTXZ3md7qpCHUNB5+ghZHqm6oqNMWYHNRj94f12nOequ0nSEpWN
         cI2lk1QSUVvSz2sovlZfaAN2kfKqOdbXpkBk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=g8cX1M/Pz7XC7lkPFO3qmzxx7kZ+/01CZHaWAr4TuiKUECpOhc/8ebmKMNlfMfXkbA
         6rHBUv8zLgpZOdKJuuw8nYNBBsDef1j7+Ewqp6JJBIVkoTb7A3R4lLbqhszn234vCeXV
         55kgxDnuz5/xA5mI4APQNhLCR42K0XDWMergY=
Received: by 10.87.70.21 with SMTP id x21mr10448785fgk.62.1273526884155;
        Mon, 10 May 2010 14:28:04 -0700 (PDT)
Received: from localhost (ppp85-140-167-246.pppoe.mtu-net.ru [85.140.167.246])
        by mx.google.com with ESMTPS id d8sm10871246fga.16.2010.05.10.14.28.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 14:28:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinYj624545WtRf8TayNkm6a_z3e6kiwRyHCjqtv@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146854>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 10, 2010 at 02:05:09PM -0700, Jonathan Leto wrote:
> 00020c0 deed 3541 7800 56dd 005c 0000 0000 0000
> 00020d0 0000 0000 0000 0000 0000 0000 0000 0000
> *
> 0003000
> error: garbage at end of loose object '66fdbaef5ae12a8402f6b0f7c1a73a3ce72e8eba'
> fatal: object 66fdbaef5ae12a8402f6b0f7c1a73a3ce72e8eba is corrupted

The object is "tree", and it contains a lot of zeros at end.
I have truncated them, and it appears to fix the problem.
I have attached the corrected file.

But the important question is how it could happen. What filesystem
do you use? Do you store it on the local disk or network share?


Dmitry

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=fdbaef5ae12a8402f6b0f7c1a73a3ce72e8eba
Content-Transfer-Encoding: quoted-printable

x=01+)JMU024c040031Qp,*J=AC=D4+=C8e=98=D5d=BC2h=9B=AE=F4=B7[=89=D2=EB=D5=8F=
/q]=14=C4
U=E3=94=9F=9F=03R=D2=DBk=BE}=89=A8k=D1=C4=E53d=15~=9FxQyq=96"T=89s~J*H=89L=
=BFS7=07=EF=F7V=E9}y=B3=19Vp=DFo
=DFk=0DWR=9AW=92Z=04R=D5=D8h1=BD=AF=DD=ED{=B8s=F1=DC=D9=3Ds=F7t8M=82=19=E4=
=91X=9C=01R=92=FB>=C4=FD=F8=99=85=9F=97=F6l=92=BF=F9=B1\z=FF=8C=EBUP=83=82K=
=8A2=F3=D2A=8A=EA=0FH+=E5=97n|=94=EA=A2^=A6;9=8B=D9=ED=DEA5=00x=DDV\
--dDRMvlgZJXvWKvBx--
