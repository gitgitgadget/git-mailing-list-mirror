From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current branch reflog
Date: Sat, 3 Feb 2007 17:54:17 +0000
Message-ID: <200702031754.19494.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home> <200702021611.06029.andyparkins@gmail.com> <slrnes9ga2.3l6.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Mark Wooding <mdw@distorted.org.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 03 18:57:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDP8X-0003vW-Sk
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 18:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbXBCR5R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 12:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbXBCR5R
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 12:57:17 -0500
Received: from nz-out-0506.google.com ([64.233.162.228]:23425 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbXBCR5P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 12:57:15 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1201823nze
        for <git@vger.kernel.org>; Sat, 03 Feb 2007 09:57:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QRt03WfvSMfflKxWluOkVpVlWn5/xIUx7AGpGisFJdYWfZa9mIIONI6DVjV53DdDypt2l7n2vx9To+dk0YmbBc5mv5F+6mcJTQmC4tqWRm1S9vbLTZxIh+Sc4enjhYL5RtVXJ7IfcXj2S/OMWbLkNXq1xiGPoKNU65RgqCWOkoM=
Received: by 10.65.211.1 with SMTP id n1mr8188599qbq.1170525435544;
        Sat, 03 Feb 2007 09:57:15 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id f14sm3055164qba.2007.02.03.09.57.12;
        Sat, 03 Feb 2007 09:57:13 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <slrnes9ga2.3l6.mdw@metalzone.distorted.org.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38580>

On Saturday 2007, February 03 17:07, Mark Wooding wrote:

> And what do you do when HEAD is detached?

Well; my proposal was that when head is detached HEAD@{} would return 
the "unnamed branch" reflog.

However, that idea has been rejected (which I'm fine with).

> I mean: I detach HEAD, and then ask about HEAD@{yesterday}.  It'd be
> nonsensical for that to be an error, since HEAD surely did have a
> value yesterday.  But it can't tell me where my current branch head
> was yesterday, because there isn't a current branch to tell me about.
>
> HEAD@{date} referring to the HEAD reflog is the only sane thing to
> do.

Well I don't think "only sane thing" is entirely accurate; I'm happy to 
accept counter arguments, but rhetoric doesn't count.

My (abandoned) suggestion was that

 HEAD@{..} on a undetached head would be equal to <current-branch>@{..}
 HEAD@{..} on a detached head would be equal to unnamed-branch@{..}
 @{..} would be equal to <whatever-i-was-on>@{...}

I accept (but not necessarily condone) that the counter proposal is also 
valid.  My argument is about which is the more consistent.  It would 
appear to be a judgment call; so I'm happy to bow out.  I don't think 
calling me insane (by proxy) lends any weight to any argument.



Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
