From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] push.default: Rename 'tracking' to 'upstream'
Date: Wed, 16 Feb 2011 18:08:31 +0000
Message-ID: <AANLkTim9zxsQVMXuuccNH-g=Ueiau=Hp8dJto2Sbw-8U@mail.gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <vpqy65gs6hs.fsf@bauges.imag.fr> <alpine.DEB.2.00.1102160421300.14950@debian>
 <201102161108.26637.jnareb@gmail.com> <vpqhbc4mg1c.fsf@bauges.imag.fr>
 <AANLkTikq67jQnM555nHKeyk5t0Ln+Hp97WSztTaej_CW@mail.gmail.com> <7v8vxflv7p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jakub Narebski <jnareb@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 19:09:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PploW-00079K-Hs
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 19:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091Ab1BPSJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 13:09:13 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:65371 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063Ab1BPSJL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 13:09:11 -0500
Received: by yib18 with SMTP id 18so729432yib.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 10:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=pccKmO8ArUXF0mYM50YPEMzfEMJQqTW98kP1VlFwGMQ=;
        b=NDZOlcm6GAqdhwf1ax88b+PFXk5GSuOWkwNXDfDOTG8IZPDQ/dy8XUUv3Rl2jfc96C
         OpnVl5Klav7jlDkOLoIEDpGVrKdL/RFcktLKVJWHPqhin7Hiiyzy2wbfNeAXzBvh0Pa1
         KJMKVVXfadCyXE7t5hOd3AdA1u75ttJHqWNvs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=sD71sMOd8qkV1dGeKgch95q9YLK8WgSWfKqtcg12UYZtzzeS9zcPGyHjVSBp61u2r2
         8JamxAT0Txh/EYu6oMEcFa0pUunhnqKOT29le4MEN0O2Sc7ziqvG46Dt2F97yCmEKs7e
         D5VbPEOEDFkeydjHg3TC0rl8vSyhXgI/FpA/8=
Received: by 10.151.79.13 with SMTP id g13mr1140318ybl.51.1297879751172; Wed,
 16 Feb 2011 10:09:11 -0800 (PST)
Received: by 10.151.158.19 with HTTP; Wed, 16 Feb 2011 10:08:31 -0800 (PST)
In-Reply-To: <7v8vxflv7p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166982>

Heya,

On Wed, Feb 16, 2011 at 17:56, Junio C Hamano <gitster@pobox.com> wrote:
> That pretty much comes from the days back when 'merge' was the only method
> of integrating with what the other party did.

<snip>

Cool, thanks for the history.

-- 
Cheers,

Sverre Rabbelier
