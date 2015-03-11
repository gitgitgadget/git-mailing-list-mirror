From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Promoting Git developers
Date: Wed, 11 Mar 2015 09:13:40 +0700
Message-ID: <CACsJy8CHmdSRTfspKfSqtg7VXT7D6uxqr49KQQe8dhE5popakg@mail.gmail.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
 <54FDA6B5.8050505@drmicha.warpmail.net> <CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
 <xmqqk2yo22ce.fsf@gitster.dls.corp.google.com> <CAEjxke-6DuTW0-ZyDtUUdCWhEtuw6x3X6LuM_Fj22QztUvFfjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>
To: "Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Wed Mar 11 03:14:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVWA6-0004dq-75
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 03:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbbCKCOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 22:14:12 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:32994 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbbCKCOL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 22:14:11 -0400
Received: by iecvj10 with SMTP id vj10so6103381iec.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 19:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jrZ6KBMTkRXTQG8KZOlCXuC+TmzqSYWG6dIpnaz9j80=;
        b=Hif0V1tmr6tPipEKyFM0IAM6h7qbMqwGhlA3hM/GYWCNi3A7i0tuz/Ae7yOgHVT/md
         33Lr8Yk/JOAKwCXbM94K31DURh9reRtt+OXkzLeJEEO+XIlbnWtTZ8nv4ORrrdbv/3ax
         QqrOPoUIHY9NnsHwbbqtf5FYxiE/8NfU1UZMLfvnZvhJNYlN3jzKRsjzz0FgfYLtsSpk
         ufio/kLjuRdHIum0mYv1G0A2mjYM+f2IgsHaYRM529e2YaL+/SLKzmMZ6NqMu80MECXl
         KInQiZhYzs4VHpEosbqvDZcjYXP+My8lVwS8YhFSmdlWJ36ZC5tJDyKfto8lELF++h9a
         C7hg==
X-Received: by 10.50.222.70 with SMTP id qk6mr87238906igc.47.1426040051120;
 Tue, 10 Mar 2015 19:14:11 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Tue, 10 Mar 2015 19:13:40 -0700 (PDT)
In-Reply-To: <CAEjxke-6DuTW0-ZyDtUUdCWhEtuw6x3X6LuM_Fj22QztUvFfjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265289>

On Wed, Mar 11, 2015 at 8:04 AM, Jason St. John <jstjohn@purdue.edu> wrote:
> Or if that would make the release notes too cumbersome to review, what
> about using systemd's method? systemd's release notes include a
> "contributions from" section at the very end that lists everyone with
> a patch included in the release.

Gnome projects do this too. They also separate translators from other
contributions, but I don't think if we need to do that. I think the
reason behind is translations go through the translator coordinator in
gnome, who does the committing, so "git shortlog" does not really list
translators. We may want to acknowledge review efforts as well, by
grepping Helped-by:, Reviewed-by:...
-- 
Duy
