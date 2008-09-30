From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 2/6] gitweb: use_pathinfo filenames start with /
Date: Tue, 30 Sep 2008 09:48:22 +0200
Message-ID: <cb7bb73a0809300048j7da35623m44ec9bfe7780fedb@mail.gmail.com>
References: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200809290308.09312.jnareb@gmail.com>
	 <cb7bb73a0809290712g324ec015r70fd868b91673645@mail.gmail.com>
	 <200809300120.02492.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@ucw.cz>,
	"Lea Wiemann" <lewiemann@gmail.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 09:50:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkZzp-0003bR-GH
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 09:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227AbYI3Hs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 03:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754868AbYI3Hs0
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 03:48:26 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:51032 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623AbYI3HsX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 03:48:23 -0400
Received: by gxk9 with SMTP id 9so11494221gxk.13
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 00:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=t6YzYnP6kuBwtCBt8GjiLJz3vd/nhH3ybJQmmIOY3+o=;
        b=S92MWUM6kBr1kAg7sA1Bt+EnC7goP3IiUqb3EBd4UcgAdj31z76oy6aJo0ASeH1mBr
         SSscIxuYgDwUPwWio5ES770ke9U35FhV7zF9PimrUkSF2vvpawry1Jrcr0rwG+jq/DaT
         SQgy39oABpaockjApB00Jp8ezQZA8+I3qgnmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=LqHZALaFQbL8jUZyVyVd7DUbFakabrHzojJfN4+OJDIG2AhvQOutf+ovUIio01pORf
         yfu4TbIrjEFQHpHWQEEtqR958Y+QkLnyKfL1Ve8KLpurzYqZzzkmZ8RgQW2/NL2HRnV4
         toFLc4iAMIO8HGHhAr18CEfQbJqNwKkI/F8iQ=
Received: by 10.151.155.9 with SMTP id h9mr9533383ybo.8.1222760902510;
        Tue, 30 Sep 2008 00:48:22 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Tue, 30 Sep 2008 00:48:22 -0700 (PDT)
In-Reply-To: <200809300120.02492.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97073>

On Tue, Sep 30, 2008 at 1:20 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>
> Hn. Now I am not sure if it should be squashed, or should be separate.

Yeah. The fact that it's *specifically* to allow web docs to be used
in raw view makes it count towarda a feature in itself, even if the
patch by itself is trivial ...

So. Squashed or separate? :)

-- 
Giuseppe "Oblomov" Bilotta
