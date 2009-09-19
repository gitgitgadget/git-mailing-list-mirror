From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Cygwin git dies silently
Date: Sat, 19 Sep 2009 10:19:01 +0200
Message-ID: <20090919081900.GA7543@localhost>
References: <A80C2B4F6C34430FA32A24BF94647076@ouster>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Ousterhout <ouster@cs.stanford.edu>
X-From: git-owner@vger.kernel.org Sat Sep 19 10:19:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MovAQ-0003x8-Mb
	for gcvg-git-2@lo.gmane.org; Sat, 19 Sep 2009 10:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227AbZISITY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Sep 2009 04:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753760AbZISITY
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Sep 2009 04:19:24 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:26084 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334AbZISITW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Sep 2009 04:19:22 -0400
Received: by ey-out-2122.google.com with SMTP id d26so139660eyd.19
        for <git@vger.kernel.org>; Sat, 19 Sep 2009 01:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:bcc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=GU2d8MGAqmi44A9oX8DL/mzFtf2H7l+ZQq7btsVpWBE=;
        b=KxZ0n4wnEv12FLRw474OB82vuxPpGccB0igZRGFnhfcqk4LUbLhgfqvPP/XV5EtsBi
         xdy+4y/MIbA5Qfrw6gv7nBco6gxOVlu44hTysexGKdnThuMf2/0kZX1dEV2tkPL/QXa2
         ZP/84fbI1EhcBrmW8BERdqnVw+5Wwy7VCCX44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=cGJZE8KMOA3gN+6fJAQVW4K+dY7JBDLfn7yzF3JOUwuidul+YF5QKJtQsMOanaW+Kn
         e8D1ZR4HWOez1ji+O7ypXy1D/nrm5RzFIDAqvgeqjsZpOoPPvEVlMc61cUlYXrCpS3KJ
         XhWFP5S3FrmqalFWQXCzT7BpOaS7GJJPByLzc=
Received: by 10.211.143.19 with SMTP id v19mr467149ebn.47.1253348365545;
        Sat, 19 Sep 2009 01:19:25 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id 18sm3431996ewy.45.2009.09.19.01.19.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 19 Sep 2009 01:19:23 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1Mov9p-0002xm-4P; Sat, 19 Sep 2009 10:19:01 +0200
Content-Disposition: inline
In-Reply-To: <A80C2B4F6C34430FA32A24BF94647076@ouster>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128819>

On Fri, Sep 18, 2009 at 04:48:42PM -0700, John Ousterhout wrote:

> "echo $?" says that git is exiting with status 53.

Git never returns 53. Googling for exit status 53 turns up some hits [1].

Clemens

[1] http://www.google.com/search?&q=exit+code+53
