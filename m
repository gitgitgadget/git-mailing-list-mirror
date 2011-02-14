From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [1.8.0 RFC] push: start warning upcoming default change for
 push.default
Date: Mon, 14 Feb 2011 15:55:29 -0600
Message-ID: <20110214215529.GB24030@elie>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102140036.42197.johan@herland.net>
 <7vfwrrukzq.fsf@alter.siamese.dyndns.org>
 <201102141018.46527.johan@herland.net>
 <7vfwrqtrsk.fsf_-_@alter.siamese.dyndns.org>
 <AANLkTincKapKgcWEE1Z+vQesSjZBFAnfH0uL+a7GhQ6b@mail.gmail.com>
 <AANLkTi=Fpey7e+E1eKOiSaS1hjW2d8eOy9PVLR34Sc5J@mail.gmail.com>
 <AANLkTin5ZcZU8iwPSm4A87bYRrSCcXJVLBFGSr2+j30j@mail.gmail.com>
 <20110214212131.GA23806@elie>
 <AANLkTi=_TVB9cUhLa66_om+c_wptDh+kaJH-idp1=s6O@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 22:55:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp6OV-0003sA-1b
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 22:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680Ab1BNVzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 16:55:38 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40355 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079Ab1BNVzg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 16:55:36 -0500
Received: by wwa36 with SMTP id 36so5411792wwa.1
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 13:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=LeVljSbDmdBmZ+SvtiNKL/dJQpWwdhJRxGJPGxU32fE=;
        b=SZpmY3hvZHCz9/FaOYjIDT3cGog2jCVfUq0ejnUrsxxV0SLcxUdwfrw8WxhvnHtEjO
         ZdHmJLeDJLkRVQjGKD5VTuMI9fXBne9drik3RY6eL2RrHz8VDc/0w0KUeFqTo9NpyBam
         l+a9sOIfUdlAyOIYtd8mEDoAX2aTaa5pv5Ids=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Fmx2yz7yHLeLm+Hxs2Fe/njtS7al3PdahIMS8DIzC4lh90XDHuhGIvTSqNGFJKMokW
         hmIgSyJjfqekddQWiD49KIXD72T81o6w3DBSSCgj6bWlD4ZUIAOl3VI6sdGv5VeF87LR
         UaijrvClhY4TxWeHlQF4EmTf2toJtxld/N4UE=
Received: by 10.227.146.213 with SMTP id i21mr3018579wbv.15.1297720535503;
        Mon, 14 Feb 2011 13:55:35 -0800 (PST)
Received: from elie (adsl-69-209-51-217.dsl.chcgil.sbcglobal.net [69.209.51.217])
        by mx.google.com with ESMTPS id r80sm1051907wei.15.2011.02.14.13.55.32
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Feb 2011 13:55:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=_TVB9cUhLa66_om+c_wptDh+kaJH-idp1=s6O@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166779>

Jay Soffian wrote:

> If everyone
> sets push.default to 'matching' because that's what the message
> advises, what's the point of changing the implicit default to
> 'current'?

That new installations after v1.8.0 would use the more sensible behavior?
