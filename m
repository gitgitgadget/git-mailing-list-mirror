From: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
Subject: Re: [PATCH v3 0/3] Tests for merge-recursive rename-options
Date: Wed, 24 Feb 2016 10:42:26 -0300
Message-ID: <CALMa68rbsfLK36cemQrybw5Pk3kqvqWLa7kPyCuqs65m49rkuw@mail.gmail.com>
References: <1456278091-6564-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipegassis@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 24 14:43:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYZiQ-0007oT-A3
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 14:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758118AbcBXNma convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2016 08:42:30 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:33713 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756AbcBXNm1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2016 08:42:27 -0500
Received: by mail-io0-f194.google.com with SMTP id g203so2150519iof.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 05:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=DN3+9cmnevS7dz1yDd6zEefLjAA3fkGdeqt1pDfvRlA=;
        b=tqhOjDVRNLy9winKoWKQ2wQY6CrYNTf+zi5rekQ54y1bn4igge1GoVNmsSDoSOs85y
         eZZgfkmVDG8kOMG8t5N86wqgYfZljyBXltqkmGntB+37WuJ9MvASdw7/t/NFde2MQFKK
         nEHfJOWHbfDM+36yGPWCBEriUXYXv2tUbDa0pyDhlL8AGJwoOgJNfokxwgn6nIPd1Ix1
         iv9gCj/o9rm4xGChrKu0irTmK+ZxFkvpux82Ijj87CqcaKqk0qtWY3gFCUHlnOpv/OBz
         /dubpWCOObqrvCBnB7XNp8SCG6cGSdJfBjrOxWmAFD23rROz37/EXcOeIPB8JDLgcO7S
         2zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=DN3+9cmnevS7dz1yDd6zEefLjAA3fkGdeqt1pDfvRlA=;
        b=J/qS3IZA5fJnRdTsQfIpWLntvZ6AR6PolyuCyfrD0k4PmiExpPI/8Clr/wYiDUWlja
         Gd8t3mKHcyhmIZVfh8HWkSt85r3EYlA/exVdmAjTDWiaH7kzI29tKTOYRqrZ1WoRq4//
         rBnLEPf3pv40nIRkSnbSHM3gfxytQ6aEJzyrbtHGKBO+eCs2gqMnj/HJvJNckFiewW2c
         0d30W3qmlkzD1Jdlz+hO39VxPtI7om5L0JPL8eiSWRC9i+bVRYTk5v0NjywUPTaDfZHY
         +KLU1HnI+ivO0vtydycDwvCAwqoUg+V4P0tiKIILmnkCiD8nGifwdoTW3QzQO8z2Q4VV
         f5Fg==
X-Gm-Message-State: AG10YOTRcuVWXgkCheyXaqRa/zasDFEZwq2lpqA4Pk0D3r+AaNJW7CiIh1r5WK6Mfn6x1HyNgiGTYyarNPiaGw==
X-Received: by 10.50.43.133 with SMTP id w5mr20813920igl.80.1456321346959;
 Wed, 24 Feb 2016 05:42:26 -0800 (PST)
Received: by 10.107.3.94 with HTTP; Wed, 24 Feb 2016 05:42:26 -0800 (PST)
In-Reply-To: <1456278091-6564-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287210>

On 23 February 2016 at 22:41, Felipe Gon=C3=A7alves Assis
<felipeg.assis@gmail.com> wrote:
> Just a quick update incorporating Eric's latest comments.
>
> Still based on
> c443d39 (merge-recursive: find-renames resets threshold, 2016-02-21).
>

One thing I just noticed is that the description of c443d39 still has
a line saying "Add corresponding test.", even though it does not
include any tests. Could you remove that?

Thanks,
=46elipe
