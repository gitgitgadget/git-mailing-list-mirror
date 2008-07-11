From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT] Failure to install on RHELWS4
Date: Fri, 11 Jul 2008 22:35:34 +0100
Message-ID: <b0943d9e0807111435h414697faj8a9f789ddc6a938@mail.gmail.com>
References: <20080711170356.GF32184@machine.or.cz>
	 <200807112126.39729.trast@student.ethz.ch>
	 <20080711200735.GK10347@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Thomas Rast" <trast@student.ethz.ch>,
	"Petr Baudis" <pasky@suse.cz>,
	"Git Mailing List" <git@vger.kernel.org>,
	"=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 23:36:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHQI8-0004ga-7w
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 23:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbYGKVfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 17:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753882AbYGKVfh
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 17:35:37 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:36501 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbYGKVfg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 17:35:36 -0400
Received: by py-out-1112.google.com with SMTP id p76so2299961pyb.10
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 14:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ZERWwzgFwQ41xpXPFcH/c3LIfpXX4n8FOeZncl6DLH0=;
        b=ago9XzKrYk+xA1IYWGWrf7w1urEmMTKwoygSIU4YiO9F5orJKXNep8a9q/5xmPqE7/
         QKmmA9+B/AmsyzUGzv0vTxI0dKIFc8oTFlltGQu98Dvwp5fENhgzvUR5TQq7VVQdflV0
         QR7d0P5FWmGLX3DKwefTYqgn4Hihdkqwmes9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MdpihiZZg9FjMG6dXR89TTH7VzRMMTKKaK4nt5qyX/zW/auyvDfZwawDf/pPZkduLC
         i+zOMBqrjXeFVB0aJgvKvzFlLq+r/SySziu963P7JPMzkrfEayDY8480CmTFmWTZ2p9i
         OEMbn5IWfXWCboA0Vz+eZYIldPZK7pIcgtoSg=
Received: by 10.114.171.1 with SMTP id t1mr1774291wae.120.1215812134366;
        Fri, 11 Jul 2008 14:35:34 -0700 (PDT)
Received: by 10.114.124.9 with HTTP; Fri, 11 Jul 2008 14:35:34 -0700 (PDT)
In-Reply-To: <20080711200735.GK10347@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88178>

2008/7/11 Miklos Vajna <vmiklos@frugalware.org>:
> On Fri, Jul 11, 2008 at 09:26:29PM +0200, Thomas Rast <trast@student.ethz.ch> wrote:
>> >         pyver = '.'.join(str(n) for n in sys.version_info)
>> >                                   ^
>> [...]
>> > Python version is 2.3.4
>>
>> That is indeed too old.  Generator expressions like the above were
>> introduced in 2.4:
>>
>>   http://www.python.org/dev/peps/pep-0289/
>
> So obviously it's a bad idea to use generators for such a version check.

Yes, I agree.

> Also, setup.py would try to import stgit.run before the version check.
>
> I'm sending two patches, which restore the wished "Python version 2.4 or
> newer required. Found 2.2.1.final.0" error message.

Thanks.

-- 
Catalin
