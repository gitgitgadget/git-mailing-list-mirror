From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: git rebase --interactive commits order
Date: Sat, 14 May 2011 12:58:26 +0200
Message-ID: <BANLkTinbHOD9AXycM1gXYab+P-PMwOxK6Q@mail.gmail.com>
References: <BANLkTimX2tupqV464+Re8u06TT+qRmqPuw@mail.gmail.com>
 <BANLkTi=PyBfMxCbWNfJEXEP6-MphdeE+_Q@mail.gmail.com> <m2d3jr1mev.fsf@Spindle.sehlabs.com>
 <BANLkTim1e=+yoyxd1AAThVYMZ_X3nfz=7Q@mail.gmail.com> <BANLkTinRcigdQv2GJN6L+nF3X2+F-5Lf5w@mail.gmail.com>
 <7vwrhygmrp.fsf@alter.siamese.dyndns.org> <BANLkTikV_TSEE1cgr=EOhuD0f8KP2vh-tA@mail.gmail.com>
 <7v39klgng7.fsf@alter.siamese.dyndns.org> <20110513175112.GA14079@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Richard Peterson <richard@rcpeterson.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sat May 14 12:59:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLCZi-00039p-Jd
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 12:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756991Ab1ENK7A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 May 2011 06:59:00 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:64054 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756734Ab1ENK65 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2011 06:58:57 -0400
Received: by qyk7 with SMTP id 7so715429qyk.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 03:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=J8hI7zIhBhRNl6qYGh8PavKi2JTvR8lIvaEUvXehzMM=;
        b=U4D4jLNym63MDnVNZNJ2S2bhVfVcwDcwNkHAqQsLEE87+H8aEGw9GSHVNVkvPijDcR
         OVTWB1rwEzn/yOiR3DrtUdR9a+egGinhtmBG1cc9HEsg10R2ikWf9yZvwBFWwOJ01qLV
         rzNKRwR9wNM4uYx1lozk0jBoz3LOtEnCtLmwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FKW5fSVsaao1tr0pmGjc/1XWsVx4J7tMC7jodF6NcJrDRzGBrkPD7Nv2ftO08aLWv8
         ziA0kFFuwdKbCuHDlf304HnX9c847oFw7jqp27B2cgYNBMsf5v8HAg5SCoCOqg20+uxP
         B+HgeiF/p2xwvD9HuMO3kfvw6Qm34UdTIteFQ=
Received: by 10.229.181.142 with SMTP id by14mr1877885qcb.247.1305370736544;
 Sat, 14 May 2011 03:58:56 -0700 (PDT)
Received: by 10.229.234.15 with HTTP; Sat, 14 May 2011 03:58:26 -0700 (PDT)
In-Reply-To: <20110513175112.GA14079@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173579>

> I don't understand. Why not just _display_ the commit in reverse orde=
r?
> Then, from the user POV commands like squash, fixup, etc would apply =
in
> reverse order too (from up to down); keeping the mental model for "ap=
ply
> against ancestor".

Yes, this is what has been suggested. Just display in reverse in the
editor, and on save=A0read the tasks to be done in a reverse manner or
simply reverse the tasks to be done before processing normally.

In fact I can already implement it in my editor by reversing the
commits (vim, some command), doing my stuffs, then reversing it back
before saving. It's pretty error prone because if I forget to reverse
them back then bad things happen, so it'd be nice if rebase handled
this for me.

Philippe
