From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [1.8.0 RFC] push: start warning upcoming default change for push.default
Date: Mon, 14 Feb 2011 16:41:33 -0500
Message-ID: <AANLkTi=_TVB9cUhLa66_om+c_wptDh+kaJH-idp1=s6O@mail.gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102140036.42197.johan@herland.net> <7vfwrrukzq.fsf@alter.siamese.dyndns.org>
 <201102141018.46527.johan@herland.net> <7vfwrqtrsk.fsf_-_@alter.siamese.dyndns.org>
 <AANLkTincKapKgcWEE1Z+vQesSjZBFAnfH0uL+a7GhQ6b@mail.gmail.com>
 <AANLkTi=Fpey7e+E1eKOiSaS1hjW2d8eOy9PVLR34Sc5J@mail.gmail.com>
 <AANLkTin5ZcZU8iwPSm4A87bYRrSCcXJVLBFGSr2+j30j@mail.gmail.com> <20110214212131.GA23806@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 22:42:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp6BO-0003Je-B6
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 22:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472Ab1BNVmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 16:42:05 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58074 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab1BNVmE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 16:42:04 -0500
Received: by iwn9 with SMTP id 9so5269140iwn.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 13:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=a9BJzUyFFZNl/4LAkWpKbs+fVoN0n7EptuYvOcWK9nE=;
        b=wV/DNFvfCJDTTzSV/OYK5aTXnsgbC6F2sDKDMVIk5mJSNFrB00Z7lE+QLI5vgbFLet
         5V8AMP0T1L72DyA71YQZ6+rZVOKwoIUXFOsUP6CvkRs8QcRyvcr+OF04B5QH1DQDsBiV
         lLnJkTvEB2NHnVK87WVIi7cZA3ANLBgo+tlIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=hXkyfSwSrx5upisdoAv5eap3vQ2wItDI0AiXN1cp/32gWVavCnPNjmDr0YZKTqu149
         V9H6cZWZ52B8qrZswVECLlrYpONK6Xe+n9syKFDiuuhTIpWiqsoWj5Lk119w2YfZKHPK
         F3s17D+QmxoNPKfLurs1W7IUHBJkMqYLo5WDA=
Received: by 10.231.36.69 with SMTP id s5mr3285209ibd.167.1297719723421; Mon,
 14 Feb 2011 13:42:03 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Mon, 14 Feb 2011 13:41:33 -0800 (PST)
In-Reply-To: <20110214212131.GA23806@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166774>

On Mon, Feb 14, 2011 at 4:21 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Which was intentional on my part. If the message says what to set it
>> to, the beginner will just go 'okay' and set it to that, in which
>> case, what is the point of changing the default?
>
> Wait, why isn't that a good thing?

Because 'current' is the more sensible default behavior. If everyone
sets push.default to 'matching' because that's what the message
advises, what's the point of changing the implicit default to
'current'?

j.
