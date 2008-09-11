From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 22:05:15 +0200
Message-ID: <200809112205.16928.jnareb@gmail.com>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809111527030.23787@xanadu.home> <20080911194447.GD1451@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Theodore Tso <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Sep 11 22:07:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdsRb-0004Gk-Cj
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 22:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000AbYIKUFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 16:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752971AbYIKUFb
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 16:05:31 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:56278 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbYIKUFa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 16:05:30 -0400
Received: by gxk9 with SMTP id 9so17415686gxk.13
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 13:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ObvE8D7hNDVggNFYJtgpjk4zjLriKsoCWNioy/tT2os=;
        b=BUwLjh/JJXasRVgIpCrDf8jwQ8+A/dWu0D+FINzpjYo+uhmbgk+K3lg0GT4yFSY17P
         m3r2w95aUwg6Eew45FW1Bos+vjhJ9bPzvX1m8kpdjCYJwZa3hFskIwTRQPOpM8tg7OXs
         rKtOy1pTVq7FRLk5SR5kykDMEFSuH4V4SLh+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=k+TzeH7vSuo5/ET7jblrhKtC0CemP2tc72Lf4Nz22bNTuy5z2hJ7h5ZKzI17OFXTXM
         4i4FAE5+9XWkgBGcaPLPiZh5TkyG2EZ8u9nLU6B0N6gVXzS8BO6U59JD2pS4DT0655dm
         lErFaRTD0591TifUbIGWoG6bcYrsZNu1LwlTY=
Received: by 10.86.93.19 with SMTP id q19mr2405209fgb.76.1221163527462;
        Thu, 11 Sep 2008 13:05:27 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.239.193])
        by mx.google.com with ESMTPS id l12sm11591645fgb.6.2008.09.11.13.05.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Sep 2008 13:05:26 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080911194447.GD1451@cuci.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95637>

Stephen R. van den Berg wrote:
> Nicolas Pitre wrote:
>>On Thu, 11 Sep 2008, Stephen R. van den Berg wrote:
>>> Not quite.  Obviously all parents of p and p^ will continue to exist.
>>> I.e. deleting branch B will cause all commits from p till the tip of B
>>> (except p itself) to vanish.  Keeping p implies that the whole chain of
>>> parents below p will continue to exist and be reachable.  That's the way
>>> a git repository works.
> 
>>And that's what I called stupid in my earlier reply to you.  Either you 
>>have proper branches or tags keeping P around, or deleting B brings 
>>everything not reachable through other branches or tags (or reflog) 
>>away too.  Otherwise there is no point making a dangling origin link 
>>valid.
> 
> Well, the principle of least surprise dictates that they should be kept
> by gc as described above, however...
> I can envision an option to gc say "--drop-weak-links" which does
> exactly what you describe.

Well, IIRC the need for this was one of the causes of "death" of 'prior'
header link proposal...

-- 
Jakub Narebski
Poland
