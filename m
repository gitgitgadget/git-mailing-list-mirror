From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Stopping those fat "What's cooking in git.git" threads
Date: Sun, 20 Jul 2008 14:38:04 -0700 (PDT)
Message-ID: <m3sku4w822.fsf@localhost.localdomain>
References: <20080720205125.GP10347@genesis.frugalware.org>
	<7vsku44679.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 23:39:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKgcZ-0001hu-23
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 23:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbYGTViM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 17:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbYGTViM
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 17:38:12 -0400
Received: from ik-out-1112.google.com ([66.249.90.180]:44549 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbYGTViL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 17:38:11 -0400
Received: by ik-out-1112.google.com with SMTP id c28so782904ika.5
        for <git@vger.kernel.org>; Sun, 20 Jul 2008 14:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=DG64o1yMn+GjqgDU2NXkdBiaXp8m2EiZWK00Dv9YZHQ=;
        b=taPvA/rt0jDyG9O3RklH89MGoeQ+xaQWr3d90urZWxuJXIRPrMPxIm/k5hrSms/6DK
         BN3OlDeSgXA38LqzT4Js144AJm2zwO9tGnkwgq0nAlRgb91XOOvPz19dK46Gd+XaiuYA
         kblhBZiL+nzXh0L1Lgzwe/gdeJtscaqtroOf4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=HrQr6oPNs/4RKbWORjJckxV9w8u9zWSV7+XPIU+911v6ehglmeRn4K5hf19otOTFac
         noy81ohaigNlTKDgG1DE1KdYmYT8qyyDbWlPM0zlnpbcZSgIvOSwr8oGhB6Cf5xtq1Ld
         WsAVvauE88ons+pIth+TPBfr4jw0H/5a4l/Z0=
Received: by 10.210.72.14 with SMTP id u14mr2555000eba.113.1216589885033;
        Sun, 20 Jul 2008 14:38:05 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.215.213])
        by mx.google.com with ESMTPS id b36sm6321694ika.5.2008.07.20.14.38.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 20 Jul 2008 14:38:04 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6KLc1ra009572;
	Sun, 20 Jul 2008 23:38:02 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6KLbwxd009569;
	Sun, 20 Jul 2008 23:37:58 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vsku44679.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89238>

Junio C Hamano <gitster@pobox.com> writes:

> Miklos Vajna <vmiklos@frugalware.org> writes:
> 
> > So here is what I thought about: What about if everyone (except Junio,
> > of course) would change the subject _and_ remove the In-Reply-To: header
> > when replying to those mails?
> >
> > If those large threads just annoys a few people and most people are
> > happy with the current situation then sorry for the noise.
> 
> I could make "What's cooking" not a follow-up to the previous issue,

Or perhaps break it from time to time (on major release perhaps?).

> or perhaps add "(volume 1.6.0, issue 28)" at the end of the Subject.

Very good idea.

> But I think it is a good idea to change the subject when responding to one
> part of the message to say which topic your response is about.
> 
> I do not know if stripping "In-reply-to" is a great idea, though.  They
> are responses, aren't they?

The problem with above is if you are replying to many points
simultaneously.

I think however that patches should rather start a new thread.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
