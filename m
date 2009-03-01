From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Changing the defaults for send-email / suppress-cc ?
Date: Sun, 1 Mar 2009 02:01:18 -0500
Message-ID: <76718490902282301v141ce35ajc7e66f984f2f3a39@mail.gmail.com>
References: <7d1d9c250902281129t1ea0d9d0k796d97bdd0af046d@mail.gmail.com>
	 <7vsklycct9.fsf@gitster.siamese.dyndns.org>
	 <20090301153000.6117@nanako3.lavabit.com>
	 <76718490902282259q39da4267r34d169ec200704ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 08:02:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdfhI-0002bf-DO
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 08:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661AbZCAHBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 02:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752780AbZCAHBV
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 02:01:21 -0500
Received: from rv-out-0506.google.com ([209.85.198.229]:57836 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbZCAHBU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 02:01:20 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1805108rvb.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 23:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KfMdisH1Uxp+/78RFzqqqCVRNw6knJh24h4yQsVKO2w=;
        b=InbEBUlmA5el8lX7Iztk+RDWyuXlJ0CVVtz4ZP1+Egku2LXEU7v6K91o+WHrOZB52e
         0ijOo0lwuvrZi9cKCjfwmiY43PP7lWyWkelHHk+b2LJtpARr380mLoRdx0D4PEzw8GGp
         R35WaU7RMpxaQFBgPKmMS4rMqICsF337uAT9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qzcDv+YGEvYjOgE4sKQbjFNUDdvYtDMlFC/84HueAZTTcgaSGoCHZnBuLk81siVLd3
         uZaHVyHUeG+7ilJOOs2vDJ9LZZEMQ2Zy7la7x3hmEyL+FkTuC2+LJQTbf9XE/Crs6yff
         vmsc8J32yZ08Mn5+ytF5MzAj/BuopyUetKEYc=
Received: by 10.141.154.8 with SMTP id g8mr2200590rvo.235.1235890878484; Sat, 
	28 Feb 2009 23:01:18 -0800 (PST)
In-Reply-To: <76718490902282259q39da4267r34d169ec200704ba@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111823>

On Sun, Mar 1, 2009 at 1:59 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> I don't have any illusion that writing my own SMTP client in C is much
> fun, so I was going to see if it was reasonable to link format-patch
> against msmtp. OTOH, I don't want to bloat the git binary, so it may
> just be best to have format-patch be able to run msmtp automagically
> when it is called with "--email".
>
> Or something. I haven't thought real hard about it yet. :-)

OTOH, I like having format-patch spit out the patches so I can give
them a final look-over before sending them. So I dunno if it is worth
this. Perhaps format-patch should be able to invoke an SMTP server
automatically, in the same way that send-email can, but then again,
perhaps not.

Maybe I should stop this late night thinking out loud before I annoy
one too many maintainers. :-)

j.
