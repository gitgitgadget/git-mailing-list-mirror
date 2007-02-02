From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current branch reflog
Date: Fri, 2 Feb 2007 16:13:08 +0000
Message-ID: <200702021613.11058.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home> <200702021308.48599.andyparkins@gmail.com> <45C3559B.80104@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Rogan Dawes <discard@dawes.za.net>, Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 02 17:13:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD12V-0005v9-Ud
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 17:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945964AbXBBQNS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 11:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945966AbXBBQNR
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 11:13:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:41841 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945964AbXBBQNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 11:13:16 -0500
Received: by ug-out-1314.google.com with SMTP id 44so799586uga
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 08:13:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RC07IYJlG2HkDzoW1O3aq5ud8xweFzv7swOGa4+QQ9hMUYFXLR9yC2zErilQhE0YRcl3CpF1z32Rd3ZCoMg59pm5FWb67H5KUaUTE1xmMG7ezcrtGjSmgbMaudUiuWzb6flHKrW9G7nm94R5iY+IH1Ky5lLBQA6JxwyElr2Tzy4=
Received: by 10.66.232.11 with SMTP id e11mr4630122ugh.1170432794458;
        Fri, 02 Feb 2007 08:13:14 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id w40sm4551526ugc.2007.02.02.08.13.11;
        Fri, 02 Feb 2007 08:13:12 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <45C3559B.80104@dawes.za.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38510>

On Friday 2007 February 02 15:15, Rogan Dawes wrote:

> However, if HEAD@{} means what was HEAD pointing at at the indicated
> time, and @{} means "current branch", then we need no exceptions, and
> the common case is shorter.

In that case I propose that we rename git-commit to git-c; git checkout to 
git-o and git-merge to git-m.

Apologies.  I'm being facetious.  I don't think "which is the less typing" 
should be the decision policy when we're only talking about four letters.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
