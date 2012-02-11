From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Undo last commit?
Date: Sat, 11 Feb 2012 16:29:43 -0600
Message-ID: <20120211222943.GA2719@burratino>
References: <BANLkTinWujKYvx_fh2iBDOdMbywqzfgwUA@mail.gmail.com>
 <4F36B147.3070501@gmail.com>
 <CAHK-92oMc62O0S8Bxt6+uxobE+kg5wOeRDoOsHWvvenXaXmZGQ@mail.gmail.com>
 <201202112307.10528.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike <xandrani@gmail.com>,
	Neal Kreitzinger <nkreitzinger@gmail.com>,
	Holger Hellmuth <hellmuth@ira.uka.de>,
	Massimo Manca <massimo.manca@micronengineering.it>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 23:30:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwLSh-0001ve-SJ
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 23:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499Ab2BKW3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 17:29:51 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44495 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327Ab2BKW3u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 17:29:50 -0500
Received: by iacb35 with SMTP id b35so2106296iac.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 14:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8LfsLd/bhUOJoiL1fEQgC5XLAsHdtjQuDgCLjE7Xc0E=;
        b=KKlfPty29oswUQqhOTCOAdgCDYjzPr5jelwlI14JUs11z9vidxHCG8s9hfMvC4u1KM
         2AOw5vSovMxGPXyGgwx2wo+9NsBdoz/Ie1ML840XMzsWhm15GSUgVGsRyFL43scpdO8/
         SbD3Biltat+fXHJ5d8f6t9rp0iogZXLAegFbg=
Received: by 10.50.87.136 with SMTP id ay8mr1710152igb.25.1328999390272;
        Sat, 11 Feb 2012 14:29:50 -0800 (PST)
Received: from burratino (adsl-99-35-41-178.dsl.chcgil.sbcglobal.net. [99.35.41.178])
        by mx.google.com with ESMTPS id vr4sm7857002igb.1.2012.02.11.14.29.48
        (version=SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 14:29:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201202112307.10528.jnareb@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190536>

Hi,

Jakub Narebski wrote:

> So, Mike, will you bitch or will you try to help?

I sent a message (not to the git list by accident, sorry) that made
the same mistake, but I think I was misdiagnosing.

I suspect Mike wanted to invite us to take a closer look at the story
in [1] and learn what can be learned from it.  (For example, may be an
error message or some documentation needs to be improved, or maybe new
enhancements like "git checkout -B master HEAD^" would have helped.)

Unfortunately the message [1] is not very focused, making it hard to
learn from.  So my advice to Mike would be to try again, and to
clearly explain what problem he was trying to solve and when git
failed him (either by a command producing a different effect than
expected or the appropriate command to carry out some action being
hard to find).

Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/175968
