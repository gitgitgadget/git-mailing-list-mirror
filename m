From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] contrib: add a pair of credential helpers for Mac OS X's keychain
Date: Mon, 3 Oct 2011 09:16:42 -0400
Message-ID: <CAG+J_DymMLP+c8kAqDOoPSGJG0CicZWzZPAO+D+cyqF5X19YHQ@mail.gmail.com>
References: <1316055113-2353-1-git-send-email-jaysoffian@gmail.com>
	<20110929075627.GB14022@sigill.intra.peff.net>
	<CAEBDL5WhpVg17aPuRqrE5=2Q293kVD4fYtxGqRzx_K=87t-jgw@mail.gmail.com>
	<CAG+J_DyhcA7RmHwgGJBw4r9JRij0_ONp3ZMD6oMTJ_f4dvYW8w@mail.gmail.com>
	<CAEBDL5XhLAccfMoSyBjDA4ZsCgc4FnxEVYyqJsnGfzDW3Otudw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Mon Oct 03 15:16:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAiO6-0006be-IK
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 15:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098Ab1JCNQt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 09:16:49 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41354 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932091Ab1JCNQo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2011 09:16:44 -0400
Received: by gyg10 with SMTP id 10so3369229gyg.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 06:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=SYNMdD3+Gd0O2aAkBl+dnnjQs3N5S2ba9FeFGEi3djA=;
        b=TiWt+Nx86tLtnkuHVpsWVRcCY9OBf2yXS1+mSngyhwA78K3GPXXponvNbzBni9+Jq5
         +qhJUw9l6S/yR48BMV9V+u8aJBkCl9M5CtvSwTZTOE5oU9cBrhE0xln7t6A1KaFHP+Zu
         bVezQKgUcUA3N5yG/AKQuK58YiGM8reZsvxio=
Received: by 10.236.190.200 with SMTP id e48mr85819724yhn.59.1317647803480;
 Mon, 03 Oct 2011 06:16:43 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Mon, 3 Oct 2011 06:16:42 -0700 (PDT)
In-Reply-To: <CAEBDL5XhLAccfMoSyBjDA4ZsCgc4FnxEVYyqJsnGfzDW3Otudw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182662>

On Sat, Oct 1, 2011 at 2:57 AM, John Szakmeister <john@szakmeister.net>=
 wrote:
>>> I don't use GitHub for Mac... does that mean this is busted for me?
>>
>> No. It just means that the credential helper and GitHub for Mac stor=
e
>> their entry in a compatible fashion. (So that each can locate the
>> entry stored by the other.)
>
> Ah, interesting. =C2=A0But it does mean that it won't pick up the pas=
sword
> I've cached via my browser, right?

Correct. I can add code to also make it look for the password entry as
stored by Safari/Chrome. It's actually stored as a slightly different
entry type ("Web form password" vs "Internet password"), so it's not
just the hostname difference.

j.
