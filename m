From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] tree.c: update read_tree_recursive callback to pass
 strbuf as base
Date: Sat, 8 Nov 2014 18:03:25 +0700
Message-ID: <CACsJy8AHXkZexzOvhUL+ooi1v9fM0NgK_Lb-NYCP2zY+8p06=A@mail.gmail.com>
References: <1415444432-18596-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 08 12:04:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn3oG-0000lR-M1
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 12:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582AbaKHLD4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2014 06:03:56 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55580 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519AbaKHLD4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Nov 2014 06:03:56 -0500
Received: by mail-ie0-f174.google.com with SMTP id x19so6545609ier.5
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 03:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=DQt9VfmN40Yyq+cw34i2/sxPrvJ+4JhFKv8tnpIkzo0=;
        b=X7IFKn1HYZ1Wgj2L7o1ZTdnX6QdI1GSq4J0yJ7oUf9qDaKmKp7CC0C5w78pIs/tdvK
         3ezGvsfaVQf8iZsmx+aBANNsc76ZxB6lIxt16jRQu/EdaEh61T+0Z9e1B9lrCfOcoww/
         YGC17D0EkPa8PFxvEkWE9e7UN/Gpix/4lqhkUMejKJSkKhq85c7coSEfHKYNYstdPAfM
         pyuGDaiUQOIs4aC4WgwIhj9e3OU2/IV7dFQpGUPd+KZJR/M3XaZnZ15qXQQWq7O97xso
         wsWGJPOMib880lfvh25mNJd0MrWBqyzO0kP6WmYMzTNrZtPvEJyGkhotWEitSlv1obRC
         D2sg==
X-Received: by 10.50.108.78 with SMTP id hi14mr10812688igb.27.1415444635289;
 Sat, 08 Nov 2014 03:03:55 -0800 (PST)
Received: by 10.107.176.8 with HTTP; Sat, 8 Nov 2014 03:03:25 -0800 (PST)
In-Reply-To: <1415444432-18596-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 8, 2014 at 6:00 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> This allows the callback to use 'base' as a temporary buffer to
> quickly assemble full path "without" extra allocation. The caller has

Errr.. the _callback_ has to. restore...

> to restore it afterwards of course.
--=20
Duy
