From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [RFC 0/5] Date Mode: Add --time-zone; deprecate --date=local
Date: Thu, 21 Apr 2011 04:09:52 +0000
Message-ID: <BANLkTikai1zYNrzka8DyGkCUpbJUskfQbQ@mail.gmail.com>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
 <20110420064318.GF28597@sigill.intra.peff.net> <4a235331-951f-481e-8603-896af4e67df9-mfwitten@gmail.com>
 <7v62q8z824.fsf@alter.siamese.dyndns.org> <BANLkTikbgfjq2J3K4_21zVQSTgnteZfMqg@mail.gmail.com>
 <7v1v0wz26y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 06:10:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QClDy-0005Ha-Im
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 06:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130Ab1DUEK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 00:10:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41345 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060Ab1DUEKW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 00:10:22 -0400
Received: by iwn34 with SMTP id 34so1115834iwn.19
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 21:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Rbv34JX1P279N2qaXnhMAk0h8SKcz2x1XIyga9mhZXI=;
        b=ng+JfMkCQUiQeR8UZbrbzdMPqVp9VDSQt0FdYaY+ESRIA84dnTaLFti+g2Ft+bgyK8
         h14QiYEouPjgpX1hpwtMMSLL42tw6CI/n9QyYnWBJJCQ0skbSHfr8cOyxt808IdKXKE8
         6LIWaPAVw+/UR/G5Jz4FKJ7hpIbAbNdfPjE20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=i7ifHJWsbQDBAJvK67Xhj8tsqhnxQXq/s4MBGz+qxHRPFR2Sc4S6dvEmBnx76MXL7Z
         tX0yffXfM4KRqiSjfOlweCsiORJjp4U52mkrNzKYMbHGDGPM/N+8XWC/jmEeNUBqHTZa
         mgqxVAF4FsGn5ID5Vt+c6GrYjTC6IHjWGQFa8=
Received: by 10.42.149.70 with SMTP id u6mr1333835icv.416.1303359022079; Wed,
 20 Apr 2011 21:10:22 -0700 (PDT)
Received: by 10.42.178.196 with HTTP; Wed, 20 Apr 2011 21:09:52 -0700 (PDT)
In-Reply-To: <7v1v0wz26y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171894>

On Thu, Apr 21, 2011 at 03:57, Junio C Hamano <gitster@pobox.com> wrote:

> It is not exactly a good way to win support to dump a patchset, to declare
> that you are beyond the point of rethinking, to say a take-it-or-leave-it,
> nor to defend your private style that goes against the project's coding
> style (style is subjective and there is no right or wrong).

Well, I wanted to respond here with:

    "But I did nothing of the sort!"

However, you stole my thunder:

> I know you know all of the above from your ":-P" (and your past patch
> submissions), but I am writing these down so that people new to the list
> do not get a wrong impression from this exchange.

Firstly, I'm not sure that this exchange has been that bad; perhaps
one of us perceives too little or too much when there is just email
text.

Secondly, don't you think that particular worry is a bit paranoid?
