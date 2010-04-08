From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v9] Documentation/remote-helpers: Add invocation section
Date: Thu, 8 Apr 2010 10:24:34 +0530
Message-ID: <x2of3271551004072154r62d10023r32e74064d38aff75@mail.gmail.com>
References: <g2vf3271551004062257ycbda64d3z3d3004d802a03fc3@mail.gmail.com> 
	<7vsk77e20r.fsf@alter.siamese.dyndns.org> <n2nf3271551004070950ucf314b40g56087d49dfbd29f1@mail.gmail.com> 
	<20100407224942.GA20239@progeny.tock> <7vzl1eamss.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 06:55:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzjlc-0001e5-SR
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 06:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571Ab0DHEy4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Apr 2010 00:54:56 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33293 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844Ab0DHEyz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Apr 2010 00:54:55 -0400
Received: by gwb19 with SMTP id 19so986001gwb.19
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 21:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=wz1+llAMIjTejGSM/5UNX1yfAM8R3WiTqNWoMgaGKIo=;
        b=otDNi9U/ALLs6HZYUDvJTctDzK8BWALNlGJ3live/fhs/404Re7ehjbEetHFHtHt3S
         5Mn5na1xIQLZikmmmBRyqT8sXgvwfjnvqIZU1UmM3o1CMObMgWM7d1mrN7LxJUt0o9uS
         U1/zihwh/2JvL/BxONUhoE3nzxL77f1hRkmtc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xYN4Jyq17yuWGwvdPYIySv0N0r6Fjaam+SsfsdEYzirTwKh6EsK5BK574JzJBHZFSL
         64DSQuW7CPHlxp42arvlUc5MGqy+X31in/ww0X2iM9YYNSMsJ4miYw/MsSrXiV3evge5
         sYWARa/Wi+voU6YfDY+YTtOhKrKUGbS/7iMb8=
Received: by 10.90.69.14 with HTTP; Wed, 7 Apr 2010 21:54:34 -0700 (PDT)
In-Reply-To: <7vzl1eamss.fsf@alter.siamese.dyndns.org>
Received: by 10.91.88.13 with SMTP id q13mr3328482agl.99.1270702494104; Wed, 
	07 Apr 2010 21:54:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144313>

Hi,

On Thu, Apr 8, 2010 at 4:19 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Thank you for this. =C2=A0FWIW I find it useful when discussing a pie=
ce of
> code or documentation to bounce back and forth multiple versions of
> small fragments. =C2=A0Then once the discussion has settled down, it =
can be
> useful to see the big picture again, with the new changes
> incorporated.

Got it. In future, I'll post diffs for smaller changes hopefully in
the same email thread, and complete patches for larger changes in a
separate email thread. I've been quite haphazard in the past.

> If you want to make sure the latest version of a patch is always
> available, that is a noble goal, too, but I think a frequently-
> rebased public branch for your patch series is a better way to achiev=
e
> that.

Ah, I already do that, but my branch is based on `pu`. What should I do=
?
http://github.com/artagnon/git

On Thu, Apr 8, 2010 at 4:32 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> At least it would be helpful for me if people based their follow-up
> patches on top of their own topics.

Can I see the topic branch corresponding to my patches? If this is
possible, I can avoid the more painful procedure of extracting it from
the latest pu using git-resurrect.sh.

-- Ram
