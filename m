From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: 'show' pretty %B without a diff
Date: Tue, 21 Dec 2010 12:40:37 -0800 (PST)
Message-ID: <m3zkrykghj.fsf@localhost.localdomain>
References: <20101220073842.GC10354@external.screwed.box>
	<7vmxo0ddbm.fsf@alter.siamese.dyndns.org>
	<20101220111214.GD10354@external.screwed.box>
	<7v4oa8cobn.fsf@alter.siamese.dyndns.org>
	<20101221104641.GA8600@external.screwed.box>
	<m38vzjl1yr.fsf@localhost.localdomain>
	<20101221180459.GA25812@burratino>
	<AANLkTi=BJ0NdKrANuXKObNQJbchqdSUhpnttsdU_NnQe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Peter Vereshagin <peter@vereshagin.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 21 21:40:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV90q-0007o4-1T
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 21:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858Ab0LUUkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 15:40:41 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:36936 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280Ab0LUUkk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 15:40:40 -0500
Received: by fxm18 with SMTP id 18so4816843fxm.2
        for <git@vger.kernel.org>; Tue, 21 Dec 2010 12:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=t9zQHsmAZ/HZVjuDk9TlnsNc5CEJZolXTAha4niJ6wU=;
        b=UoXVZUOlNtL8EluJZtlatDq3fjMiEaasqTPLDkDQDCZ6mMPv4JGUBfapDcO8reZQ95
         0GPomuMh26J48yPfeskAsPp4m48R2D5ZNOtIAN4QOm7Lcx3ruM3J9kacuvnnzvbzJLIJ
         /YHxeJsPYBbPn7fLYfdGKPjm3YEHTK1N5GDeA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=EDh30o607YEkIhIFJWTLNcZ9wJDUQ43+ms9mwRU1Y4HVSV2QF131M4JLHuRTVJrINm
         U7cZSbiuWCVWEH5j94wtlHi8JcgLp/Y7YxnNaYCiaeZ3IHGpx5lMNoVPlWYuJGSEpuxW
         ePoZxmlIIeNadj1V8Irwvg8w9xhdDAN5BEFeA=
Received: by 10.223.89.136 with SMTP id e8mr6543905fam.5.1292964039599;
        Tue, 21 Dec 2010 12:40:39 -0800 (PST)
Received: from localhost.localdomain (abvp39.neoplus.adsl.tpnet.pl [83.8.213.39])
        by mx.google.com with ESMTPS id a25sm1473778fak.44.2010.12.21.12.40.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Dec 2010 12:40:37 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBLKdxPQ022253;
	Tue, 21 Dec 2010 21:40:01 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oBLKdcpS022247;
	Tue, 21 Dec 2010 21:39:38 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTi=BJ0NdKrANuXKObNQJbchqdSUhpnttsdU_NnQe@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164057>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> On Tue, Dec 21, 2010 at 1:04 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> > Maybe it would be worth adding a plumbing example under the EXAMPLES
> > for each porcelain?
> 
> Since porcelain went to C, one thing I often do is checkout really old
> versions of git to see exactly what the shell version of a particular
> command did .

You can always browse 'contrib/examples/' instead.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
