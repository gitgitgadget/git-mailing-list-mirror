From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2 0/3] Make the Git tests emit TAP format
Date: Tue, 15 Jun 2010 16:49:01 +0000
Message-ID: <AANLkTinBbwuIzUAIP87s5HQ8CxA8SZq57lzb_l4YQ0DW@mail.gmail.com>
References: <1276096943-32671-1-git-send-email-avarab@gmail.com>
	<m3631lp9oe.fsf@localhost.localdomain>
	<AANLkTinHrf_ZuuoMXlL8BFqm3UhRYxrV4t2Nmp5QNjrE@mail.gmail.com>
	<AANLkTimxE0mqmitRzlXjSAO6v7IOEg4guUnRlzJUyIF1@mail.gmail.com>
	<4C17AD93.1020402@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Jun 15 18:49:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOZK2-0008Sa-W7
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 18:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757855Ab0FOQtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 12:49:06 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49341 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab0FOQtD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 12:49:03 -0400
Received: by gye5 with SMTP id 5so3342606gye.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 09:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=7bWhRABG3AJiGvI/o0lsUWL+s8Yjru2AcgvTr25EGQo=;
        b=qSxXQwiz8XJxO5ufuAM5kM7npNBRp/o2sjgjsdz01PX95qmuQg+L+EXMTUzZauXKYY
         WkHJ7d8+W5JCguSu7sk7mmHZDl5gdQCz7EPsIHch7nwJzuPSowJx63YmdMg8fOz4lH7W
         XoBkJHvtvUUsO98LvV2yDB4FNRNCVe+dtYk4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Pm3l6mdvmawiJLKLGYp/MqCP3YWd9VjV9/SEk6TwTwMx0vdBcc6anjewvDwrm9+37i
         3h0zUtyZRzUwlihsV+5IPLzR5mR7cv/+rBVQy61dqF1EFCCUweXOl14gryMLet8FZ6aI
         Bx9N9dLpc8q1+1WP1adrsiLmbBA5s9TWMvTz4=
Received: by 10.150.244.8 with SMTP id r8mr8580144ybh.206.1276620542043; Tue, 
	15 Jun 2010 09:49:02 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Tue, 15 Jun 2010 09:49:01 -0700 (PDT)
In-Reply-To: <4C17AD93.1020402@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149207>

On Tue, Jun 15, 2010 at 16:42, Andreas Ericsson <ae@op5.se> wrote:
> Why are you using a plan at all? I absolutely detest using planned tap
> series, and last I heard was that the majority of TAP-fanatics actually
> agreed that using a plan to run tests was an extraordinarily lousy idea,
> since it makes it harder to add tests properly.

I'm not using a plan before the tests start (although I've considered
adding support for it). But these errors have nothing to do with TAP
plans, they happen because the tests are out of order.
