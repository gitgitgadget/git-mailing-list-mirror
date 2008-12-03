From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFCv2 1/2] gitweb: add patch view
Date: Wed, 3 Dec 2008 14:14:15 +0100
Message-ID: <cb7bb73a0812030514u11e10bebue5a1451d54fc3f96@mail.gmail.com>
References: <1228298862-28191-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vbpvtecb6.fsf@gitster.siamese.dyndns.org>
	 <cb7bb73a0812030333n2cfdc745m3a910d2e8677e7fe@mail.gmail.com>
	 <200812031400.50980.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 14:15:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7rZm-0004W7-7s
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 14:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbYLCNOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 08:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752473AbYLCNOR
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 08:14:17 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:58495 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbYLCNOR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 08:14:17 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1838491nfc.21
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 05:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8swgcEItUPE9Tg0E+HexQ9gBNkyTd6cVUaI5eIXj8ug=;
        b=S1jIeXUCZzK4xxiCBne1TDdyqw+ElKLwXsC/sychf7wId7OI50m7xnzSLBCgHnub1l
         K4BKhYVRJLj5gNRnC1l+qh1WeebZR5teAm5UcU8pLGBeXc25CWrxFPmgfOdBD7FzV7nU
         PSPoVLD4mWE2FomTyOSd7qmA0HKf7GV0mwmKs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FWjPArSAylXL+EFjiultJRZ1mY7mXq2NU/EwPXMqvD3Nmqaftc6EIPBqQ+wSBM+JJI
         c+b+KD/Od4gTdf0N43nh1aRawsXFc1/MfJYrs4zfCMc0sPrLDSY1eX0qN8PBlFr2O7qn
         RY9+5C7U/41Lfd9jDqul1xerhVPG0B9X2jYHg=
Received: by 10.210.36.8 with SMTP id j8mr15361310ebj.155.1228310055081;
        Wed, 03 Dec 2008 05:14:15 -0800 (PST)
Received: by 10.210.79.12 with HTTP; Wed, 3 Dec 2008 05:14:15 -0800 (PST)
In-Reply-To: <200812031400.50980.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102251>

On Wed, Dec 3, 2008 at 2:00 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Wed, 3 Dec 2008, Giuseppe Bilotta wrote:
>> On Wed, Dec 3, 2008 at 12:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> Perhaps this configuration should also be a feature defined in %feature,
>>> overridable by each repository?  If you default it to "disabled" (as any
>>> new feature typically does), you do not have to yank a random number such
>>> as 100 out of thin air.
>>
>> I thought about it, but then I thought it was way too useful for
>> single patches to disable the feature a priori. I'd rather make the
>> default limit much smaller (like the original 16 commits I had in
>> mind, or even less).
>
> Perhaps %feature can be used to configure _maximum_ number of patches
> in 'patch' / 'format_patch' view (gitweb_get_feature... well, sort of
> as gitweb_check_feature would work too), rather than checking if it
> is enabled or disabled?

The way it's implemented in v2, you just need to set $patch_max in
your local or system config file (e.g. /etc/gitweb.conf). I'm not sure
about the benefit we would gain in going through %feature.

-- 
Giuseppe "Oblomov" Bilotta
