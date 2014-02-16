From: Patrick Palka <patrick@parcs.ath.cx>
Subject: Re: [PATCH v2] reset: optionally setup worktree and refresh index on --mixed
Date: Sun, 16 Feb 2014 13:19:18 -0500
Message-ID: <CA+C-WL9_WC7TVGJ7yhRM6T6zJ5Q+YGhPODU-vJsu53SOSs2cRg@mail.gmail.com>
References: <1392455661-20665-1-git-send-email-pclouds@gmail.com>
	<1392517683-29518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 16 19:19:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WF6JI-00075E-5P
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 19:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbaBPSTU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Feb 2014 13:19:20 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:35506 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280AbaBPSTT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Feb 2014 13:19:19 -0500
Received: by mail-pd0-f179.google.com with SMTP id fp1so13498181pdb.24
        for <git@vger.kernel.org>; Sun, 16 Feb 2014 10:19:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fCLF2XYeqEUePnzcncd27thmnBY6Z0M0CGNtf9PfqbY=;
        b=ePsD3jHek7091CduhPb11UtoLmzdk4QbTdrC+DAcQc+q1BGqJY6takd3a5TSC8xc7c
         x6W9xFR6EOChJIq3vJNXzQ6Z1lfbK1vH+v02RYP5eWQfoWDTfQwyG6Lol5hGI6rs85qF
         a/WA+pcC5JJr57RIWMFHw4BQKNZu96DnBQhRQ4jibIpB97n6Wr6BXyAnMjzRaozD7x27
         lXKMqNcv9qdNOe2+BNZOyo5faFE/dUXwOzqOVNs+4V0vXFXmknYGLrjy8XnyTDUAnWtN
         ailet8H20qjUwpk9TjX7elpOxacuDfHzhsiIXc2YiYTFSkq5awqP74XYmzIAIz6BGzqX
         3FlQ==
X-Gm-Message-State: ALoCoQn3e+OPWerGtqAH33Lg/mIJvD6H/noqrxbbEChp/Vss1YJYwZXPwgKqUBEpPeC8ixhBDV8U
X-Received: by 10.69.0.10 with SMTP id au10mr22093268pbd.48.1392574759011;
 Sun, 16 Feb 2014 10:19:19 -0800 (PST)
Received: by 10.70.54.162 with HTTP; Sun, 16 Feb 2014 10:19:18 -0800 (PST)
X-Originating-IP: [67.83.169.196]
In-Reply-To: <1392517683-29518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242240>

On Sat, Feb 15, 2014 at 9:28 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Refreshing index requires work tree. So we have to options: always se=
t
> up work tree (and refuse to reset if failing to do so), or make
> refreshing index optional.
>
> As refreshing index is not the main task, it makes more sense to make
> it optional.
>
> Reported-by: Patrick Palka <patrick@parcs.ath.cx>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Thanks!  I can confirm that this change fixes my use case.
