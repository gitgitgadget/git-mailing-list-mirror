From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] Perform cheaper connectivity check when pack is used
 as medium
Date: Wed, 29 Feb 2012 08:41:33 +0700
Message-ID: <CACsJy8Cj+F+bNOBZiZq=xJJRAwq1QebSB8o-wxtyd9YGtd_Tjg@mail.gmail.com>
References: <7vmx849ma8.fsf@alter.siamese.dyndns.org> <1330435109-4437-1-git-send-email-pclouds@gmail.com>
 <4F4CF58A.9090502@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 29 02:42:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2YYi-0008Jd-Nu
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 02:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965500Ab2B2BmS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 20:42:18 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52195 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964841Ab2B2BmF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2012 20:42:05 -0500
Received: by wgbdr13 with SMTP id dr13so3248785wgb.1
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 17:42:03 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.74.177 as permitted sender) client-ip=10.180.74.177;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.74.177 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.74.177])
        by 10.180.74.177 with SMTP id u17mr44212537wiv.13.1330479723410 (num_hops = 1);
        Tue, 28 Feb 2012 17:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=m1A5Kfy3qi81ld7FYYs8hHi/aTvx7jyX7E5dO8oaiF0=;
        b=e2dJBgm/h4nrnhLOW/9TLYLMlY9edi2ZXXqdk37yRmZoN+KJNcBZNL2TeQSkwZi4AU
         PqRFKcnk3Ge79++5wBXGA6XbTvwdjA4/BPkCtExI5fLMwn2LGYCBOc7nhyeEKbJBBA+E
         HjctW+10Ls6Si+1wb4KlihZPgjXjSLAh+1DL8=
Received: by 10.180.74.177 with SMTP id u17mr35096839wiv.13.1330479723337;
 Tue, 28 Feb 2012 17:42:03 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Tue, 28 Feb 2012 17:41:33 -0800 (PST)
In-Reply-To: <4F4CF58A.9090502@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191800>

2012/2/28 Johannes Sixt <j.sixt@viscovery.net>:
> Am 2/28/2012 14:18, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
:
>> Without the patch:
>> $ time git fetch file:///home/pclouds/w/git/.git
>> remote: Counting objects: 125638, done.
>> remote: Compressing objects: 100% (33201/33201), done.
> ...
>> With the patch:
>> $ time git fetch file:///home/pclouds/w/git/.git
>> remote: Counting objects: 125647, done.
>> remote: Compressing objects: 100% (33209/33209), done.
>
> It is a bit irritating that the number are different when they should=
 be
> identical...

~/w/git is my working directory so objects may change a little bit.
Should have fetched from a clone instead, sorry.
--=20
Duy
