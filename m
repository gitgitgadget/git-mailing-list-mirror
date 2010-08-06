From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] pack-object: trim memory usage a tiny bit
Date: Fri, 6 Aug 2010 18:58:07 -0500
Message-ID: <AANLkTikphara-0NXaBZ-MAygytGYDuN6ANcMWE+Ni3mW@mail.gmail.com>
References: <1281114057-5982-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 07 01:58:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhWo6-00073m-Nr
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 01:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762200Ab0HFX6a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 19:58:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59016 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760423Ab0HFX63 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 19:58:29 -0400
Received: by iwn33 with SMTP id 33so1727107iwn.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 16:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=wnZ9FDM9LCFHw7v3eXz5J+Ia/wf5LvFHx0AAZwC6VSs=;
        b=qEZxm8pBKIJ0O9hMJng08TV3/WBxpLRbA+2z8+YBWGAA2tOMWpP6kLSi9GOfEP7gUm
         /DgT2gXw751UYj0k1fVVk4N0tSZlpdXJlDYLo1CaSRrfZzF3oA8OFvDftxZApfi8+ddw
         yrHv3E5cjAzxxo8A+7alheTg4AXl7BnF7NPTk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=J8oX6mbY/KQT5FpM9C+qniIChMF3B2wki3SKiKun6wERIYULuMPmKbG6FFsSzWim3f
         LNT17qAcfVCiBNVrBvuIdL/s7sAyXlIeR7Nl7UkLZO9LHX//kWFkkHnf1ypYwM9ALZ+z
         MGvEMmehLsm48TLv/tOljzUDx/SVW+Kt0tPBQ=
Received: by 10.231.13.77 with SMTP id b13mr13591890iba.28.1281139108466; Fri, 
	06 Aug 2010 16:58:28 -0700 (PDT)
Received: by 10.231.139.160 with HTTP; Fri, 6 Aug 2010 16:58:07 -0700 (PDT)
In-Reply-To: <1281114057-5982-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152826>

Heya,

2010/8/6 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>:
> This shrinks struct object_entry from 88 bytes to 80 bytes on my 32
> bit machine. So that would be 12M less on linux-2.6.git (1.6M objects=
)
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> =C2=A0Don't know if it's really worth a patch..

Either way, some explanation would be nice.

--=20
Cheers,

Sverre Rabbelier
