From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH] revert: Implement --abort processing
Date: Wed, 1 Jun 2011 11:24:18 -0500
Message-ID: <BANLkTinDvtmU1+xNencddOH-Lj+d+mhasg@mail.gmail.com>
References: <1306944446-11031-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 18:25:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRoED-0007bf-8G
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 18:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758473Ab1FAQZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 12:25:00 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56039 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756820Ab1FAQY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 12:24:58 -0400
Received: by qwk3 with SMTP id 3so2667272qwk.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 09:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=BXVjchDbkVaOAP94EWj/QpXV5RE3IPKSzIBvIL1nMQs=;
        b=Qqhn8ROtfq+GKnMPbTYVst1QjydMdpTt5rPw24XdxaqCP4dyfo11ewjdKmWXguogHU
         q/ffNKlXhyaZb6v9bP/HusZDjgYrE6HmG7gLJIxJ1vZLcVx/4axtXZ3P2uYJu2dicgi3
         sBI7e8abZawcFrr/wfbKRo3VJKqEqCSnHJPK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=hqsXgPm/FfXBjHz+I5YymlojMLxMPOdbdSU0S4tBUEuHmWzYQ9Q7yhREzu3xJHwrwf
         3EK6P/p5zhkSQNfHfiZTCtEdO7sOAGStPqZ1QhF18pqENmVip1FHKogvbtAubRpEUyRi
         lIbbX2U587SULOkPRPF/txO+hmHwBmM1fqSvk=
Received: by 10.229.140.195 with SMTP id j3mr5535237qcu.5.1306945498105; Wed,
 01 Jun 2011 09:24:58 -0700 (PDT)
Received: by 10.229.20.6 with HTTP; Wed, 1 Jun 2011 09:24:18 -0700 (PDT)
In-Reply-To: <1306944446-11031-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174877>

Heya,

On Wed, Jun 1, 2011 at 11:07, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> To abort, perform a "rerere clear" and "reset --hard" to the ref
> specified by the HEAD file introduced earlier in the series.

Isn't this the kind of usecase we added 'git reset --merge' for?

-- 
Cheers,

Sverre Rabbelier
