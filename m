From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: unpack failed --- is my repos broken?
Date: Thu, 22 Jul 2010 00:12:41 +0800
Message-ID: <AANLkTimhS92IX7knat-1hQeGzCuJ1qMLVzwdvlST7kWO@mail.gmail.com>
References: <4C45A7C5.1050601@llaisdy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Ivan Uemlianin <ivan@llaisdy.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 18:12:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obbub-00061p-LZ
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 18:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758255Ab0GUQMm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jul 2010 12:12:42 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54399 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758108Ab0GUQMl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 12:12:41 -0400
Received: by pvc7 with SMTP id 7so2660343pvc.19
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 09:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YxsnV/ODGCeBMYLZT6UWn+VVjv56KyoAtEGBUjVQ/iI=;
        b=n8rzq3CVOOCgP72mGpRALRDqLmPHFh1KmXCtTXEkv+jltoqXIVpIq16H0sTqapRG/E
         +XtuFegKHQSlAqBsmpsFmU2obhH2EWK8Aj27ueo2pdWTG0DQ/t37bef8hnF78IZ3L/Ns
         vGj3qTxb3NavBEgkHbIBgY/C7oL7A2oNEpcVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Rvs/45hVqirC5Y1PvTD2Y2w6YXWfNKWPhSNDzNjTAkJPpf2ByMCuSL/6oNqp60jHd7
         urJvDI/sFwXJtMU2CfazFIzXeBF2edWOtn6ehTRgCJwgshgTqUjO03Z+6F9rxRcrPeMQ
         1nmn6f25JE3bNOFfUpUADwNui5E7tsBtRP4Ww=
Received: by 10.142.224.7 with SMTP id w7mr463151wfg.130.1279728761408; Wed, 
	21 Jul 2010 09:12:41 -0700 (PDT)
Received: by 10.231.153.12 with HTTP; Wed, 21 Jul 2010 09:12:41 -0700 (PDT)
In-Reply-To: <4C45A7C5.1050601@llaisdy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151404>

Hi,

On Tue, Jul 20, 2010 at 9:42 PM, Ivan Uemlianin <ivan@llaisdy.com> wrot=
e:
> =A0 =A0$ git push
> =A0 =A0Password: ...
> =A0 =A0Counting objects: 5, done.
> =A0 =A0Delta compression using up to 2 threads.
> =A0 =A0Compressing objects: 100% (3/3), done.
> =A0 =A0Writing objects: 100% (3/3), 410 bytes, done.
> =A0 =A0Total 3 (delta 2), reused 0 (delta 0)
> =A0 =A0error: unpack failed: unpack-objects abnormal exit

Have you checked for repository corruption on the local side? You
might be pushing bad stuff to the server.

--=20
Cheers,
Ray Chuan
