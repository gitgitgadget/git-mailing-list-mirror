From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 22:22:20 +0530
Message-ID: <CALkWK0mzv8YZS8hctun-k-CnEzWo3TbJwmFX+Z4En8UHjNd5ww@mail.gmail.com>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com> <vpq38us2oov.fsf@grenoble-inp.fr>
 <7vbo9g15po.fsf@alter.siamese.dyndns.org> <vpqbo9gqcvl.fsf@grenoble-inp.fr>
 <CALkWK0nymT=wTnHpTE=uBsqoHxACFb4gStU0SGE79bc7uBVKXQ@mail.gmail.com>
 <vpqbo9foqld.fsf@grenoble-inp.fr> <CALkWK0mLxZCr-QK2tkR9xEsocj6GAM7FZOSeiJ9SnEusfnv88g@mail.gmail.com>
 <vpqmwszlqek.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 15 18:53:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URmeQ-0000hT-GS
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 18:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803Ab3DOQxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 12:53:01 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:58867 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113Ab3DOQxA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 12:53:00 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so6018570ieb.17
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 09:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=60ZjdXRJa46Ft0B2WPw3caFvy5zstUIY9LoPePgPvpQ=;
        b=jieJFy/0/tzhriaVejndQwitfz3brp6HoycNJhAh9mvkjkWWfTPIiWQ084L7shq6J1
         sxZfRYTEZxmPdupUmi4esbx2XbILsBhhsDXLbLgbi5v0ye4AgfI8bFUi6EtLExy00/Dv
         VLAaPkOmP5nIbwOwzHoUTwPM9K30JdLLoDVn4G+77URDR6IAlkyne+WoiNX9xk+7HPay
         OT8t6vMFeCftmOwdMkQQ550rYffck8c05AdKRBaVrpRjEMTccq8PNgNBKhwmCYmr1Vtn
         jLi/ePrxhBJ+P3mC1Mb/5fnZ1mIPto5NbTcdqML6nEUHl87uYBALiE8LnF5+67S7R9ic
         5scg==
X-Received: by 10.50.117.3 with SMTP id ka3mr5391384igb.107.1366044780321;
 Mon, 15 Apr 2013 09:53:00 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 15 Apr 2013 09:52:20 -0700 (PDT)
In-Reply-To: <vpqmwszlqek.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221254>

Matthieu Moy wrote:
> No, they don't.  Git forbids redefining commands with aliases. They may
> have an alias like "git pullauto" or so, but not "git pull".

Ofcourse, but you get the point.  I use p for push, and pu for pull myself.

> There's not much we can do about it now, as Git cannot guess whether a
> stash is to be re-applied later or just kept "in case". My main use of
> "git stash" is "I want a reset --hard, but stash is safer", I wouldn't
> want "status" to remind me when I have a stash because it is almost
> always the case.
>
> Showing the "autostash" status in "git status" would make sense OTOH,
> but I agree that it's another topic.

If the HEAD of the stash contains a stash beginning with the message
"pull.autostash: ", show it in the status.  End of story.

Anyway, no point arguing about this since we've decided not to pursue
pull.autostash anyway.
