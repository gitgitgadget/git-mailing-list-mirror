From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-bisect feature suggestion: "git-bisect diff"
Date: Tue, 11 Dec 2007 02:13:45 -0800 (PST)
Message-ID: <m3ve75sfn3.fsf@roke.D-201>
References: <20071207093439.GA21896@elte.hu>
	<200712080636.12982.chriscool@tuxfamily.org>
	<20071211092446.GA4703@elte.hu>
	<20071211092916.GF30948@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 11:14:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J227u-0008Iy-OW
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 11:14:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbXLKKNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 05:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbXLKKNs
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 05:13:48 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:39548 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbXLKKNr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 05:13:47 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1243455nfb
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 02:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=XHDsfDqkn6iexqVPvMrMac5LavHx5RdbukEU9ntzQk0=;
        b=kYZrNGKqyL0w6oMMOfF300XDY1Si6c1B9skhjlSuivUFrHQ41O8ftknOMf5P2MvzQj4mo9+1x02Ous/DZKkxPV+LuDV5yhnM+NwdbLhbAktpKFUDSWoHQR0du8vugB9unzI2hisRe/nX2aTuOBvL5P/nsX/OS1ZC/dCUxxj2OfU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=pl9eSbIfkWi1q4rjTJYU4u5jWFgzaXB+389ODFiOJLliOTOrqoerYdmI1dCRLOTG2u7cqvgJk3s/inaLhrkftEizwpOPjKnHC8SRfmna92Unqd8WHg4bapduBmFddyF9G81Tx6GhD86VHbp4YY7V6gvB7pQsEoMeRc2wbL1G0EU=
Received: by 10.86.84.5 with SMTP id h5mr6520328fgb.1197368026428;
        Tue, 11 Dec 2007 02:13:46 -0800 (PST)
Received: from roke.D-201 ( [83.8.252.236])
        by mx.google.com with ESMTPS id 4sm2941325fge.2007.12.11.02.13.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Dec 2007 02:13:45 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBBADdsc008900;
	Tue, 11 Dec 2007 11:13:40 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lBBADbhH008897;
	Tue, 11 Dec 2007 11:13:37 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <20071211092916.GF30948@artemis.madism.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67833>

Pierre Habouzit <madcoder@debian.org> writes:

> On Tue, Dec 11, 2007 at 09:24:46AM +0000, Ingo Molnar wrote:
> > ---------{ git-authors }--------->
> > #!/bin/bash
> > 
> > git-log $@ | grep Author: | cut -d: -f2 | sort | uniq -c | sort -n
> 
> You mean:
>     git shortlog -n -s HEAD -- "$@"
> to do exactly the same right ? :)

Not exactly, as it does not give us email address.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
