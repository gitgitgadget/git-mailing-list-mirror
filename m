From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] autoconf: Add test for OLD_ICONV
Date: Wed, 5 Dec 2007 17:33:08 +0100
Message-ID: <200712051733.11590.jnareb@gmail.com>
References: <7vd4u5l29v.fsf@gitster.siamese.dyndns.org> <1196869526-2197-1-git-send-email-jnareb@gmail.com> <82D48BF0-E01D-4CE4-92F3-44B555531624@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 17:34:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzxC2-0001Ml-94
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 17:33:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbXLEQd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 11:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbXLEQd3
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 11:33:29 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:61475 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbXLEQd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 11:33:28 -0500
Received: by nf-out-0910.google.com with SMTP id g13so3172123nfb
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 08:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=d1/I96SSZudUI5OtC1MgnTXjWQHRhmHCEli13whBweI=;
        b=nni7p6cUecHRHj1whKuZZwhw0y6G3ksBxG6rHo2VDMgeOU7sZMdBya/oRFLCzOaQTTvyxnCPyUHELVy7URXPk2tjG4uOYYWLrA2I0l2XpfxhssmjFYE9zfsCHO/u9YsKZNhvSDIFOXGxtdC/bPStnsN+W1iS0qlHWZ4Q7jVKjUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PJTctQSFLpZx54hughslFgj6GvqMx7k+0lKgUwN/mTrkg/iLCL1rYlYA2UXtNV0xmw5NxbBJ7Fpndf8Wn7nUN7LS0qAj4I0Y7W94u/cLIKs9PfIhGRhzxguRMuOflgfr4e3rXFcGWH9Fj+2TZnUtX/tJ3x8zbJMIqDEV+bUO0VA=
Received: by 10.86.66.1 with SMTP id o1mr650621fga.1196872407157;
        Wed, 05 Dec 2007 08:33:27 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.215.161])
        by mx.google.com with ESMTPS id l19sm14619871fgb.2007.12.05.08.33.25
        (version=SSLv3 cipher=OTHER);
        Wed, 05 Dec 2007 08:33:26 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <82D48BF0-E01D-4CE4-92F3-44B555531624@silverinsanity.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67166>

On Wed, 5 Dec 2007, Brian Gernhardt wrote:
> On Dec 5, 2007, at 10:45 AM, Jakub Narebski wrote:
> 
> > This patch needs checking if it correctly sets OLD_ICONV
> > when needed.  I have checked only that it is not set when
> > with new iconv() declaration.  Could people using Cygwin
> > (and other with OLD_ICONV: Darwin) test it?
> 
> I could not get git am to apply the patch cleanly, but will try again  
> later when I have more time.

Hmmm... it should apply cleanly to both 'master' (7a4a2e1f797)
and 'next' (bd1cfb7fbddc). It just adds some contents...

-- 
Jakub Narebski
Poland
