From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: t9500-gitweb-standalone-no-errors.sh.prb 4 errors
Date: Sat, 07 Mar 2009 17:05:47 -0800 (PST)
Message-ID: <m3ab7wizz5.fsf@localhost.localdomain>
References: <alpine.LNX.2.00.0903071645370.20607@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 02:07:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg7U8-0006sg-8e
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 02:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbZCHBFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 20:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbZCHBFw
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 20:05:52 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:10653 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbZCHBFv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 20:05:51 -0500
Received: by fg-out-1718.google.com with SMTP id 16so680349fgg.17
        for <git@vger.kernel.org>; Sat, 07 Mar 2009 17:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=zHRivP6rs4aLXXMafu77zZTIbvLWLJ06VNZdOr6GqTo=;
        b=uTsiLDIIkZiCLB8pScRatMBnr1eOc4zmDB5xBabHkzaGYb4DFsLntllEKXZexyNa6m
         0msCDARJrf0jhNf65Rpufk+ukpilr9xp4D9gvWeXybFQ5XeY6zZvcyeDx+AONglytPEp
         KwNCaQwNz79yFb9OfYvkB7rKXrnFgKJaJAwGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=GK/26UxOPuUUFMIenepy9w1Vl2fH60NNBpGFBKCyuk982nfMCfviHQSQY44wLE1xDu
         AAJzrpj3GyOyWsliln/xHydvsQcDy7sPj7HjE8tx+SFVzQ3UJBNR9+/3YCjLg92u2CJX
         5O/9z/AFdOPaDLqvSLqWFCEdhfys782W2hgAM=
Received: by 10.86.98.18 with SMTP id v18mr2984853fgb.46.1236474348175;
        Sat, 07 Mar 2009 17:05:48 -0800 (PST)
Received: from localhost.localdomain (abwb243.neoplus.adsl.tpnet.pl [83.8.225.243])
        by mx.google.com with ESMTPS id 3sm1675577fge.48.2009.03.07.17.05.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Mar 2009 17:05:47 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n2817iCW032573;
	Sun, 8 Mar 2009 02:07:46 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n2817g2Q032570;
	Sun, 8 Mar 2009 02:07:42 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LNX.2.00.0903071645370.20607@suse104.zenez.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112601>

Boyd Lynn Gerber <gerberb@zenez.com> writes:

> Test fails for SCO OpenServer 6.0 MP4 with 1.6.2
> 
> Below is the set -x output of the tests.

Could you run it without -x, but with --debug (as option to test
itself) instead?  Because what matters here not on which command the
test failed (we know it is on gitweb_run), but what error message
gitweb returned.

Also the problem might with in Perl modules gitweb uses (CGI, Encode,
...), and with Perl version used, although it is less likely...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
