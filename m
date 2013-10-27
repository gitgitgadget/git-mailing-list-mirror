From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 11/10] fixup! transport-helper: add support to delete branches
Date: Sun, 27 Oct 2013 00:00:17 -0500
Message-ID: <CAMP44s0RTahHMc4_zyf6U7-XKQm89fnP4owSHUSfqR0-8jti0Q@mail.gmail.com>
References: <1381561533-20381-6-git-send-email-felipe.contreras@gmail.com>
	<1382848452-7953-1-git-send-email-rhansen@bbn.com>
	<CAMP44s142HB2t7wL8KYTyD4M=e7X5hvG1KeOBhJHwSEjegYM9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Sun Oct 27 06:00:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaISd-0005ev-4A
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 06:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195Ab3J0FAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 01:00:19 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:41298 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039Ab3J0FAS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 01:00:18 -0400
Received: by mail-lb0-f179.google.com with SMTP id w6so1871091lbh.38
        for <git@vger.kernel.org>; Sat, 26 Oct 2013 22:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vGAZ/dxO/w07TGWvgunvQdUdP3JeIgB2vGjtSkeEgno=;
        b=Bc00UoiLSRPI0ZgotCQAA+fLbl5hLpzcu6AyMNZYE5T03tgmZTCKaE/C9qBgnNWjH5
         a6ELQL3tdQHeAK/bB0vV44tTnVocuKkgH7DyaoiJGcbW91t1rmpegfy4zOlU6CND6F7L
         4fs1t1JOVIN86Zg4zxuFsQ+5xUOWIhquv0aAI40vHZC+opZcMdGHYNI1e8LPQUs9Zvbu
         hfGE0mjrmw2w3R3+IWWRj0FGeQoI6Huy0u8D+Wiew9L4nkP07hFVT/A1qQjnU+Xw39P0
         GpdO0p8Dh/FigqIDSar8nsXzVzG4du2nzNVgQYvS6Z3gGyt61jzah/Z1htNdPNc56XH1
         pLhw==
X-Received: by 10.112.132.70 with SMTP id os6mr1485553lbb.38.1382850017092;
 Sat, 26 Oct 2013 22:00:17 -0700 (PDT)
Received: by 10.114.201.69 with HTTP; Sat, 26 Oct 2013 22:00:17 -0700 (PDT)
In-Reply-To: <CAMP44s142HB2t7wL8KYTyD4M=e7X5hvG1KeOBhJHwSEjegYM9Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236774>

On Sat, Oct 26, 2013 at 11:55 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Oct 26, 2013 at 11:34 PM, Richard Hansen <rhansen@bbn.com> wrote:
>> Patch 2/10 (transport-helper: fix extra lines) deleted one copy of the
>> lines; patch 9/10 (transport-helper: add support to delete branches)
>> should delete the other copy of the lines.
>
> Looks awfully familiar to:
>
> http://article.gmane.org/gmane.comp.version-control.git/235973
>
> But since the project does have double standards, you might have
> better luck by simply not using my name.

Ahh, nevermind, it's a fix on top of my patch. I actually found this
and fixed it on my local branch, but didn't push it. Now I have.

https://github.com/felipec/git/commit/4820caafc1f0b9e346b369bb2bc2b7bfdc8a1957

-- 
Felipe Contreras
