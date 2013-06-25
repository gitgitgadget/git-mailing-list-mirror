From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 13/14] t/t5515-fetch-merge-logic: don't use {branches,remotes}-file
Date: Tue, 25 Jun 2013 15:50:30 +0530
Message-ID: <CALkWK0kdWe+rj1gLX2QX6Ra3BjbQrr6muCHKN1c1a+8W3hpdfQ@mail.gmail.com>
References: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
 <1371887901-5659-14-git-send-email-artagnon@gmail.com> <CA+gHt1B1pKz5iU+9m_gi36u7g91qZqgdkY97WDAWjRGxu-Vjuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: =?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Jun 25 12:21:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrQNA-0000S8-F1
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 12:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812Ab3FYKVM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Jun 2013 06:21:12 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34999 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134Ab3FYKVL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jun 2013 06:21:11 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so27096574ief.40
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 03:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=CSnPan8+TKHTBLGUmZKH9u3MnMu0sAgVjsxnnDYNa8E=;
        b=y7rPc8q3+XFw2P4yRO7y3bcQqeSnnKXUBPfirzYXZsoILduhJi59o3Zk3nlofwRo1I
         3xNUL0lIOsDjICOheOBkhtUwMFdX4Cv5vR/a0a9wur3UG/0NR8LsBUF0GNUF9jfCNU2V
         sbHlB9L/+IannymkSzixkpwSdF5sQXIoYWnPLUr8kRVI+D0fV3OVwqTcwY5wsoBkau1O
         o3CB/S2EeZuF5zcy3FuppWhO8rxyXiwxMhnL4Ae7lFNZ6GRiD7iX5HPtQ4qx9mwt2KBX
         5o5Xf1yyywuFVZV9LVF/ha95iUNzkrfGlEet9wujfMaQdGxidhdJTSVfzNPI0FoLPKfz
         UbUQ==
X-Received: by 10.50.66.130 with SMTP id f2mr7988410igt.55.1372155670718; Tue,
 25 Jun 2013 03:21:10 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 25 Jun 2013 03:20:30 -0700 (PDT)
In-Reply-To: <CA+gHt1B1pKz5iU+9m_gi36u7g91qZqgdkY97WDAWjRGxu-Vjuw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228954>

Santi B=C3=A9jar wrote:
> If you think it's not worth testing the merge logic with remotes in
> {branches,remotes}-files you can consider just removing these remotes=
 and
> the associated result files.

Thanks, but Junio has already decided to keep them and dropped these pa=
tches.
