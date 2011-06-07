From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Tue, 7 Jun 2011 14:11:52 -0500
Message-ID: <20110607191152.GB24929@elie>
References: <201106051311.00951.jnareb@gmail.com>
 <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
 <7vwrgza3i2.fsf@alter.siamese.dyndns.org>
 <4DEC8322.6040200@drmicha.warpmail.net>
 <7vk4cz9i1b.fsf@alter.siamese.dyndns.org>
 <4DECE147.3060808@drmicha.warpmail.net>
 <7vd3ir9btd.fsf@alter.siamese.dyndns.org>
 <4DEDC124.3060302@drmicha.warpmail.net>
 <20110607114526.GA9846@elie>
 <4DEE755C.8030108@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jun 07 21:12:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU1h7-00011j-CO
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 21:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758075Ab1FGTMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 15:12:00 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35094 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055Ab1FGTL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 15:11:59 -0400
Received: by iyb14 with SMTP id 14so4263706iyb.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 12:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=H0CBsQ/HSpZYjyXuJJW68BLVNXW99nKlkxIiz/aaZ3U=;
        b=UvyeWXbokuChxMBCocuFie18uFjaTk0G9KH0T0zUQTg8z7VtBelv7AaHkAO+DzIch4
         nkdyXvHGCsHYoKrSfKvjmY0o/e4E6+CUc5PumGxTQBY9HDa6l3OD0Jt8auxlgCJd0RXm
         rJWucVx49KZSU0eUSmKmebcnWcXQFG2PoSU4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hm6Dxtk+zI/q0QmOHgrdy3gUokNcfqe9golUzPUGFbNHenvRWfyVYMDKRb6fyrwjb4
         rHedh6O+6ch/Owxt+bOu/NCxmIMHJJYWG5YVTpnhwnn0Lz/R8mBC73vJPI4sMI08QSPF
         ff1+AUoF5yhujH8cgVKKMt7Fo7Fs22f+M/bT0=
Received: by 10.231.112.88 with SMTP id v24mr10421434ibp.80.1307473917853;
        Tue, 07 Jun 2011 12:11:57 -0700 (PDT)
Received: from elie (adsl-68-255-98-24.dsl.chcgil.sbcglobal.net [68.255.98.24])
        by mx.google.com with ESMTPS id 10sm2274885ibn.54.2011.06.07.12.11.55
        (version=SSLv3 cipher=OTHER);
        Tue, 07 Jun 2011 12:11:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DEE755C.8030108@ira.uka.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175252>

Holger Hellmuth wrote:

> If someone finds the three-way diff completely mystifiying, how do
> you expect him to resolve a merge conflict at all? Or recognize that
> there is one? Or find the command to use after editing out the
> conflict markers?
>
> A novice user will have no real mental model anyway.

Yes, I think you're getting closer to the point I was trying to make.
A novice will have a naive mental model, and a good user interface
needs to be close to it but not too close.  Close because the UI must
be intuitive on its own.  Not too close because a good UI will help in
leading such a person to productive ways of thinking and working, by
making common tasks convenient.

So much for generalities.
