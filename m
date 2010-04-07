From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v9] Documentation/remote-helpers: Add invocation section
Date: Wed, 7 Apr 2010 23:28:00 +0530
Message-ID: <l2jf3271551004071058sd2828bccr9eb5319715865bc8@mail.gmail.com>
References: <g2vf3271551004062257ycbda64d3z3d3004d802a03fc3@mail.gmail.com> 
	<7vsk77e20r.fsf@alter.siamese.dyndns.org> <n2nf3271551004070950ucf314b40g56087d49dfbd29f1@mail.gmail.com> 
	<7vzl1fch2d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Tapsell <johnflux@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 19:58:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzZWF-00065e-Ot
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 19:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755967Ab0DGR6W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 13:58:22 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:44304 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab0DGR6W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 13:58:22 -0400
Received: by yxe1 with SMTP id 1so299934yxe.33
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 10:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=4QosDlQ35S4G5WlPWuYvKXHOq1UvHbdWoevjdYyYDRo=;
        b=xchbtMocYe42CTo/Sp98fhlLgbQiCKbSSmYLb9ZjvlCLrOIxWRmQ+s+y2BmdeFqWc6
         7mo4+pkuOGt57chmQy+LNupe9J6WRzRbHBkwQI/EyXRV+GtKR3eUsqjzLvtkA+c8OV2n
         jGofhCrTNV0XdPZD/c9piAkMPV4LNhCnEDL/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=pvZYJJbmpzkrgpR4Eaph0YafXw2v9D2KnzRaIfi55A/4ED8MbyUZ1lK/s5Rb9vDO2E
         dSduPpaHqUIMHl7nX2MZJuOoUuyfm5VKOjYuyPTw6QPhuoi3LUNaJCyF+Q8Ab+mcedYS
         0z7sRQYqGn3j3dURf5Uf2fDJPWy/Heb4Hdz8s=
Received: by 10.90.69.14 with HTTP; Wed, 7 Apr 2010 10:58:00 -0700 (PDT)
In-Reply-To: <7vzl1fch2d.fsf@alter.siamese.dyndns.org>
Received: by 10.90.52.12 with SMTP id z12mr119928agz.39.1270663100190; Wed, 07 
	Apr 2010 10:58:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144257>

> =C2=A0- GMail web interface will wrap lines and corrupt patches, no m=
atter what
> =C2=A0 you do;
>
> =C2=A0- With imap-send, you can stuff messages to your outbox at GMai=
l, and
> =C2=A0 using IMAP client that does _not_ corrupt messages, you can se=
nd things
> =C2=A0 out.

Actually the last paragraph about "git imap-send" clearly states that
the web interface _can_ be used. I just used another email client to
find out when lines break and when they don't- I've accordingly
written a patch for Documentation/SubmittingPatches clarifying this.

-- Ram
