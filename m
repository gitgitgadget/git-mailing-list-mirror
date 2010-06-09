From: Tor Arntsen <tor@spacetec.no>
Subject: Re: [PATCH v5 00/18] Portability patches for git-1.7.1
Date: Wed, 9 Jun 2010 11:37:18 +0200
Message-ID: <AANLkTilFx4FRa_7L2nSPNcM3RVOAKfPrhTE1tGDMKl7f@mail.gmail.com>
References: <20100514093131.249094000@mlists.thewrittenword.com>
	<20100607154511.GA9718@thor.il.thewrittenword.com>
	<7vy6eqvhrq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Gary V. Vaughan" <git@mlists.thewrittenword.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 11:37:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMHiv-0007rD-Li
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 11:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757171Ab0FIJhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 05:37:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43272 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757141Ab0FIJhU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 05:37:20 -0400
Received: by fxm8 with SMTP id 8so3440203fxm.19
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 02:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=m4NbfuHy4aQMl5NjAPHYr0NjhIA21xZSIjHfOHkRhY0=;
        b=XJMNkFO0KFbYx7vYeQQoAqUg+o2AUKJvXQ0xWqQ/VRxqpHBDNV0oJ8/TeYyvohXDpA
         XQJ3T/MhMnMTU0EgG01oBrAO7Q4LI+14ig36xJf/GG95kpU8qIGM1Bb4+tiDOP89WsoP
         i5zpRJ86bPJ5UvVrqd9AUpGzqk0UT54ukmAEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=EPozfol067UKcb2+Izv0WuN8WJQqjwWvw+32EulhihFT6eoaFb6NHyyNOp20IfRSGK
         XqKYR4R9V18X4+hqJJOD7XvhYZAZtjpdBo80Q75LBduSwGBohYh5eO0UcgmMEl0mytN/
         GSiAV7M46/nW4odFbH8l8Z5ivi9Cf2ugGnCI4=
Received: by 10.239.141.65 with SMTP id b1mr1228041hba.8.1276076238635; Wed, 
	09 Jun 2010 02:37:18 -0700 (PDT)
Received: by 10.239.156.209 with HTTP; Wed, 9 Jun 2010 02:37:18 -0700 (PDT)
In-Reply-To: <7vy6eqvhrq.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: qmK7cwcM6AABc7B_-DozA3Rvuts
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148758>

On Mon, Jun 7, 2010 at 20:07, Junio C Hamano <gitster@pobox.com> wrote:
> "Gary V. Vaughan" <git@mlists.thewrittenword.com> writes:
>
>> Just bumping this thread so that it doesn't fall off the radar.
>>
>> Is there anything I can do to help reviewers or committers accept
>> or reject the patches in this set?
>
> Isn't the series already cooking in 'next'?

Talking about 'next' and this patch set, I have a patch that goes on
top of Gary's patch to the Makefile, to make Tru64 compile also
without ./configure (i.e. just 'make'). Should I post it here as a
diff to 'next', or is it better to wait until the cooking patches are
in mainline and take it from there? (My patch may still need some
discussion and tweaking w.r.t. what's enabled/disabled by default).

-Tor
