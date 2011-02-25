From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v4 24/73] gettextize: git-checkout "Switched to a ..
 branch" message
Date: Fri, 25 Feb 2011 20:47:15 +0100
Message-ID: <AANLkTikGZL--hn-BTPmPK-9oDi0p1h6o7EZ47jeEF0iY@mail.gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
	<1298418152-27789-25-git-send-email-avarab@gmail.com>
	<20110225081048.GH23037@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 20:47:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt3dJ-0004Eg-Bk
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 20:47:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932792Ab1BYTrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 14:47:17 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60903 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932710Ab1BYTrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 14:47:16 -0500
Received: by fxm17 with SMTP id 17so2008625fxm.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 11:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=FEatxSZD0N/+McnQ7bxRFC2hQNRS2QN8C35SHnArVbA=;
        b=FMLQvRROiRNDZd4Kp4IyPXJg/Wgvqx3LP5K/4MJylI87P51WJDD4VA4pzIew6ZQrRs
         936w3BibJtaR58a5dbHZgHCaz8sQdTz9BE+LVZ8sHEBoOFcK2PjNr5cVCqhxP3Ac0Kap
         OVZ4kla/c2iWYEBphsXIAiZtTcavd/ARvcS34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=CecKFR1a37SC6gFZ5eYxz22JNnzmRuEU7CqQHFLFgRd/vy0I0pmYet8hXrzorK0TL9
         KOeY/9uV3xMSaE6ZYIbKwOFoBsWflwrwrQ+ih+k7x3irMxmlVRxZBhyxTIIBjx2UoPyd
         +ye7UxtEPGRNnWCA3sctJ+UXpBDXVxqpmB9i0=
Received: by 10.223.112.81 with SMTP id v17mr2610187fap.102.1298663235339;
 Fri, 25 Feb 2011 11:47:15 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Fri, 25 Feb 2011 11:47:15 -0800 (PST)
In-Reply-To: <20110225081048.GH23037@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167926>

On Fri, Feb 25, 2011 at 09:10, Jonathan Nieder <jrnieder@gmail.com> wrote:

> C grammar is on your side, but the following seems worthwhile for
> the sanity of readers and those who might modify the code in the
> future.

Agreed, and IIRC GCC and others will warn about nested if's without
{}, even if they're unambiguous[1].

1. IIRC GCC will warn about them being "ambiguous", but they're not
   according to the standard. I think some GCC programmer confused
   "ambiguous" and "potentially misleading".
