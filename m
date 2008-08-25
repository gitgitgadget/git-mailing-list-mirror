From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC v2] Git User's Survey 2008
Date: Mon, 25 Aug 2008 03:56:58 +0200
Message-ID: <200808250356.59611.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <200808250241.40407.jnareb@gmail.com> <20080825012653.GB28160@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 03:58:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXRLR-0005Ab-Qc
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 03:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbYHYB5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 21:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753422AbYHYB5J
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 21:57:09 -0400
Received: from ik-out-1112.google.com ([66.249.90.176]:38039 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbYHYB5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 21:57:07 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1184304ika.5
        for <git@vger.kernel.org>; Sun, 24 Aug 2008 18:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=l1VRIWeze9ACJnh4jE07NykJ2suzp0at5t+ZusNomOI=;
        b=I757MzoLrqLUa08iBeF8GQi+Qp4LoFA+TCw/+4mtNEqcHwSwaW+v3U2a+jgyZRfouG
         M7ArcLoPcLDF/s30azeUYOwx+jmsXM4VPtAWKrjtFeGJ52+12f3anOkAHMFOAZh4jtNm
         Jz+1j31R31I/CDGHkPM+9B7DRcmAB8d2Zappg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KUH4aVpP4B2WtDvyVyxsSdjhHZ0Ho4nkwMlJ9Os58RKsHSqKyMjwn6zuN4njKx+2go
         c9eX1dlJHK6A5O3hB6Ka7b12g1igGJf8VTumukjyXnt/+Zv0TbrrR8Oe8n5QupgxQr5k
         tVzNWUPC8ribQz8qPTry+LjT1meUfpHL035tk=
Received: by 10.210.11.13 with SMTP id 13mr5803364ebk.142.1219629425319;
        Sun, 24 Aug 2008 18:57:05 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.234.185])
        by mx.google.com with ESMTPS id c24sm3726398ika.4.2008.08.24.18.57.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Aug 2008 18:57:04 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080825012653.GB28160@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93584>

On Mon, 25 Aug 2008, Stephan Beyer wrote:
> Jakub Narebski wrote:
>> Stephan Beyer wrote:

>>> I btw do not like the last fact, but since most users nowadays have
>>> JavaScript activated, it may not be that bad.
>> 
>> F**k. I didn't notice this soon enough, and now I'd rather not re-enter
>> all 60 questions. I have sent feedback that requiring JavaScript to be
>> able to submit survey is strange.
> 
> Yes, a simple "old-school" <noscript>survey</noscript> would be nice for
> some users. I did not notice that, too. Can you write or have you
> written feedback on that topic to the survs people?

I have send feedback.

The problem is not that _filling_ survey requires JavaScript, because
it doesn't.  The problem is that submit _link_ uses JavaScript link
javascript:finishSurvey() instead of having submit _button_, which
would use 'submit URL' (and optionally have onSubmit event to check
response).

-- 
Jakub Narebski
Poland
