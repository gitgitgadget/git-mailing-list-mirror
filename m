From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] push: introduce implicit push
Date: Mon, 15 Apr 2013 12:18:30 -0500
Message-ID: <CAMP44s3J=+U5sM69ZMd3-joG=PHOxyebdvxcCOiqfd4yz2pygA@mail.gmail.com>
References: <CALkWK0=-GcOF17Q-y-Aqj0ThX5pPQFrriDqoJ2qsr=CS+wUNGA@mail.gmail.com>
	<7vehed7ilu.fsf@alter.siamese.dyndns.org>
	<CALkWK0k6bmjFxTSMAutgu2EjWRZ_cyTU9jZ3Er-aaV78T16RtQ@mail.gmail.com>
	<7vppxw335o.fsf@alter.siamese.dyndns.org>
	<516BA732.4080405@viscovery.net>
	<7vzjx01cqn.fsf@alter.siamese.dyndns.org>
	<20130415083558.GB2278@serenity.lan>
	<7vk3o416rq.fsf@alter.siamese.dyndns.org>
	<20130415095920.GE2278@serenity.lan>
	<CAMP44s0u3=FEuifS8KaGy3Y_mjtjeuL1PfChSUco_0TdOXp-jg@mail.gmail.com>
	<20130415171348.GI2278@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Apr 15 19:18:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URn37-00038d-76
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 19:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934326Ab3DORSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 13:18:33 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:47656 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550Ab3DORSc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 13:18:32 -0400
Received: by mail-lb0-f178.google.com with SMTP id q13so4764050lbi.37
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 10:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=AyBjO0Ddpgs8KDTTnly2G9NXCzxrIeAhsHxUJe4JZO0=;
        b=SRC/gMDuFWXj8PGlXOGWyp0J0yC8k/bU/ZRoTAtLCMefYZhCN+uRqegp0XXJq4ly5L
         4DNKdElvJ46KIZ0BMZgVlYTqvbasCoFR0Hu4l4ZL2NPWXzIcG+hAEhDaol4Esma/CC/P
         Ny7svEYP3Ddf/Z86z7DSuQUV6uLg3PnKrxDYbF68SahSUj6JMk55JEeBq/NBFpxF/ctQ
         b0N7uSfSoMAlC4X8WJ1rrAfXWbjOe5EvP3+rhL/lWq342B6dwOu8Os0r3kZXrc8HkVNp
         L2N1RxTki5dMKtdZpBFOt42EiHAFI33nUutuhm0L+KT8/uU5Q07S6GPI/O0wISEhJaaj
         aiIA==
X-Received: by 10.112.131.71 with SMTP id ok7mr8157596lbb.135.1366046310601;
 Mon, 15 Apr 2013 10:18:30 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Mon, 15 Apr 2013 10:18:30 -0700 (PDT)
In-Reply-To: <20130415171348.GI2278@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221258>

On Mon, Apr 15, 2013 at 12:13 PM, John Keeping <john@keeping.me.uk> wrote:
> On Mon, Apr 15, 2013 at 11:39:40AM -0500, Felipe Contreras wrote:
>> On Mon, Apr 15, 2013 at 4:59 AM, John Keeping <john@keeping.me.uk> wrote:
>>
>> > So the question is "what is the natural extension of the current
>> > behaviour?", and the answer for me is "it's completely new", but others
>> > have different (and conflicting) internal models that give different
>> > answers.
>>
>> I don't think this does anybody any service. If the current behavior
>> is wrong, and if users all over the Internet is any indication, it is;
>> we do not want to continue such bad behavior. If the new
>> functionality has a different behavior, it only makes sense to change
>> the old behavior to make it consistent.
>
> The current "push.default = matching" behaviour may be wrong, but I
> haven't seen anyone say that the fundamental "'git push' does something
> depending on push.default" and "'git push there ref...' specifies
> exactly what to do" is broken.

Maybe not, but that doesn't mean that the new behavior should be
limited by the old one. If there's an ideal new behavior, the old one
should eventually be updated to accommodate the new one.

-- 
Felipe Contreras
