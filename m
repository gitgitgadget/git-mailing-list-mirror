From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: fetch and pull
Date: Mon, 16 Mar 2009 16:03:59 -0400
Message-ID: <76718490903161303h45e47a8co83159e32ae749352@mail.gmail.com>
References: <AcmmaYOKDtJohyDSQt2B3xvVeIPNPw==>
	 <450196A1AAAE4B42A00A8B27A59278E70A2AEF9A@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 21:06:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjJ43-000393-7F
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 21:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbZCPUEH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Mar 2009 16:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752173AbZCPUEF
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 16:04:05 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:6497 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835AbZCPUEC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2009 16:04:02 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1747126rvb.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 13:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5DThmfnx/1ApSe7xzWjV9t94PnorwgP3Ofa6iDBXhiw=;
        b=VGSdLsVtyi/K268e8Mig4AkgrRIQVsybk/SEqjVTL+Vvce2OhUmo8VBfMwwMJ9zE0b
         HcCcn1CVkhgqdzWJSk0k4ub3DFeAk/YYwIl04SeY1FMIFTMj+myLNCHpJ4rXs7pgFOY/
         XBHG4AT6c03MASlM33+e6apN/jxrBqY1zNc/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=op8VdhXpXGaUPR48lzXOnwek5rNZr6WTe783HS1SwUV+8Sr7Hrw4FAkgDyp4F6LwiH
         cOchYzJHSeOKmF0fU2qB7uaYsbZCZTYKM0FHR1me4nZQnydAOMXfnrVy5zBeDQLL1X2D
         5uppSSbqLhe+G6jw+/YZ9wmRFJa2WVhQX+hYs=
Received: by 10.141.13.13 with SMTP id q13mr2478205rvi.163.1237233839661; Mon, 
	16 Mar 2009 13:03:59 -0700 (PDT)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A2AEF9A@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113359>

On Mon, Mar 16, 2009 at 3:00 PM, John Dlugosz <JDlugosz@tradestation.co=
m> wrote:
> =3D=3D=3D Re: =3D=3D=3D
>> So, after inspecting the changes, how do you fast-forward your local
> dev
>> to sync up with origin/dev?
>
> $ git push . origin/dev dev
> =3D=3D=3D end =3D=3D=3D
>
> That did not work. =C2=A0It just reports "everything up to date". =C2=
=A0If I
> understand the point of what it does correctly, I think
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git push . +origin/dev:dev
>
> is correct.

You very likely do not want the '+' at the start:

$ git push . origin/dev:dev

j.
