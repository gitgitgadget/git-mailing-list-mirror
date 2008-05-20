From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: Re: git mergetool vs stash apply
Date: Tue, 20 May 2008 16:32:49 +0400
Message-ID: <c6c947f60805200532h53e7ec64jb846f1d8c1b7066c@mail.gmail.com>
References: <c6c947f60805200102h3fd27742vfd9310912907cfa@mail.gmail.com>
	 <20080520090258.GB31703@sigill.intra.peff.net>
	 <c6c947f60805200416s61b0cc1eqd6d6c804abd15b4@mail.gmail.com>
	 <m3prrh42hl.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 14:33:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyR2F-00086N-O0
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 14:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917AbYETMcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 08:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbYETMcu
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 08:32:50 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:42230 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583AbYETMct (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 08:32:49 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2341343waf.23
        for <git@vger.kernel.org>; Tue, 20 May 2008 05:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=H50uEBSzXVlMn2PwQ+5jesTMeLotfkdVTZbFMvpZMbY=;
        b=W008AhHazFzijbZgGexmLNU3i9MJtBcZXJib2PeugNTAiBMZl8SmZD14l8kBd7gw2CmvvVVVKuI4/dKSYizryYC6DWMjZfehLzbiyfQ3NY0JmrlqHMYe3FfF2a2fFzpgZl9gk+7hpp+uKC6Gp5d1T0zqEQFMCjChTAm6VLqSOXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=vCC9wvcqGhX/lh+imBwQdhHnCkIcaTqOsRDOSjzRNcTpDT67yRmfqSPVs5CffFcW1hmZRMLciXjIxhOhFxZyRszRbMhipluUWZ1Ew3xMW4UW9cBgdRdP6k1OUeUvFlsbNQ0JZiM2bN6xwP/+1ukqHuXMRStkIdce9BF0rT9su4s=
Received: by 10.114.76.1 with SMTP id y1mr8810995waa.38.1211286769067;
        Tue, 20 May 2008 05:32:49 -0700 (PDT)
Received: by 10.115.111.4 with HTTP; Tue, 20 May 2008 05:32:49 -0700 (PDT)
In-Reply-To: <m3prrh42hl.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82480>

On Tue, May 20, 2008 at 3:52 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> "Alexander Gladysh" <agladysh@gmail.com> writes:
>
>> On Tue, May 20, 2008 at 1:02 PM, Jeff King <peff@peff.net> wrote:
>>>
>>> So there is perhaps something specific about your setup or your conflict
>>> that is causing mergetool not to work as expected.
>>
>> Most likely so.
>>
>>> Can you give us a test case that fails?
>>
>> No, unfortunately I can not. I was unable to produce a minimal test
>> case, and I can not share the whole repo.
>
> Can you use contents-scrambling tool by Jeff King from
>  Message-ID: <20080510055332.GB11556@sigill.intra.peff.net>
>  http://permalink.gmane.org/gmane.comp.version-control.git/81652

I have some questions:

1. My repo is 650+ MB, my working copy is 350+ KLOC. That size is hard
to share. Would that tool reduce it enough? Is it possible to filter
out irrelevant content somehow?
2. Would that tool obfuscate binaries as well?

Furthermore, I have tried to reproduce that bug once again (by
checking out that problematic revision and trying to apply that git
stash on it) and was unable to (but my repo has changed since that).
Perhaps it was some "moonphase-related" fluctuation...

Sorry for the noise.
Alexander.
