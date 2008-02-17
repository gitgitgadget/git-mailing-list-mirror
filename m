From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Sun, 17 Feb 2008 05:39:26 -0800 (PST)
Message-ID: <m3d4qvbt40.fsf@localhost.localdomain>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org>
	<7vd4r24ox6.fsf@gitster.siamese.dyndns.org>
	<7vir0o44mt.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 14:40:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQjkY-00023c-Bq
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 14:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756712AbYBQNje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 08:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756395AbYBQNjd
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 08:39:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:64776 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755381AbYBQNjb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 08:39:31 -0500
Received: by ug-out-1314.google.com with SMTP id z38so158819ugc.16
        for <git@vger.kernel.org>; Sun, 17 Feb 2008 05:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=1B5TvHeUzJoW5ck/7TjNG1jV8Zo3Gu5g+WTk9vfY7f0=;
        b=f399GS8/f669Aygatlr25psthy3CYXs4JfxRr9oKBBcSFQxewSDFk/6lfqrLsTvoRFrS1fqVTaHBwFFLD+tAwAJLWB1Qoz4UciIm4maLGWxu8Lbkuwo/xKxTm9HhXEsyRDGzy+zjFTo9KTu7dohkINMRZg+KE3RJC9OjQP64JYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=cEXgBoqCpKCa8tvhxjDqxmYUDcmme9EqKsn7x11VZ2DmrJva7RO8f52Ah7siuBD1i60+2APOjN45gx42kdeBNDZ1cUkcNOl5DM/zeZjOyPVfXpGjbD8qgqupkoF1DWrvUX3Tc30PvV8h2p04IE4dKkZQOwykVAVYRxvzra8dK8k=
Received: by 10.67.115.17 with SMTP id s17mr1908326ugm.56.1203255567880;
        Sun, 17 Feb 2008 05:39:27 -0800 (PST)
Received: from localhost.localdomain ( [83.8.248.52])
        by mx.google.com with ESMTPS id a1sm2847242ugf.78.2008.02.17.05.39.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 17 Feb 2008 05:39:26 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1HDcumh022707;
	Sun, 17 Feb 2008 14:39:07 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1HDceEj022633;
	Sun, 17 Feb 2008 14:38:40 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vir0o44mt.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74129>

Junio C Hamano <gitster@pobox.com> writes:

> On the 'master' front, a handful topics have graduated:
> 
>  - Brian Downing's compat/qsort;
>  - Crhstian Couder's browser wrapper;
>  - Paolo Bonzini's prepare-commit-msg hook;
>  - Steffen Prohaska's safe-crlf;
>  - "foo/" in .gitignore matches directory "foo".

Nice.

> Daniel Barkalow (1):
>   Validate nicknames of remote branches to prohibit confusing ones

Good one.

> Jeff King (2):
>   status: suggest "git rm --cached" to unstage for initial commit

Corner case, but good one.

>   commit: discard index after setting up partial commit

IIRC there was also request for proper solution; this was more a hack.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
