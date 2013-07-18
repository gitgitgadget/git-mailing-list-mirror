From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git tag output order is incorrect (IMHO)
Date: Thu, 18 Jul 2013 23:14:54 +0700
Message-ID: <CACsJy8DSYPn+ZkyS+Ufs5QPvfQ1OzkWYB--1gWZQackkeFkyyw@mail.gmail.com>
References: <840FACA0-7E13-41DB-A0F8-124FAB53BFBD@rtcamp.com>
 <CACsJy8CpZHTCr0=MkSpfurPW_fyLGN_zd4uSzvBSYbuqH8aXew@mail.gmail.com> <CADtAFQ=DwTHv3n56xoTEN7JmwT+b3Bv0CdR_nBbyYudgoCmZUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Rahul Bansal <rahul.bansal@rtcamp.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 18:15:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzqrZ-00052S-Jn
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 18:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758908Ab3GRQPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 12:15:25 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:52261 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758329Ab3GRQPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 12:15:25 -0400
Received: by mail-oa0-f45.google.com with SMTP id j1so4342671oag.4
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 09:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OoDNhImfAG8Jzln2gdkNn93MI8ndPP+BNl9vu8ATv3o=;
        b=dSoWMyivTZkQvJINet13Wg9HmtO0AO1fKCLiJnrVa7IQoteL4ugZaraD906ADinKj5
         f9Thkr9E1dJS6THM5KJ9LHZD806RyQaI3i17HZuRH2yXsP7BRNNuufV+r7c64whsQac8
         cf+ANAFzK4xIklUznGEiZBOw3vaGH8vD5H/Yqj3wXS4hNm9+lM9dsJv2LccRU1U+LYaf
         EjyBJHjGWQoRinvvp9Fs3LxtWnPJqqSb8ul3ewkmOh/D0+muOTet7Jow7w3148mQE8A3
         w6CgVyp4LHYpncYfQfU+/NpjsThUrIxpPFkq3Ams+sGZRIUBu9WCIXQan7pXU1b37oft
         +6AA==
X-Received: by 10.60.83.116 with SMTP id p20mr13874570oey.83.1374164124587;
 Thu, 18 Jul 2013 09:15:24 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Thu, 18 Jul 2013 09:14:54 -0700 (PDT)
In-Reply-To: <CADtAFQ=DwTHv3n56xoTEN7JmwT+b3Bv0CdR_nBbyYudgoCmZUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230699>

On Thu, Jul 18, 2013 at 10:57 PM, Rahul Bansal <rahul.bansal@rtcamp.com> wrote:
> Hi Day,
>
> I am aware of that command as well.
>
> I think `git tag` current default order is string-based sorting. I
> felt version-number based sorting and/or create-date based sorting
> will be more appropriate.

ok you mean the _default_ order? What about other non-version tags
(even temporary ones just to mark something then removed)?
--
Duy
