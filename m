From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v3 00/11] unify appending of sob
Date: Thu, 31 Jan 2013 10:45:07 -0800
Message-ID: <CA+sFfMe4NYWKQBM0N0isBfF+RY2AemKugKT+RyA98boO-p1rYQ@mail.gmail.com>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
	<20130128034831.GQ8206@elie.Belkin>
	<7v7gmxzwkj.fsf@alter.siamese.dyndns.org>
	<7vhalylggd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 19:45:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0z8t-0003VB-DS
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 19:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756799Ab3AaSpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 13:45:13 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57687 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756433Ab3AaSpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 13:45:09 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr12so2227692wgb.11
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 10:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=LRp4DVANWO3WdJtc1e6PPohTNSJH+nYmxMb/Ax6XFyo=;
        b=cppF+Khbrsy2VMSk21C/0cQpHNjUNwWkpjtl3LetwD3GRv6DggwQgeZgsOgAS6JPQb
         ctKFr3uNx1BZrvgMtKop2/m3MMaA3SSER33eD1BnBvTZI7FsOK7m+4wyQcPYLUW4C0QL
         o8lCO6rXJhljUGYGZPX8eiWwB0IeVyaoHMEu3bX57zaerr/s4eoyr2dNrwMxWj2ot3bk
         n3G97j+052elQRHpeSULkjSuBFKqYLDCT4NMaAXcvEpK/7HUT//uxgY0qTNoFyF2oR8U
         dSiw37O96BUTeG4p6TtqLmpXjemOj9YYWm/biRaA8WWRdYG1Dsppt/lo1SVPj+fyKM2D
         /2PA==
X-Received: by 10.180.93.133 with SMTP id cu5mr16916710wib.32.1359657907926;
 Thu, 31 Jan 2013 10:45:07 -0800 (PST)
Received: by 10.194.78.170 with HTTP; Thu, 31 Jan 2013 10:45:07 -0800 (PST)
In-Reply-To: <7vhalylggd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215148>

On Wed, Jan 30, 2013 at 9:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>>> Brandon Casey wrote:
>>>
>>>> Round 3.
>>>
>>> Thanks for a pleasant read.  My only remaining observations are
>>> cosmetic, except for a portability question in Duy's test script, a
>>> small behavior change when the commit message ends with an
>>> RFC2822-style header with no trailing newline and the possibility of
>>> tightening the pattern in sequencer.c to match the strictness of
>>> format-patch (which could easily wait for a later patch).
>>
>> Thanks for a quick review.  I agree that this series is getting very
>> close with your help.
>
> Unless Brandon and/or Jonathan wants to have another chance to
> excise warts from the recorded history by rerolling the entire
> series one more time, I think what we have queued is in a good
> enough shape to merge to 'next' and any further improvement and fix
> can be done incrementally.
>
> OK?  Or "stop, I want to reroll"?
>
> I'll wait for a day or two.

Let's hold off so I can do another round.  I worked on this last night
and was able to simplify some things nicely.  I'll try to finish up
tonight and resubmit.

-Brandon
