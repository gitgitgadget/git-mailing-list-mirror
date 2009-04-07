From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 10/14] difftool: add various git-difftool tests
Date: Tue, 7 Apr 2009 16:32:34 -0700
Message-ID: <20090407233233.GA71372@gmail.com>
References: <1239092483-14973-1-git-send-email-davvid@gmail.com> <1239092483-14973-3-git-send-email-davvid@gmail.com> <1239092483-14973-4-git-send-email-davvid@gmail.com> <200904071952.21109.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, charles@hashpling.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 08 01:34:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrKog-0004rz-QT
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 01:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756841AbZDGXcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 19:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754841AbZDGXcl
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 19:32:41 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:5736 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756531AbZDGXck (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 19:32:40 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2974496rvb.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 16:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZA99hzEOtnEien7cfit8bJHYoS6FOA4+b/ZpJbkcTXQ=;
        b=opwIIX+75Nyb0u0YTKnX0nPvGRODpGouq0JVQgf+nXqZG+ShGb3fFaRoaox/mPzuej
         7ndb4628x6lEhMzBlvptXBRKZet9kT1blrjWqir3S3sgwluUksqntLQzy4Cse82sSWm/
         +ZaOXaWzw8e92QUS+MCsWUoZ+zsq6QrTXdSEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=yDkh6q2lp7mVIY/JHUrN9C8xiOEedoWRaGO1GIOITf5yUShAJXllqyMI80e0QfjtqW
         tL//mfyB1K6cDQyyZMRmAuaVMnyIOkPsqmpK11tovMaUn860M6d/OYFfOQPZg7P/IM0X
         1m/KR0oX5fIz4rh77ASgl9eXd6f146Bdc5BQQ=
Received: by 10.141.2.18 with SMTP id e18mr214617rvi.127.1239147159586;
        Tue, 07 Apr 2009 16:32:39 -0700 (PDT)
Received: from gmail.com (wdas-1.disneyanimation.com [12.188.26.1])
        by mx.google.com with ESMTPS id k41sm23242696rvb.36.2009.04.07.16.32.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 16:32:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200904071952.21109.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116010>

On  0, Markus Heidelberg <markus.heidelberg@web.de> wrote:
> David Aguilar, 07.04.2009:
> > t7800-difftool.sh tests the various command-line flags,
> > git-config variables, and environment settings supported by
> > git-difftool.
> > 
> > Signed-off-by: David Aguilar <davvid@gmail.com>
> > ---
> > 
> > The original broke the test suite on Mac OS.
> > Testing difftool.<path>.path is hard without internal support
> > for a fake tool.
> 
> Mac OS doesn't have the "echo" command?
> 

I figured it out.
The test was using wc -l.
On Mac OS the results are formatted differently (leading spaces)
so I modified the test to be more robust.

See [PATCH v3 10/14].

-- 
		David
