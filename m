From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Fri, 27 Apr 2007 10:19:50 +0100
Message-ID: <200704271019.56341.andyparkins@gmail.com>
References: <7v7is3inbw.fsf@assigned-by-dhcp.cox.net> <1177662893872-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 27 11:20:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhMcy-0006bm-0B
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 11:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512AbXD0JUY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 05:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755509AbXD0JUY
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 05:20:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:17656 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755513AbXD0JUX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 05:20:23 -0400
Received: by ug-out-1314.google.com with SMTP id 44so781312uga
        for <git@vger.kernel.org>; Fri, 27 Apr 2007 02:20:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=D2arcicYtWRVIuIOf6+B6XZozgjaqq2bS27+OJhs9BWpgNjysrzOb/JCvYIemwWiwOCvGn4KnXXRYLMHr4tsfO7j0fTAKqP/wMB/82+ijdGLJLs2WNxizTTQJIz7uxzsJExFbEA2YdaxLcRmgPf+59+opZkzcr79fspyzIti11Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=P+TspuQRGj1nMxOGMdQkkSbUFOyqoFjz3vb81KCUbDESUlp5ORTae55BBli8VUaHip255ODA6wPzbSTiMnNq4sfFn0fSKYRMdFCFDxGITLTBvKWWZ5IwI8/oWTBqlVJjIruRTsirWc7clF9Y9HCA+469oYEPiG6JHI3VOU3TLIs=
Received: by 10.82.138.6 with SMTP id l6mr5153810bud.1177665621443;
        Fri, 27 Apr 2007 02:20:21 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z34sm73035ikz.2007.04.27.02.20.09;
        Fri, 27 Apr 2007 02:20:16 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <1177662893872-git-send-email-junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45711>

On Friday 2007 April 27, Junio C Hamano wrote:
> We've accumulated quite a bit of fixes on 'maint', so I need to
> do a 1.5.1.3 release soonish, as we will go into feature freeze
> on 'master' shortly in preparation for 1.5.2.

I am still concerned about the submodule thing - once we push a mainline 
version out with the format decided, that will be that and we'll be stuck 
with it.  Are we _really_ sure that it's right to have a non-object hash in 
the tree objects?

It's a fundamental change in the form of the tree: at the moment every hash in 
the tree object represents another object in the same repository; with 
gitlink as it is, that convention is broken.

Let's be really, really sure.  I'm not sure a big enough fuss has been made of 
the fact that this is a change of repository format.  Before this you could 
pretty much access any repository with any version.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
