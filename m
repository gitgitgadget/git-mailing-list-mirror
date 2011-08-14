From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/7] revert: Make the argument parser responsible for setup_revisions
Date: Sun, 14 Aug 2011 19:13:19 +0530
Message-ID: <CALkWK0m8u6sVjAQN_cHP1tjR_mkt3Nu=BKEQH+P6e43DRm7iZw@mail.gmail.com>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-6-git-send-email-artagnon@gmail.com> <20110814125223.GE18466@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 15:44:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qsaze-0001Bh-7V
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 15:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309Ab1HNNnl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Aug 2011 09:43:41 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37305 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab1HNNnk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2011 09:43:40 -0400
Received: by wyg24 with SMTP id 24so3021792wyg.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 06:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=5Cuj3HF/hE3EasTZhvbR7zpcKf+Bq3kffgfckNP9WV8=;
        b=Il3pIaY2tyicFD9SNniVv1bQQtAt8qEDMxUlZew91O2K7WRClLFeGPrDP6iSaZziGq
         jH0eOuKEAw5DlxaNRGLfyHdYcVomYireNmCSUCgIIW0ZIRcEcZ8mMw97NVNd4pJOOQBs
         c1/abbu8r37ph9lnCDhCn1Tk41XC7Nxs4eGDs=
Received: by 10.216.37.16 with SMTP id x16mr2475640wea.93.1313329419307; Sun,
 14 Aug 2011 06:43:39 -0700 (PDT)
Received: by 10.216.172.132 with HTTP; Sun, 14 Aug 2011 06:43:19 -0700 (PDT)
In-Reply-To: <20110814125223.GE18466@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179324>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Based-on-patch-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>
> Since I wrote the patch modulo the commit message and small
> improvements, shouldn't I be blamed as the author? =C2=A0(git log
> --grep=3D"[Oo]riginal patch" and git log --grep=3Djc: give some examp=
les.)
> You can have my sign-off if you'd like.

I'd initially blamed you for writing it, but then I was worried that I
didn't have your signoff -- so I quickly changed it before sending it
out.  Will fix in the next round.  Thanks for the clarification and
signoff :)

-- Ram
