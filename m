From: "Marius Storm-Olsen" <mstormo@gmail.com>
Subject: Re: [PATCH 05/14] Change regerror()
 declaration from K&R style to ANSI C (C89)
Date: Fri, 21 Aug 2009 16:54:37 +0200
Message-ID: <MkR5snRY4WKN.p6tnmVsm@smtp.gmail.com>
Reply-To: "Marius Storm-Olsen" <mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 16:55:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeVWt-0002vp-Tg
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 16:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbZHUOy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 10:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbZHUOy6
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 10:54:58 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:42885 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932364AbZHUOy5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2009 10:54:57 -0400
Received: by ewy3 with SMTP id 3so703872ewy.18
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 07:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-language:content-type
         :content-transfer-encoding;
        bh=+FxHQww224SYnWTblIiyhqwfTx4MFY0u54FHH2O1nek=;
        b=mAN0v0QjmAxsGIrc5WyG+tZe965n4fHBDGuNoK55FDjJ5TxQ7aV4dmopKxTJd8pIOW
         d6LLoElYtDtKjoz98+zwWV0Di2vhNZ6iqaFmEg0FzE1RMJ5G5Vcf4dqEwcZXQ+A2HOjB
         LjGZ760NQebUmeA9/XAFnEPxONaEF23G84gh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-language:content-type:content-transfer-encoding;
        b=BizMdQ9eSHeBwj0Opk03YTio6pB2duPbR4uTOx9lLpVA2SQ22fGYhe/51HWH/wkx/R
         h3oCNaVnGIOPfr8Luce+Q5hxj+rx6hCgKZwwYpJJBGcKaahyniCTuPEROkpzcmgzz2py
         40BzNv7RVqK5RFcX5bSYk1Bg3DW30jUkPOeLI=
Received: by 10.210.88.3 with SMTP id l3mr1548527ebb.96.1250866498536;
        Fri, 21 Aug 2009 07:54:58 -0700 (PDT)
Received: from ?10.253.85.230? ([89.9.12.86])
        by mx.google.com with ESMTPS id 7sm3109458eyg.5.2009.08.21.07.54.56
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 07:54:58 -0700 (PDT)
X-Mailer: EPOC Email Version 2.10
Content-Language: i-default
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126730>

From: Frank Li <lznuaa@gmail.com>
>  size_t
> -regerror (errcode, preg, errbuf, errbuf_size)
> -    int errcode;
> -    const regex_t *preg;
> -    char *errbuf;
> -    size_t errbuf_size;
> +regerror(int errcode, const regex_t *preg,
> +        char *errbuf, size_t errbuf_size)
>  {
>
> The true reason is MSVC type define errcode as int.

Ok, will reword it.. Thanks.

--
.marius @ phone
