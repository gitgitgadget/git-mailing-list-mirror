From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/5] gitweb: Some code cleanups (up to perlcritic --stern)
Date: Mon, 11 May 2009 09:19:59 +0200
Message-ID: <200905110920.01231.jnareb@gmail.com>
References: <200905100203.51744.jnareb@gmail.com> <200905110333.52127.jnareb@gmail.com> <7viqk8s20j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 09:20:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Plm-0006sE-MI
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 09:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbZEKHQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 03:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbZEKHQJ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 03:16:09 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:31751 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbZEKHQI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 03:16:08 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1573985ywb.1
        for <git@vger.kernel.org>; Mon, 11 May 2009 00:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=OYjIO31AQEX/c7nrZfNWinqjWl1Uu63Uwp4qZOdFV1Y=;
        b=jan/HkprZceUQ4CJsqI4Zb04iFJqvXnq0iNPnV6Ct7r+ZvkzWShx/nROdByhLYx2W/
         0sihR7PWzULQhBOcSoWuUGdSXoztiph/Vu/FhkFhidSh4RKmp3kqei0EvzMnfFzEVkYs
         ArCAWMoR5ki9uCDWybGzJsAiG0EcqB4O8Xjcg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=u731kOxIz+6ujCKv6PftasK46pMMaIXDsK0t2jgvIM9iY7WAOko3EPL5EKEuCbuQjH
         h6nCkVwPx0eWyH6HBwZ5Yz8Y4Op5u9LfUcb7HwPvwOG5UE0MMRWplcsvf+0g8IJlvpBt
         pON6CHgUs1anjDuZmHKrdPl/SYCLnv/g5Ad40=
Received: by 10.100.46.12 with SMTP id t12mr3169476ant.55.1242026169015;
        Mon, 11 May 2009 00:16:09 -0700 (PDT)
Received: from ?192.168.1.13? (absh130.neoplus.adsl.tpnet.pl [83.8.127.130])
        by mx.google.com with ESMTPS id b32sm11370005ana.20.2009.05.11.00.16.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 May 2009 00:16:07 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7viqk8s20j.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118775>

On Mon, 11 May 2009, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes: 
>> On Mon, 11 May 2009, Junio C Hamano wrote:
>>
>>> But this series, when queued to 'pu', seems to break t9500; I haven't
>>> looked at the breakage myself yet.
>>
>> I'm sorry about that. My bad. The fix is in the email (unless you
>> prefer for me to just resend the series)...
> 
> That's Ok.  I had them near the tip of 'pu', and I can just replace them.
> 
> But this episode does not give much confidence in Perl::Critic does it?
> The runtime "use strict" diagnosed undeclared globals in the cleaned up
> code, but presumably the Critic did not complain anything about it, right?

Well, IIRC it didn't complain because I didn't run Perl::Critic (or to
be more exact http://perlcritic.com) on cleaned up code... But I guess
that Perl::Critic might not try to catch them because 'use strict'
catches them.

P.S. Of course Perl::Critic is not perfect. Most funny quirk was it
complaining in --harsh (severity 3) mode 
  Main code has high complexity score (54) at line 1, column 1.
  Consider refactoring.  Severity: 3
about "#!/usr/bin/perl" line!

-- 
Jakub Narebski
Poland
