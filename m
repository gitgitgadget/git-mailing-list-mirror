From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/4] tree-walk: copy tree_entry_interesting() as is from tree-diff.c
Date: Mon, 6 Sep 2010 09:22:38 -0600
Message-ID: <AANLkTikmTcKdEjwX+3+BZoV25cJQk=XDC4V03kc5G44s@mail.gmail.com>
References: <1283645647-1891-8-git-send-email-newren@gmail.com>
	<1283748429-31076-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 17:22:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsdWv-0001JQ-PU
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 17:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592Ab0IFPWl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 11:22:41 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53426 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843Ab0IFPWk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 11:22:40 -0400
Received: by fxm13 with SMTP id 13so2504583fxm.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 08:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=a4DaVpT3ZgCSIwgP5eLtMCaX1lU/5gwfU7xZSZhznzs=;
        b=D29WWScO1caQTJ8c2macRatYW6MltOxlMJKKUxQCyIESY7NJTegHA8bpImbC3nEh/e
         BLtKbP8+sRl5KHeUHJh01el76PwpxEnIUru+kIHkxcKIvf1cd9bhTwAogkV3kUxKMBvm
         vcBqN18VLCrlnGq4WgxHrWODsf+MBZ+hfaBhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=d8fZblZuLghSGMSZoeWyyeBKCmOWuJI+iDj+XdhX+b/GBe92qwHfW5mmgnwlpksHHX
         dKvauED7iO3P8WJUhaiCN5msUydfaz2jWyV3pQc2asu5XI72sLvCRQQ70RGRquRI5YcP
         S8OSqxOjjowlYfPq+IvPLRyZGAh3BNM02H61o=
Received: by 10.223.122.194 with SMTP id m2mr1093068far.30.1283786559021; Mon,
 06 Sep 2010 08:22:39 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Mon, 6 Sep 2010 08:22:38 -0700 (PDT)
In-Reply-To: <1283748429-31076-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155575>

2010/9/5 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>:
> Just a straight copy. The function is not used anywhere. It is to
> separate changes that will be made to this function in the next patch=
=2E

Why copy instead of move?
