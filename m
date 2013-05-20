From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: git-diff-index man page
Date: Mon, 20 May 2013 01:40:00 -0400
Message-ID: <CAPig+cTVjJpD4+s2TqgBR_ZNmnDTTw8OYb1Zpg_EtQ1nxf8eYg@mail.gmail.com>
References: <CAKEGsXQDB1=hizNqM6D=uuP6PXT4ytUiTgB5fvO-gVSsPqQkLQ@mail.gmail.com>
	<7vhahzza2v.fsf@alter.siamese.dyndns.org>
	<CAKEGsXRry_=BuPRPK_syW7_W+_Bh+A1bB9U5YC02=a+Z+SHv1w@mail.gmail.com>
	<7vr4h2w8gv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Albert Netymk <albertnetymk@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 20 07:40:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeIpf-0007MP-LK
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 07:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828Ab3ETFkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 01:40:04 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:60154 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab3ETFkD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 01:40:03 -0400
Received: by mail-la0-f53.google.com with SMTP id ea20so2111641lab.40
        for <git@vger.kernel.org>; Sun, 19 May 2013 22:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=ytpJyd6S8covnaXuuoLhLv/MJI7GvqIkpuoCCM68DTo=;
        b=XfzZ4nPoyGTrWt3Lgv5+5u1co+eFHNJJ4LTqfYswGDdPQ1OP20rhNALNrbUJBghLHa
         cQ67x3oXJcXOTICsmaMvUnA/GuQU5Ic5FbJZXNh6Yt/5CYOWymBZXgOmU/cRSaHJZWO4
         ys1nRZ9nOj2mRB0e28jJY2miKMXPLoV76FxpGXDZ82nent48SrpbSkAy1PfAkEYO/XuM
         r7ziX9hdujZTM1GCy36yynf03DVpZP3b4zJtTlWNhUzkwwDZolWbniCiu9iDbaSnMQRn
         rk/dFltvWIX+6kIaXAMfjv6IT1WNiSUynvvQfwbPanKty6ynlTHVwxgrKeOPTISmUb6v
         PoEA==
X-Received: by 10.112.157.231 with SMTP id wp7mr19284694lbb.91.1369028400980;
 Sun, 19 May 2013 22:40:00 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Sun, 19 May 2013 22:40:00 -0700 (PDT)
In-Reply-To: <7vr4h2w8gv.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: -lPbkUsskA0xjK2Pzq66I_mISaU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224938>

On Mon, May 20, 2013 at 1:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Subject: [PATCH] Documentation/diff-index: mention two modes of operation
>
> "diff-index" can be used to compare a tree with the tracked working
> tree files (when used without the --index option), or with the index
> (when used with the --index option).
>
> The text however did not say anything about the comparision with the

s/comparision/comparison/

> working tree at all.  Fix this.
>
> Reported-by: Albert Netymk <albertnetymk@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
