From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Sun, 18 Mar 2012 17:52:51 +0100
Message-ID: <4F6612E3.5040600@gmail.com>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org> <CADVrmKSGbA2gWVyPLMCBay3EikOykwq3eEH1+qWCpZvOron3Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: fREW Schmidt <frioux@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 18 17:53:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9JLz-0004gw-8F
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 17:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755605Ab2CRQxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 12:53:05 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:61309 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755557Ab2CRQxD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 12:53:03 -0400
Received: by wibhj6 with SMTP id hj6so2885751wib.1
        for <git@vger.kernel.org>; Sun, 18 Mar 2012 09:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=7eI3GskXCibf5yHgB3T7tDZMwRMyPNpTmuIy6FVdb1s=;
        b=mhn+YGY6ETclymalEQNwg46nzBiqJFlDkpVzczIm2hUjiAXhU0nNcMQy7+LHxCF7gg
         FnVaItuDOP/dl9RlC1bXIn5D9XXobGPFNWtLjr5cdzxagS6IzRukVBJzuRTd/eDBWxdL
         aaA0GUCFS5ZcvCCMOQuQf+Ug8uhrk5jNgIkXSg2dCD3DKX5VB0779zM/VIWBbLDeVG1y
         ugbb0Fl4KWG1dNJbbBn1umL6VgczqDWEAHgZz8lThE7dAAV0VQ7Sdk/b1xsZ2jQk6mL2
         iWeVUDhjTrohnB+KLvK2k/SN3t4reroR/ejohNqQMcZnTEouaK5zwJXC1VzKrNWtfwNb
         M7Lw==
Received: by 10.180.102.129 with SMTP id fo1mr13406181wib.6.1332089582833;
        Sun, 18 Mar 2012 09:53:02 -0700 (PDT)
Received: from [192.168.178.22] (p5DDB00EA.dip0.t-ipconnect.de. [93.219.0.234])
        by mx.google.com with ESMTPS id ff2sm29159990wib.9.2012.03.18.09.53.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Mar 2012 09:53:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CADVrmKSGbA2gWVyPLMCBay3EikOykwq3eEH1+qWCpZvOron3Aw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193386>

On 17.03.2012 19:43, fREW Schmidt wrote:

> its tracking branch only.  That leaves very little room for surprises
> and mistakes (the one exception being git push after git checkout -b
> new-branch origin/master.)

That's exactly why I'd prefer "current" instead of "upstream" as the 
default behavior, as it even causes no surprises in the checkout -b 
case, IMHO.

I believe the most common workflow for the large number of git users who 
are no integrators / maintainers is to start a topic branch from master 
and then work on that topic branch until it gets merged. In order to 
test the topic branch on other platforms or make it available to others, 
it's a common operation to push the topic branch to a branch of the same 
name instead of the tracking branch. That's why I believe "current" is 
both the setting that matches the workflow of most git users and is the 
setting that really causes the least surprises (not least because it's 
straight forward what the name of the pushed branch would be, as it's 
the current branch's name; if you don't know the upstream branch's name 
out of your head, you'd have to look it up to know).

-- 
Sebastian Schuberth
