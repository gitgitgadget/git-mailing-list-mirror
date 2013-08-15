From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reproducible, corrupt packfile after fresh git-svn checkout message
Date: Thu, 15 Aug 2013 07:46:55 -0700
Message-ID: <CAPc5daUWd==-cy7qaj6Y3F2KVAH=P2me19LxLuKFC5BCcPbMMg@mail.gmail.com>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de>
 <f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost> <877gfw4byx.fsf@linux-k42r.v.cablecom.net>
 <262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost> <87fvuk2wl0.fsf@linux-k42r.v.cablecom.net>
 <9aa1672d5c04994f416dccd84b5983c960c0fdf9@localhost> <vpqli4cfhhe.fsf@anie.imag.fr>
 <813506281f7a4d3a8af650c5f8ee33dd7224f193@localhost> <vpqfvukfgr5.fsf@anie.imag.fr>
 <edc9f41b4ffca9ce36dc50e749de7a86e4618a0e@localhost> <87fvuk1cyl.fsf@linux-k42r.v.cablecom.net>
 <5203B100.30008@gmail.com> <87txj0i4mc.fsf@inf.ethz.ch> <7vsiyk9j6a.fsf@alter.siamese.dyndns.org>
 <5204E018.4000808@gmail.com> <877gfok59m.fsf@linux-k42r.v.cablecom.net> <520CA02C.1020801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <stefanbeller@googlemail.com>
To: Ben Tebulin <tebulin@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 15 16:47:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9ypd-0007yE-Bu
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 16:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758274Ab3HOOrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 10:47:17 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:40054 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757843Ab3HOOrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 10:47:16 -0400
Received: by mail-la0-f51.google.com with SMTP id es20so635045lab.10
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 07:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=l1dew4OMXSLO8KzaglAvld/0sR/qLVlAwb+KM48uXUw=;
        b=0Y+d80f/cRu3qjdYUzkfgYbIRfhORLYWuSzjb/S7ky9PRHpVlNW7T/H3r8t4GKGsBN
         do2yRJF4C30xvlp6ERCm2On1Ax64bX29zeBGSdx8DqgVCouOaU9EvV0NDQu93+zAC7XE
         ZT36bviUzrbSRrxc+rBR1y5aEd+KDn3GoakeolC3hWaH8rInBbmafJjcN7UroNApfrQ7
         sUky8vrVkwQ86JNow0cIaerw3qdzm8JaACybD/oXbgGRiebbE0zqHTtigQkQ2dMgVhmV
         AQFsxSUBErJcEc6wy/qGnO59BhQllbWxVM7t6VD/O4l1vsDzhS+DDUBBM+rYgDLkFvij
         shTw==
X-Received: by 10.152.120.101 with SMTP id lb5mr12714898lab.29.1376578035469;
 Thu, 15 Aug 2013 07:47:15 -0700 (PDT)
Received: by 10.112.219.200 with HTTP; Thu, 15 Aug 2013 07:46:55 -0700 (PDT)
In-Reply-To: <520CA02C.1020801@gmail.com>
X-Google-Sender-Auth: l97N3FWbwbjH1TmVeRdW3CK1Vv8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232348>

On Thu, Aug 15, 2013 at 2:32 AM, Ben Tebulin <tebulin@googlemail.com> wrote:
> Just as a catchup for everybody being interested:
>
> I finally wrote to the linux-mm newsgroup and Linus pointed out, that
> this might be a known bug yet not fixed in mainline.
>
> Unfortunately this doesn't seem to stand the test; but as far as Git is
> concerned, it appears that that they are willing to take actions.
>
> http://thread.gmane.org/gmane.linux.kernel/1541707/focus=105432

Thanks for following this up.
