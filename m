From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 00/28] Support multiple checkouts
Date: Sun, 9 Mar 2014 04:18:42 -0400
Message-ID: <CAPig+cSQUFtT+eoNG8JYEqJq=yKU+xou7WNJNcJ2DPU5wBLy-w@mail.gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
	<1394246900-31535-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 09:18:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMYwb-0008Nr-AI
	for gcvg-git-2@plane.gmane.org; Sun, 09 Mar 2014 09:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbaCIISp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Mar 2014 04:18:45 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:33033 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbaCIISn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Mar 2014 04:18:43 -0400
Received: by mail-yk0-f178.google.com with SMTP id 79so15802561ykr.9
        for <git@vger.kernel.org>; Sun, 09 Mar 2014 00:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Sy7zdqSlAdiy/1FKL50p3mLuw2slGuNysTGxi/UbZjc=;
        b=CEBzDMjivXFyS2b048seX18+jwU+GDeKsWNbRWIDwYE6NzsP1OC5mu90TpqhwKSG6E
         EcO6hG9IJq9gOeURHHf1UrmL8+pfjxft9aTb98Ol39kWl/D4Lwu+9DXUHtIkRWMhcRDH
         TSsaTJimHJw0SFXXcW5IVBtLrCUrZi3NAUEB5igBixsdTl/0RCV/GZtbFSGy9X9v5+S9
         1ZHj7AI7UPDT1m2MiKdFDI3zAbmZdlQiV7QrVldyPmkoFTiIa9a6G4R86bmEbThiGI8X
         HLNNeGLyARgZXXJjeXsPFmK2c4TaMLJUtEUJa4ue6eQ81GamrUVaufRv0SunyGmHtYER
         V2dg==
X-Received: by 10.236.94.243 with SMTP id n79mr35652385yhf.46.1394353122528;
 Sun, 09 Mar 2014 00:18:42 -0800 (PST)
Received: by 10.170.180.134 with HTTP; Sun, 9 Mar 2014 00:18:42 -0800 (PST)
In-Reply-To: <1394246900-31535-1-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: hjOW3vZbQ2D3I5gkn0pz5egMhBw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243691>

On Fri, Mar 7, 2014 at 9:47 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> The diff against v4 is kinda big but it's mostly about converting
> `...` to $(...) and making git_path() and friends return a const
> string.
>
> Another notable change is I no longer attempt to support checkouts on
> portable devices. Torsten pointed out (privately) that my dealing wit=
h
> Windows drives was insufficient. And Junio was not so happy with how
> link() was handled either. We can revisit it later.
>
> Many thanks to Eric, who was very patient to go through the series
> carefully and pointed out problems that I overlooked.
>
> v4..v5 diff below for convenience

Thanks for providing an interdiff between the two versions. It
simplified things considerably, especially with the v4 reviews still
relatively fresh in my brain.
