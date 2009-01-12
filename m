From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [RFC PATCH 4/3] Add example git-vcs-p4
Date: Mon, 12 Jan 2009 12:46:32 +0100
Message-ID: <81b0412b0901120346x79772846p6e5097028fc9720c@mail.gmail.com>
References: <alpine.LNX.1.00.0901110336380.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jan 12 12:48:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMLGw-0005FD-UA
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 12:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbZALLqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 06:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbZALLqf
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 06:46:35 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:20224 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbZALLqe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 06:46:34 -0500
Received: by wa-out-1112.google.com with SMTP id v27so5565224wah.21
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 03:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Z40cueVJ0cn16aVuCuMVOvMtiDH7aaQEDb2O0dcd5RU=;
        b=cRCPUMwdMX40ayuN4y6C+ZJPsMFew0ojUsJJkhN0sgXyxC22jJOKyj0EcT/I7ZoQZ8
         gpe8YBvQ/A76kem34c6LE7UAEQouXkFc9OAVCQLD6RvV0p9KoYsJ9PmDCd416LGbYYCR
         P9TklcBrkkYCIZvde9OZJsvjtDEWCCZdPzhm8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Pr5n734w8XQWsmreGYTA156jobOYhhp7xmOznsFr7MyVJWDIyrHBEaBimsyOWRSZfV
         Gv954h7+MpjQtiNCIZ3XMBinJm4xdSp1Rxsx/wdUNNU9aTZW3Yp1zzx09ksE4cJVKW2a
         4Wodv2OJEBP7w5cgODRzf2hgAx96AhuubiB54=
Received: by 10.114.81.1 with SMTP id e1mr18994183wab.136.1231760793312;
        Mon, 12 Jan 2009 03:46:33 -0800 (PST)
Received: by 10.114.179.4 with HTTP; Mon, 12 Jan 2009 03:46:32 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0901110336380.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105330>

2009/1/11 Daniel Barkalow <barkalow@iabervon.org>:
> diff --git a/Makefile b/Makefile
>
> +LIB_OBJS += p4client.o
> +LIB_OBJS += vcs-p4.o
> +
>
> +extern int cmd_p4(int argc, const char **argv, const char *prefix);
> +

Why is your foreign VCS importer built-in? The majority wont ever need it,
yet they have to pay the price for its text being in git executable.
