From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/8] docs: use `...' instead of `*' for multiplicity
Date: Sat, 18 Dec 2010 02:00:42 -0800 (PST)
Message-ID: <m3hbebl7tv.fsf@localhost.localdomain>
References: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
	<1292650725-21149-3-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 18 11:01:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTtb7-0005Fz-JE
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 11:01:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860Ab0LRKAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 05:00:45 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39907 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439Ab0LRKAo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 05:00:44 -0500
Received: by wyb28 with SMTP id 28so1448196wyb.19
        for <git@vger.kernel.org>; Sat, 18 Dec 2010 02:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=zWrMpgQH78/cYWr1+J26YTSSRgDaoTK2lEU17ebsq2Q=;
        b=sFUXGskYbiVjt9Ear+C5HFqPgBHe+t7/kwzpsiybN1KYWMgp6yk6OQcQIPRt9OJDki
         Rz0DduY0ef3DQVAWoCX0g6qLZfHHMJVGWTEnTjS2DSH0COf0joI4i6BOTNBJGj7ihM3L
         pZy59y3MueJYv6AzOOBzhrUjRV45eYOHH2qZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=HJs2eJlCQsGln/Rzx+PyblLQjMl9wrtC5gwHweV6qAohevaA68QlXfb5pfUfvpZ6nS
         nXMJ0j9fdqYCrkylPSowPhmkgYI3FAUlRjIIcbYVfcJzQ1TeUUX/JnLa9jDwAJ5BymBs
         OqI2cVpF8lXMezWFGwB4RdTx4yUBi1lz9jf78=
Received: by 10.216.179.71 with SMTP id g49mr2174428wem.94.1292666443442;
        Sat, 18 Dec 2010 02:00:43 -0800 (PST)
Received: from localhost.localdomain (abrz118.neoplus.adsl.tpnet.pl [83.8.119.118])
        by mx.google.com with ESMTPS id j58sm675707wes.45.2010.12.18.02.00.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Dec 2010 02:00:42 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBIA0DkF012073;
	Sat, 18 Dec 2010 11:00:18 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oBI9xv2e012030;
	Sat, 18 Dec 2010 10:59:57 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1292650725-21149-3-git-send-email-lodatom@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163912>

Mark Lodato <lodatom@gmail.com> writes:

> Finish the work of 0adda93 (Use parentheses and `...' where appropriate)
> to follow the rules set forth in Documentation/CodingGuidelines.
> 
> Signed-off-by: Mark Lodato <lodatom@gmail.com>

[...]

> -	"git describe [options] <committish>*",
> +	"git describe [options] <committish>...",

Isn't <sth>... one or more, while <sth>* is zero or more, i.e. shouldn't
<sth>* be replaced by [<sth>...]?

Hmmm... I see that <sth>* was actively wrong if it was to mean zero or
more, so your change doesn't only make documentation more consistent,
but fixes errorneous use of convention.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
