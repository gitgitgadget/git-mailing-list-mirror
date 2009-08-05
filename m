From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: The XZ patch?
Date: Wed, 05 Aug 2009 04:12:53 -0700 (PDT)
Message-ID: <m3zlaepl8v.fsf@localhost.localdomain>
References: <5F7EF736-9D0B-4455-A0F7-E7314B4F29E4@uwaterloo.ca>
	<4A795790.9010805@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark A Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Aug 05 13:13:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYeQZ-0000tK-Gp
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 13:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbZHELM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 07:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934147AbZHELM4
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 07:12:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:51966 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbZHELMz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 07:12:55 -0400
Received: by fg-out-1718.google.com with SMTP id e12so851118fga.17
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 04:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=EWHHEsPYImNmvaZi3e/EEHXaiSyLt2TRoaE0uGypAzE=;
        b=RY83K2m+d9z/E4hmnIRx9QtHBl4v7ADjAw2zDvK33ehbcveOrLA0fa2mAh0WUxfNh+
         Y/0eJsTz4FE8z8kWdoXHL5SumC03twWwm5Cuy/ib0v9O/n+ZKNCaQ7/u7sO2A98M1jU3
         F5Pk0pUzHRzGmsCRuU+Kq9Gg61lplXranhx0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=YIFu89Gte8VZsXO2ReVTn7GuoHnaVX1fgVMmpJPbZMMKxeoGAkW6uH0NmI8kNGjg9w
         FRUz3ehdBBkBVljaua3ccQDWQl7FeBmVjeb6hs4thkHP0w8xhS7Weicu1jhLiY/O77fZ
         O4YVCwzzDjV6++q4xDQRK0WPPbRf7wooIf1Qs=
Received: by 10.86.81.16 with SMTP id e16mr1833605fgb.78.1249470774751;
        Wed, 05 Aug 2009 04:12:54 -0700 (PDT)
Received: from localhost.localdomain (abvs73.neoplus.adsl.tpnet.pl [83.8.216.73])
        by mx.google.com with ESMTPS id l19sm8303724fgb.22.2009.08.05.04.12.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Aug 2009 04:12:53 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n75BCpec014778;
	Wed, 5 Aug 2009 13:12:51 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n75BCmOm014775;
	Wed, 5 Aug 2009 13:12:48 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4A795790.9010805@op5.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124897>

Andreas Ericsson <ae@op5.se> writes:

> Mark A Rada wrote:
> >
> > I was wondering what the fate of my XZ patch was (I didn't do
> > something dumb, did I?). Never got a response after my last
> > submit.

I'm sorry, I didn't reply to the last version, did I? I liked both
patches
 
> No comments usually meant noone cared enough about the implemented
> feature to comment on it. Personally, I'd never use a compression
> algorithm that hogs as much memory as XZ does. "Good enough" really
> is just that, imo, and bzip2 and gzip are widely available pretty
> much everywhere, whereas I've never heard of XZ before.

Well, there were two patches in last series, and I'd rather liked the
one that decoupled list of _known_ snapshot formats from the list of
snapshot formats projects are _allowed to use_, when project specific
override for 'snapshot' feature is turned on.  So for example one can
allow project specific override (so projects can chose whether to have
snapshot, and what formats to use) but for example disable chosing
'tbz' (bzip2 compression) or 'txz' (XZ / LZMA2 compression) formats.

BTW. XZ is just new name (and improved format) for LZMA compression.
Perhaps it should be disabled by default (you can be almost sure for
gzip and bzip2 to be present on platforms one usually deploy gitweb,
but it is not true for xz-utils).

P.S. Snapshot caching.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
