From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb tags feed, Re: New version announcements?
Date: Thu, 24 Jul 2008 08:54:23 -0700 (PDT)
Message-ID: <m3prp3uvn2.fsf@localhost.localdomain>
References: <3B8DB770-5ADC-4B99-9A12-F1DABA20C34D@bunster.org>
	<20080724144939.GI10151@machine.or.cz>
	<Pine.LNX.4.64.0807241600190.7093@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Jordi Bunster <jordi@bunster.org>,
	git@vger.kernel.org, gitster@pobox.com
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Thu Jul 24 17:55:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM3A8-0006zR-R1
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 17:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbYGXPy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 11:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbYGXPy2
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 11:54:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:55771 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbYGXPy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 11:54:27 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1104140nfc.21
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 08:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=MGwRN47U6Xq0B0dagmNSR32hXI10xJPVkViIf8FOck0=;
        b=bDh/4WnfZAoewKiehUa4k9HGxBaQ3NoD0/wJobZrL6OiLZIfYJVWsIpPVsXXeWhQu2
         GqEWDw3c7J9sH94hzuKXdynfXXPbW2nWawoPqejBsqiLSOqh5dmsYZqtjuggsmva60JE
         wt6ihaC1FagltoeqUdfsmKnxB92VvCcZOj0u8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Swl2Y9sZYSNPjE+Hdy1RRJb2x98G5uFqLijddW2y9r0y5BFsU8HjuljxivUiHZAJZ8
         RaaWBfQoeYZmebduOaPegUC6THrJEPDiFd1qOxHMs5LOIHobGc4P2lFDXAQR3CXKxQTu
         2P22mKTn4ZCwq+oyZillSyh8pHF3WzEhErS0I=
Received: by 10.210.39.20 with SMTP id m20mr519418ebm.126.1216914864723;
        Thu, 24 Jul 2008 08:54:24 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.208.47])
        by mx.google.com with ESMTPS id z34sm13515276ikz.9.2008.07.24.08.54.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jul 2008 08:54:23 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6OFrNcf005564;
	Thu, 24 Jul 2008 17:53:34 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6OFqoQC005559;
	Thu, 24 Jul 2008 17:52:50 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <Pine.LNX.4.64.0807241600190.7093@reaper.quantumfyre.co.uk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89898>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> On Thu, 24 Jul 2008, Petr Baudis wrote:
>> On Thu, Jul 24, 2008 at 10:38:24AM -0400, Jordi Bunster wrote:
>>>
>>> I've been following the git mailing list to stay on top of new releases,
>>> but the traffic got too high.
>>>
>>> Any way that a git-announce list could be created for security fixes and
>>> new releases? Or maybe an RSS feed on the website?
> 
> An RSS feed already exists, have a look at http://gitrss.q42.co.uk/.
> 
>>> If there's a news file or some-such, I'd be glad to write the code to
>>> convert it to a subscription feed.
 
> There was a request for RSS feeds some time ago, and I setup the above
> feeds which automatically process the git mailing list traffic -
> haven't bothered to actually monitor if anyone is using them though ;)

If I didn't thank you for this web service (http://gitrss.q42.co.uk/)
thanks, if I did thank yoy, thanks again :-)

I have used this service (to be more exact one of feeds offered by
this service, which basically is very filtered git mailing list feed)
as a source of "News" section for Git project at Ohloh[1]:
  http://www.ohloh.net/projects/git


[1] http://www.ohloh.net/projects/git/rss_subscriptions uses
    http://gitrss.q42.co.uk/announce.rss)
-- 
Jakub Narebski
Poland
ShadeHawk on #git
