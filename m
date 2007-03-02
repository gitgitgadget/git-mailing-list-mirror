From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Fix typo on variable name $newref should be $newrev in sample update hook
Date: Fri, 2 Mar 2007 19:25:05 +0000
Message-ID: <200703021925.09441.andyparkins@gmail.com>
References: <200703021027.00203.andyparkins@gmail.com> <Pine.LNX.4.64.0703020839350.3953@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 20:28:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNDQC-0000tD-SK
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 20:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbXCBT2A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 14:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965193AbXCBT2A
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 14:28:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:36638 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964838AbXCBT17 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 14:27:59 -0500
Received: by ug-out-1314.google.com with SMTP id 44so792838uga
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 11:27:57 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Iz7+kr+CU+qYXyj+CCrddPQZ0pFtwBsXNthMT0WMwc0wR4eBUu38a206V8p2SYZYgQElXMYQQMwxgA5OQIvPmHiQEwLqfb6mCjOEPhU+cYmrtOEV485v/UIcsosrHOse7eCclxjg3q1qUanYaeg+TNvbLdTwlkRayBj8QW+AwEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bolJy90ru0IsIlLGuKAotyDXcjtcNCHrZmRAmCSFPGxSqN69YwcaEXxWIsuXWW5hAoYiCmDlaOv+Fql3rm7uHT29GdFfqBqSIetP9KdpFaEbZonlBgcHptHWvvTWLkPbhVWU1F7mmrTNpTO8QaO0CEcv0GlROtT2Uv1YTAJaO9g=
Received: by 10.66.250.17 with SMTP id x17mr3781812ugh.1172863677900;
        Fri, 02 Mar 2007 11:27:57 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 27sm3411413ugp.2007.03.02.11.27.55;
        Fri, 02 Mar 2007 11:27:55 -0800 (PST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0703020839350.3953@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41238>

On Friday 2007, March 02, Linus Torvalds wrote:

> Well, it should just avoid git-rev-parse these days and do
>
> 	git rev-list --pretty $newrev --not --all

Ah - I didn't know that was possible.  I thought that the --not switch 
would invert all the arguments not just those following it.

Patch to follow.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
