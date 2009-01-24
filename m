From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: [PATCH] mergetool merge/skip/abort
Date: Sat, 24 Jan 2009 13:36:32 -0500
Message-ID: <81bfc67a0901241036v6ca30c24q54487e118fd67c1c@mail.gmail.com>
References: <81bfc67a0901210637j52fa7a55q51b599e9ff16f6dc@mail.gmail.com>
	 <20090121170434.GA21727@hashpling.org>
	 <81bfc67a0901220617l22b5a8e4ma48bb069d67cae91@mail.gmail.com>
	 <20090122142258.GA2316@hashpling.org>
	 <81bfc67a0901230716i166bfc4chd9a5c0990b0cd3b6@mail.gmail.com>
	 <7vwscmue5z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Charles Bailey <charles@hashpling.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 19:38:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQnOO-00024f-Os
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 19:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbZAXSgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 13:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754476AbZAXSge
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 13:36:34 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:19606 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870AbZAXSgd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 13:36:33 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2964081fgg.17
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 10:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CJzo2k+mO+PAo3mXDs7bkPf6wYhrRY8p2EOBI9EboXM=;
        b=krTSJl8F8VaJvM6YcabeZmoVP3UGIm3tcpsXeCx09mAhNQdA9UBgBOL7upKbk7dJ0T
         JH9uTkHE8vGNwP5q/19c3pianwBdm89NggFjF9mZoUUp3M1HvPlaNknzFaDeRNiS4X/n
         JC6bTOw0fpmhNeDORuV51fwp0FzaKCOs6PQtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DtQBg6bGY6hAg6CqPjruPn1Yx+WZiFwiJSkNz20HnO3iSOHuu8Z61eVH0S+QrRdWkl
         FdeO4nny5y8fqLHtfvdLb9Fczr9hsI2eiOAjgP3TuAmvXRk0mB4bZ2RHDWC5Dtzo3B5G
         jWND2HYizs8dShIkfLILTUGEIZofy+mplpyeU=
Received: by 10.223.115.12 with SMTP id g12mr2717823faq.92.1232822192181; Sat, 
	24 Jan 2009 10:36:32 -0800 (PST)
In-Reply-To: <7vwscmue5z.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106983>

> I do not use mergetool myself so I generally do not pay attention to
>  patches on this tool, but I would want to pick up ones that people
>  involved in mergetool discussion can agree to be good patches.

yeah I can see that.

>  There are a few mergetool updates in flight from various authors.  How
>  does your submission compare with others' in both form/presentation and
>  clarity of logic (remember, I am not keeping track)?

to be honest, a quick search of the past 2 months of patches didn't
show me any patches that do the same thing as mine, so I'm not sure
that comparing one feature to a different feature is good. I did try
to remain consistent and even improve consistency with existing UI,
and use the same/similar logic to existing.  I'm not keeping track
either, just fixing my own problem.
-- 
Caleb Cushing

http://xenoterracide.blogspot.com
