From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] core: use env variable instead of config var to turn
 on logging pack access
Date: Sun, 9 Jun 2013 03:18:04 -0400
Message-ID: <CAPig+cRK+mcPXpsUZSQH1hHx3E2Aq+S_44rV0sytLnGBHh+1xg@mail.gmail.com>
References: <1370755369-30868-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 09:18:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZtJ-0002Jt-KR
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 09:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583Ab3FIHSJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 03:18:09 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:36372 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab3FIHSG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 03:18:06 -0400
Received: by mail-la0-f50.google.com with SMTP id dy20so2568025lab.23
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 00:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QRSacsBhQTd5QJa7uBnok8QlFjafFFRsXNE2yUwy8tc=;
        b=fE/bq/wOjwWzm0Z/yc33DmDNRhtNujmwKhB5i7ZRguARzIvJCru16F/5eeVMYCJQTt
         n4TNkeTikptbcgXQmFPNjilIg9JHS+7zpIqr6Y9gqsBf2kkalhJn149/MdYN3QqZTHJf
         ZsENJGCR8tlgohur6RkL0xJ27KQiBuldOnmKFK03O2VCP2LK8ZYbgojk4UwpQz6L+nYB
         DpxqHTQsvrqe54+uHtB4HjWNk9Mhz+FlLHkLqjeTdM0cyGmbGHBIthBiP5tms9yTuc6g
         1W3iZ/0o8e/iSgXIGweAswXloG6JrAb8w9tkSPZG6FIJcwIVwQywjmt1ZQVb67RXSfTu
         UdLA==
X-Received: by 10.112.219.133 with SMTP id po5mr4101259lbc.80.1370762284887;
 Sun, 09 Jun 2013 00:18:04 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Sun, 9 Jun 2013 00:18:04 -0700 (PDT)
In-Reply-To: <1370755369-30868-1-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: EeyO_O90sYq3YwoyVgFbuZXOqtk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226939>

On Sun, Jun 9, 2013 at 1:22 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> 5f44324 (core: log offset pack data accesses happened - 2011-07-06)
> provides a way to observe pack access patterns via a config
> switch. Setting an environment variable looks more obvious than a
> config var, especially when you just need to _observe_, and more
> inline with other tracing knobs we have.

s/inline/in line/ (IMHO)

Or: "..., and akin to other tracing knobs we have."

> Document it as it may be useful for remote troubleshooting.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
