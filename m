From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation/config.txt: Order variables alphabetically
Date: Wed, 01 Dec 2010 05:58:45 -0800 (PST)
Message-ID: <m3eia14mu7.fsf@localhost.localdomain>
References: <1291209174-9239-1-git-send-email-jari.aalto@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed Dec 01 14:59:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNnDQ-0000Jq-QO
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 14:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173Ab0LAN6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 08:58:55 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54586 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755049Ab0LAN6s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 08:58:48 -0500
Received: by bwz15 with SMTP id 15so6141576bwz.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 05:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=GGhOhGfIW0R48E3T6mR4l614n0fMh8PSHAIGWnTKkCs=;
        b=eZWpTjU/3PfZfki95WHcWsLxbNFbkPFQopUj9k13JtGRTJ586hMUf5IiJ0MyLKmHky
         vX7Qnnvq6QoQc1zg2LXV+WosOF5m8NjaopyzSXlQBr3Azs7Cjbddvq07/CsXZAtg05Zz
         IIgQ4RiyTuyHaEmOH9+QxqsEnm2KRWnke87g0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=xkhwe1SwZwCAQmzXgHtBpEKwyVOFmW1Prdjc1dSPX3I7zBJrpPB/OsSYUeQJGgu+7t
         ZUmQpgLthtTpbG6xbaf/iVh2aE6FD9LcJGcM/KZnKknSL42aPSkSyTTfzmZyDEvHamEw
         GK2VOfKbxe3Ejkpytr0/y/4q8UdJd4fV6OVsY=
Received: by 10.204.69.200 with SMTP id a8mr8415118bkj.36.1291211926946;
        Wed, 01 Dec 2010 05:58:46 -0800 (PST)
Received: from localhost.localdomain (abvl90.neoplus.adsl.tpnet.pl [83.8.209.90])
        by mx.google.com with ESMTPS id 11sm3412182bkj.0.2010.12.01.05.58.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 05:58:45 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oB1Dw9CL020959;
	Wed, 1 Dec 2010 14:58:20 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oB1Dvr6Y020955;
	Wed, 1 Dec 2010 14:57:53 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1291209174-9239-1-git-send-email-jari.aalto@cante.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162517>

jari.aalto@cante.net writes:

> From: Jari Aalto <jari.aalto@cante.net>
> 
> 
> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
> ---
>  Documentation/config.txt | 1698 +++++++++++++++++++++++-----------------------
>  1 files changed, 852 insertions(+), 846 deletions(-)

Why?  What such large change is for?

Note that currently config variables are grouped by functionality: for
example core.eol and core.safecrlf, or core.compression and
core.loosecompression are close to each other.

I like the fact that we have first advice.*, then core.*, then mostly
alphabetically sorted rest of configuration variables.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 6a6c0b5..6e92623 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -142,313 +142,251 @@ advice.*::
>  	detachedHead::
>  		Advice shown when you used linkgit::git-checkout[1] to
>  		move to the detach HEAD state, to instruct how to create
> -		a local branch after the fact.  Default: true.
> +		a local branch after the fact.	Default: true.

This change has nothing to do with ordering variables alphabetically,
therefore IMHO it belongs in separate patch.

[...]
-- 
Jakub Narebski
Poland
ShadeHawk on #git
