From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGit: kha/{safe,experimental} updated
Date: Mon, 19 May 2008 22:21:17 +0100
Message-ID: <b0943d9e0805191421n1ca676dai1b3ed7d6eb1df5f4@mail.gmail.com>
References: <20080514014309.GA17955@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon May 19 23:22:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyCo7-0007fv-2U
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 23:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756551AbYESVVU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 May 2008 17:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756644AbYESVVU
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 17:21:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:18958 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756454AbYESVVU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 May 2008 17:21:20 -0400
Received: by ug-out-1314.google.com with SMTP id h2so572864ugf.16
        for <git@vger.kernel.org>; Mon, 19 May 2008 14:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=M2Bg7waufZNtLTn4IOYxONAzQbNpQNFbxrH636fYKj4=;
        b=LbJdo1SmvRpPj7QlJ03iMwZ3qKiJqr/EOMlCToHXlq8gd7PZcPG3ieBfmDjle2dCTyamIOlgWRtofJHpPiMhKM73huoi6TqU5vHvbtaqIvRbI2pXG0GXz39LuPecFsh6oyKsyHisERQm+KZaBlgNbRuJ5yNgJJWEBKKycjju/9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ezhs6uVFFDRyTlh+c88NHHIFAIZlb85RkKhyQ6ucoa8l3M+G2c6/1HgtjZ2AERWKSeh1BM+VgZfq9BSJEmhaYowbO4DBvPH3OYLX910+7Gl7KUU4J+SMBRzvWl8nLjUiJsk+XHDt0HHaOnX3LBQtGGcjMmdklRuaWyIiEHN9obQ=
Received: by 10.66.221.17 with SMTP id t17mr4495036ugg.66.1211232077312;
        Mon, 19 May 2008 14:21:17 -0700 (PDT)
Received: by 10.66.255.4 with HTTP; Mon, 19 May 2008 14:21:17 -0700 (PDT)
In-Reply-To: <20080514014309.GA17955@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82452>

On 14/05/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> kha/safe has improved version handling: "stg --version" will now
>  present a detailed version number just like git does:
>
>   $ stg --version
>   Stacked GIT 0.14.2.152.g77bd

Thanks, I merged this patch. I create a similar patch some weeks ago
(just some naming differences and only use the id of the HEAD) but
went on holiday + a conference and forgot about it. Anyway, yours
looks fine but I'll modify it slightly to use just 0.14.2 if a file
named ".release" exists in the working directory. I did this with my
patch to allow building of release tarballs without the git
information. Do you have any better suggestion?

--=20
Catalin
