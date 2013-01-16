From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] attr: fix off-by-one directory component length calculation
Date: Wed, 16 Jan 2013 08:03:25 +0700
Message-ID: <CACsJy8AxUfi0kY_tSy2AfmQSfUiFs3von3FUexJQxo2+kYQSiw@mail.gmail.com>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com> <201301152014.28433.avila.jn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <avila.jn@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 02:04:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvHQO-0006YC-CP
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 02:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757246Ab3APBD4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2013 20:03:56 -0500
Received: from mail-oa0-f54.google.com ([209.85.219.54]:61285 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757218Ab3APBDz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 20:03:55 -0500
Received: by mail-oa0-f54.google.com with SMTP id n9so854261oag.27
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 17:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=86ZYHhLGvXkpV0pKxcixtRhdQ0gKAkvCajfj9IbJg3Q=;
        b=JWEKWy2BnjXV0FLumcNi9ffcfKQsL5qL/9GvbBDHfer/br65/h3QK3oviRv9zWm2cw
         firi6Jjxx7icUHDND3ip3VLAh1ezQaL9hS5tJUP87hWR+smLODT7ar0Lgw8gUValDO74
         Hi4fR7L+dtV5DFOW+/JVU4gaSwIiv39dEfKc50f8p6imMwB/kyEBQ+BkdJb943kH7Kkx
         YeP9WGnT+Tny7S8T3kjVH4KN3ORaVEkcsvwlsK6jMvTnGn+rkT+yQ2hCuZwKx0dtTRvK
         p7CRtns+kWiNavrob1rtMupI25b92fB4LRiy27odeqqB7KiUBRgDCErUijdhDhTZPLkZ
         7Z7g==
Received: by 10.60.8.131 with SMTP id r3mr55675519oea.14.1358298235129; Tue,
 15 Jan 2013 17:03:55 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Tue, 15 Jan 2013 17:03:25 -0800 (PST)
In-Reply-To: <201301152014.28433.avila.jn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213698>

On Wed, Jan 16, 2013 at 2:14 AM, Jean-No=C3=ABl AVILA <avila.jn@gmail.c=
om> wrote:
> I did not monitor the system calls when writing that patch.
> Where is the perf framework?

It's in t/perf. I think you can do:

=2E/run HEAD .

to run and compare performance of HEAD and working directory (assume
you haven't commit yet). Check out the README file.
--=20
Duy
