From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Replace strcmp_icase with strequal_icase
Date: Sat, 9 Mar 2013 19:05:37 +0700
Message-ID: <CACsJy8D4Yqm3s+ALf=KnMQRQ6SrVcM5jjktpGXiGcOaqtEsyMg@mail.gmail.com>
References: <1362818574-16873-1-git-send-email-iveqy@iveqy.com>
 <CACsJy8CphBDKsAAKjCoze98jv=4U+3pN3cW1OYD5XNhYgfcVCA@mail.gmail.com>
 <CACsJy8BbXjJeTgo0DzKKMY7B3NZB=r3r+Z-WsWJR=t00DkTVzQ@mail.gmail.com> <20130309110815.GA8328@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sat Mar 09 13:06:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEIXs-0003BC-Dt
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 13:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757342Ab3CIMGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 07:06:09 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:61916 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755774Ab3CIMGI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 07:06:08 -0500
Received: by mail-ob0-f180.google.com with SMTP id ef5so2066971obb.11
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 04:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=soidyZgk2gCqj978zlxhlLGf9ofuJiVdC8R8bn3NfXI=;
        b=gLI2ehM9f6F7pn6CsXfBAOqWk4fK/m1WYZEeN8rkoBUx8D1njirjB5vL5Blo7r+/MH
         TRh0/lLsTGtzX/t1FyDNhBE+MSWstDg1r6xPnc8UHoIWr6qvn9lQebqhJtC0tuofljYT
         7NXrMi+Zxds65AFWyMNiDicq268Ukvw6itYoHbTSfuUaEEhQxqMAmWEO5gvNyn1YufUV
         qCAF92JdLpl0urxZ3uJoXviY2f+AwZKfJ7sEgQHyaN0vwJmMfAr+LPaHRpBG1QliXJiL
         j1vKEWVe+DtoDVML2pI5vyFSSuHp3t33AeqIeu6t38+am7+3ZBFI0c2N0xrcFELQgBHM
         TtJg==
X-Received: by 10.60.25.65 with SMTP id a1mr4434425oeg.40.1362830767783; Sat,
 09 Mar 2013 04:06:07 -0800 (PST)
Received: by 10.76.27.200 with HTTP; Sat, 9 Mar 2013 04:05:37 -0800 (PST)
In-Reply-To: <20130309110815.GA8328@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217723>

On Sat, Mar 9, 2013 at 6:08 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> Actually when implemented a str[n]equal_icase that actually should work.
> I break the test suite when trying to replace
> strncmp_icase(pathname, base, baselen)) on line 711 in dir.c and I don't
> get any significant improvements.

Hmm.. mine passed the test suite.

> I like work in this area though, slow commit's are my worst git problem.
> I often have to wait 10s. for a commit to be calculated.

Personally I don't accept any often used git commands taking more than
1 second (in hot cache case). What commands do you use? What's the
size of the repository in terms of tracked/untracked files?
-- 
Duy
