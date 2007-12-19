From: Pascal Obry <pascal.obry@gmail.com>
Subject: Re: Problem with git-svn
Date: Wed, 19 Dec 2007 12:27:45 +0100
Organization: Home - http://www.obry.net
Message-ID: <47690031.7090409@obry.net>
References: <4764FE2C.1010103@obry.net> <20071219082751.GA17787@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Dec 19 12:28:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4x5y-0006NA-6w
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 12:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbXLSL1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 06:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752202AbXLSL1v
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 06:27:51 -0500
Received: from mu-out-0910.google.com ([209.85.134.188]:62951 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbXLSL1u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 06:27:50 -0500
Received: by mu-out-0910.google.com with SMTP id i10so4053490mue.5
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 03:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        bh=XJcI31UwS5TtY37XB+sXVZgNzUflT4yIRVQa79GWyX0=;
        b=b9m8TpdgSVib5FsGnA99+Jn5KKLz+eYM3PyGKx55sQMhMrzua7gEaugwy/1JhZKo4qjlk8UPCzix0OmCc9S94pi1Wq6fy8bE0ZW9iUyevai2FP4cL6RslwjL0rLV89+JYlFxpkYF/eOTdANl92lmQSWym1+CvGvemztPiDpmUTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        b=uW2jK3ePgZQDnX1ymdUhQnQExIs9uEsrcg+n+xCfiCBno+yWl+C0SQ9yDB6M2xjIa+ClzCPtcE5C1FTb2GWY7l2vSPq4F6oHm+z34DbuxVF7iVigON8irWczBR+NwPCb3ezgZLiiUTX7i0Tf5IFZhmkyenxPH5q+SSxeJoEnDmk=
Received: by 10.86.54.3 with SMTP id c3mr8809888fga.4.1198063668667;
        Wed, 19 Dec 2007 03:27:48 -0800 (PST)
Received: from ?10.10.127.189? ( [212.99.106.127])
        by mx.google.com with ESMTPS id d6sm14168794fga.2007.12.19.03.27.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Dec 2007 03:27:47 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <20071219082751.GA17787@muzzle>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68885>

Hi Eric,

> Can you show me the output of `svn log -v -r9458 svn+ssh://myserver/'?

$ svn log -v -r9458  svn+ssh://myserver/
------------------------------------------------------------------------
r9458 | (no author) | 1998-04-22 19:07:08 +0200 (Wed, 22 Apr 1998) | 1 line
Changed paths:
   A /importfromcvs
   A /importfromcvs/branches
   A /importfromcvs/tags
   A /importfromcvs/trunk

New repository initialized by cvs2svn.
------------------------------------------------------------------------

> So did svn+ssh://importfromcvs/trunk/file.el at r9458?  If so, git-svn
> is behaving as expected.  If not, can you tell me where "file.el" was at
> r9458?

file.el was not imported at r9458 but at r9459, just after the creation
of the /importfromcvs directories above.

------------------------------------------------------------------------
r9459 | author | 1998-04-22 19:07:08 +0200 (Wed, 22 Apr 1998) | 2 lines
Changed paths:
   A /importfromcvs/trunk/file.el

Initial revision

------------------------------------------------------------------------

Thanks,
Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
