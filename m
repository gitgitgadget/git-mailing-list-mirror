From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/8] sha1_file: mark alt object database from add_submodule_odb()
Date: Tue, 30 Apr 2013 02:03:39 -0400
Message-ID: <CAPig+cTgehT8SGgXv7BtDgC+UVWkZ-4qvcQH69zoMPcm5ZNeog@mail.gmail.com>
References: <1367293372-1958-1-git-send-email-pclouds@gmail.com>
	<1367293372-1958-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 08:03:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX3fF-0007vC-Ty
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 08:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922Ab3D3GDl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Apr 2013 02:03:41 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:48047 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688Ab3D3GDk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Apr 2013 02:03:40 -0400
Received: by mail-lb0-f173.google.com with SMTP id v5so203453lbc.32
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 23:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cAWbjgbAxXNMlmyCx0MjgPp8ihx/+uOk+6MJl4Jn3/Y=;
        b=GVcxU2v5wVf3YAFQDOmyJypu3HlfCQ7UsYHb9QjvsyA5p/LZLf+U2AsmwMGHgDpcOw
         SlXz55o/as1rU/nYerKOz5CpGHa95+xYndimIAzpL6i6jSr6rsnOGfEKenNvsvmhKCJ5
         kva5yl6hGgGUllsnOQ3JJIhGdNQElHoeOjupBXGNWa+PYmc4YsPUVO41d+3+pUpdBCb7
         DoQgISgnVq9STQyBM+/mXekAB5jOWuw9/89XT/s4b+f+Xe+wQK4gY7iS8KBHdYWr2SrR
         0SkzPfMpaPkYsZspud0yeR4YuH7dWOaHqC9WttHAIT+qngEHggmJ0Jv7WAwA5bUXRHTC
         t/ag==
X-Received: by 10.112.125.167 with SMTP id mr7mr28309947lbb.19.1367301819206;
 Mon, 29 Apr 2013 23:03:39 -0700 (PDT)
Received: by 10.114.199.11 with HTTP; Mon, 29 Apr 2013 23:03:39 -0700 (PDT)
In-Reply-To: <1367293372-1958-4-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: snL7yxZrixvLjp_VxfwQGCqZQ0A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222907>

On Mon, Apr 29, 2013 at 11:42 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> A submodule's object database may be imported to in-core object pool
> for a quick peek without paying the price of running a separate git
> command. These databases are marked in for stricter checks later to

s/marked in/marked/ perhaps?

> avoid accidentially refering to a submodule's SHA-1 from main repo

s/accidentially/accidentally/
s/refering/referring/

> (except in gitlinks).
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
