From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 2] count-objects: add human-readable size option
Date: Thu, 14 Aug 2008 10:09:14 -0400
Message-ID: <48A43C8A.9010309@griep.us>
References: <1218657910-22096-1-git-send-email-marcus@griep.us> <1218687684-11671-1-git-send-email-marcus@griep.us> <48A3E142.9060606@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Aug 14 16:10:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTdX5-0006Xk-Cs
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 16:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbYHNOJU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 10:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbYHNOJU
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 10:09:20 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:64545 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbYHNOJT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 10:09:19 -0400
Received: by gxk9 with SMTP id 9so2239606gxk.13
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 07:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=goF0iGdxWl1FyBSR7u+auImJkE8aNpBFVGi/WUrIHzY=;
        b=xJaFmHOL6gQ2+V9OXXGicEJWEO5enDM6VwyEfxgFAYf0FfKe9dxWecAPhCoUhbcGQQ
         7QGvvCk3wCgjFB7MAyhZPm3txeLEcyBhbi5ED7Gb0mQLQnlGUkEOKka5sLVSVb5NTJtl
         ak92B9qatb4FG2RzLRftnZ8pXrSClCCOCJ8Ws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=iHH+/Wqx3khxCrkohFoa52Fu1SX0EViEY6Fhc6taCF7RzyeWYHr+taUrdmubbEAol8
         MHf5qGnqITr4TRvRQ9PnvyS5li+4mydxg1vUevG8Re4vnNx3Yc90HAXoTcOJMbEYAeQX
         fAVNjCIlZA3KLVbCKNuNTr8VBVZJSZDpHc9NY=
Received: by 10.151.46.3 with SMTP id y3mr1866673ybj.89.1218722958302;
        Thu, 14 Aug 2008 07:09:18 -0700 (PDT)
Received: from ?192.168.1.3? ( [71.174.65.78])
        by mx.google.com with ESMTPS id r28sm184619ele.13.2008.08.14.07.09.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 07:09:17 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <48A3E142.9060606@viscovery.net>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92362>

Johannes Sixt wrote:
> No need to die here. Just make the buffer large enough, and you can h=
ave
> something that is as large as 18446744073709551615Y.

In my initial rendition, the output was guaranteed not to be longer tha=
n 5
characters.  However, you're right that there's no need to die, but per=
haps
just return a negative value equal to the size over the user's requeste=
d
maxlen.

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
