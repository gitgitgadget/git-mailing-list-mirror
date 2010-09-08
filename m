From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] sha1_name: allow to add @{...} alias via config
Date: Wed, 8 Sep 2010 11:53:53 +0200
Message-ID: <AANLkTin83BQ0YhWHuDqkY4HYWP9+bUso1BDNbFtRskDp@mail.gmail.com>
References: <1283918641-3662-1-git-send-email-pclouds@gmail.com> <AANLkTimK6MwJHYafAAYNn+h3HD1f0H-BHsQYph4qbCrJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 11:54:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtHMG-0008Et-1j
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 11:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756257Ab0IHJyS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 05:54:18 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54900 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973Ab0IHJyO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Sep 2010 05:54:14 -0400
Received: by iwn5 with SMTP id 5so6224818iwn.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 02:54:14 -0700 (PDT)
Received: by 10.231.170.79 with SMTP id c15mr82607ibz.82.1283939654177; Wed,
 08 Sep 2010 02:54:14 -0700 (PDT)
Received: by 10.231.30.193 with HTTP; Wed, 8 Sep 2010 02:53:53 -0700 (PDT)
In-Reply-To: <AANLkTimK6MwJHYafAAYNn+h3HD1f0H-BHsQYph4qbCrJ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155777>

2010/9/8 Santi B=C3=A9jar <santi@agolina.net>:
> 2010/9/8 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>:
>> This allows users to add new @{..} alias via ref-at.* config
>> variables. The rewrite rule is printf-alike.
>
> Another issue is that it can shadow builtin @{}s, like @{upstream}.

In fact this patch breaks @{upstream}.

Santi
