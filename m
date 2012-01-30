From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] git-svn: un-break "git svn rebase" when log.abbrevCommit=true
Date: Mon, 30 Jan 2012 22:18:15 +0100
Message-ID: <CACBZZX5cwZ4Xz3-C8B3v4eEmyO0B-JiohfRATu1UhxzST0ar5w@mail.gmail.com>
References: <1327803073-7000-1-git-send-email-avarab@gmail.com> <CAPBPrntdWAM056C_iZDD1XZy6KZ=5rKvH98Owgc-J8ZbBwrErg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Dan Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 22:18:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrycb-0002j4-I0
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 22:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817Ab2A3VSh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jan 2012 16:18:37 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:54021 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751936Ab2A3VSg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 16:18:36 -0500
Received: by lagu2 with SMTP id u2so2471716lag.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 13:18:35 -0800 (PST)
Received-SPF: pass (google.com: domain of avarab@gmail.com designates 10.112.9.3 as permitted sender) client-ip=10.112.9.3;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of avarab@gmail.com designates 10.112.9.3 as permitted sender) smtp.mail=avarab@gmail.com; dkim=pass header.i=avarab@gmail.com
Received: from mr.google.com ([10.112.9.3])
        by 10.112.9.3 with SMTP id v3mr5951403lba.36.1327958315287 (num_hops = 1);
        Mon, 30 Jan 2012 13:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=8O6eymp+GEYTJsB3sJxTYN8OetxZ0BlLMLQtqOjAqd4=;
        b=JlmouL3OMitSLr5H1recc1ORlv1fIbVOmzWg8LOFRHOaXSQskaZ9fQyVNYsm0JhrKN
         nnid2U/PrgzhPoHAY417b1Kumm0FhXETSeuxiCoRKqHtJuCH6g5oCCkpi7cgaiHv1So2
         R+g+gSkwTLq8atinEFMkRDLngMKtEqR32oARk=
Received: by 10.112.9.3 with SMTP id v3mr4887546lba.36.1327958315212; Mon, 30
 Jan 2012 13:18:35 -0800 (PST)
Received: by 10.112.30.67 with HTTP; Mon, 30 Jan 2012 13:18:15 -0800 (PST)
In-Reply-To: <CAPBPrntdWAM056C_iZDD1XZy6KZ=5rKvH98Owgc-J8ZbBwrErg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189427>

On Mon, Jan 30, 2012 at 21:41, Dan Johnson <computerdruid@gmail.com> wr=
ote:
> On Sat, Jan 28, 2012 at 9:11 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> <avarab@gmail.com> wrote:
>> Change git-svn to parse --no-abbrev-commit --no-decorate to git-log
> Did you mean _pass_ --no-abbrev-commit here?

Yup.

I'l submit another patch fixing this and using rev-list.
