From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 07/15] t1510 (worktree): fix && chaining
Date: Thu, 8 Dec 2011 10:09:08 +0530
Message-ID: <CALkWK0mQjJ_JeqK0h3cy++CKKdTzzsyOui9jO-kCriL0mUsCuQ@mail.gmail.com>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com> <1323286611-4806-8-git-send-email-artagnon@gmail.com>
 <20111207215100.GB2911@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 05:39:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYVlf-0003DB-Pv
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 05:39:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287Ab1LHEja convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 23:39:30 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:39207 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033Ab1LHEja convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2011 23:39:30 -0500
Received: by qcqz2 with SMTP id z2so1021546qcq.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 20:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Xpn5hIoGvoR6r5dVMmlcyuwz6JLLUR2GtlaTETIjo0g=;
        b=xrTrZaB2D+Y3qVghYiG5TtKgN+/eOsAQfCs/DBvjoD8yeJbHUyw3IX08+QxOpO7y1U
         94uHDcKAGBaQ6bYzetEA8JDjgMlk/aE2t8DTqOYZgy3ZwDwWu+SW8MiltectYLOqbDV2
         9VXcfr740r4kVs1+U7dmLv1k4a9N1JX2aX8oA=
Received: by 10.229.227.84 with SMTP id iz20mr403160qcb.164.1323319169251;
 Wed, 07 Dec 2011 20:39:29 -0800 (PST)
Received: by 10.229.165.194 with HTTP; Wed, 7 Dec 2011 20:39:08 -0800 (PST)
In-Reply-To: <20111207215100.GB2911@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186530>

Hi Jonathan,

Jonathan Nieder wrote:
> [...]
> On some shells, like /usr/xpg4/bin/sh on Solaris, unset returns nonze=
ro
> status when the variable passed was already unset. =C2=A0Will this wo=
rk on
> such platforms, or does it need to be changed to use sane_unset?

Interesting.  Thanks for catching this.

-- Ram
