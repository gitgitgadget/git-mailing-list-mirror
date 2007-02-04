From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Why is it bad to rewind a branch that has already been pushed out?
Date: Sun, 4 Feb 2007 18:01:29 +0000
Message-ID: <200702041801.31110.andyparkins@gmail.com>
References: <7v1wl7bv66.fsf@assigned-by-dhcp.cox.net> <200702031041.13437.andyparkins@gmail.com> <7vy7nf3u5m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 04 19:04:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDljA-0008EC-2m
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 19:04:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbXBDSE0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 13:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752452AbXBDSE0
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 13:04:26 -0500
Received: from nz-out-0506.google.com ([64.233.162.232]:23534 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451AbXBDSE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 13:04:26 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1402350nze
        for <git@vger.kernel.org>; Sun, 04 Feb 2007 10:04:25 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=B5Ob5ephQnbiMMuXdlvFk2XBYhE+FuVubwofEeRlQ2zvpAFgt57Gxs/pYAl45Cqs3WakcMVaYZ96R8lRSLmjZy+a9Jt/cEZEbtx+xFo8iMdDEZFQsuHvwI6Zmz6AZpkKaF02omwuUEPOE1wLnBnbmx78KBu+3U1fNpSNkmcvV/U=
Received: by 10.65.193.16 with SMTP id v16mr9282931qbp.1170612265268;
        Sun, 04 Feb 2007 10:04:25 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id q15sm9802904qbq.2007.02.04.10.04.21;
        Sun, 04 Feb 2007 10:04:22 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vy7nf3u5m.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38698>

On Saturday 2007, February 03 19:42, Junio C Hamano wrote:

> Actually, if you are assuming a, h, and j are unrelated, then
> the merge done by Alice will _not_ revert 'j', so the history
> will perfectly be fine.  The merge result will have a half-baked
> work done with 'j', and everybody can build on top of.

Absolutely true.

Your point is a strong one.  I think I'm still not thinking big enough 
with the distributed development concept.  Your point has made me 
consider that I've been overly concerned about not rebasing pushed 
commits.  Provided you're willing to correct conflicts in a merge; they 
aren't as bad as I initially thought - in fact they offer a further 
choice when creating project history.

Thanks Junio.



Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
