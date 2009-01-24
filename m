From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/4] gitweb feed metadata tuneups
Date: Sat, 24 Jan 2009 17:02:36 +0100
Message-ID: <200901241702.38224.jnareb@gmail.com>
References: <1232686121-1800-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 17:03:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQkyu-0001pn-G9
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 17:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbZAXQCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 11:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753259AbZAXQCM
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 11:02:12 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:40759 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740AbZAXQCL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 11:02:11 -0500
Received: by fxm13 with SMTP id 13so1266181fxm.13
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 08:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=VaSxHPpkQPFpphresHYM3y+0Xz4p4q4t+VbEnGLH/Us=;
        b=PYqhrRIbmpykwgF41tTz6hoPSSBkBpktIxdNy4n49pm1HaFGWA4dJPBg2c6jU4BHKc
         S1SSNkIBq1eCe6J48fZXED9fRjk2krOkpNUvhtz3PgbRt8EvxAtLAGXhi5sSPLDTpFLx
         mSkD+cfvrJ0ziyfD8MNaBjZWNWrujhDe7tH7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=cWxKBhAg+QLbeEawstGisvQA8K40vREfCXxxm5YrgZS1UwJ2n+n5f/xKyPJXJoFzVE
         jRnsQqXCnCYYt5B6Cc0kW2RzD3ddkOqWG+rCj5n9hAqxhbfCRXPA0pzXnLc673Bzposm
         beZ7WxfjoQCkC4oeaPYUKBuwqBz+a70tX572E=
Received: by 10.103.121.19 with SMTP id y19mr391216mum.56.1232812929891;
        Sat, 24 Jan 2009 08:02:09 -0800 (PST)
Received: from ?192.168.1.11? (abvk20.neoplus.adsl.tpnet.pl [83.8.208.20])
        by mx.google.com with ESMTPS id w5sm10891139mue.25.2009.01.24.08.02.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jan 2009 08:02:08 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1232686121-1800-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106972>

On Fri, 23 Jan 2009, Giuseppe Bilotta wrote:

> The next four patches add some metadata to gitweb generated feeds:
> channel image, managing editor and last-update dates are added to RSS
> feeds, and the feed generator (gitweb, with version specification) is
> added to both RSS and Atom feeds.
> 
> Giuseppe Bilotta (4):
>   gitweb: channel image in rss feed
>   gitweb: feed generator metadata
>   gitweb: rss feed managingEditor
>   gitweb: rss channel date
> 
>  gitweb/gitweb.perl |   20 +++++++++++++++++++-
>  1 files changed, 19 insertions(+), 1 deletions(-)

I like this series; however I do not use gitweb feeds (Atom or RSS),
so I cannot say anything on their validity and usefullness.

P.S. I tried to look up who is responsible (who have added) RSS code,
but unfortunately it looks like it dates back to Kay Sievers.
Unfortunately because IIRC he is not active on the list...
-- 
Jakub Narebski
Poland
