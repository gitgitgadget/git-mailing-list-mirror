From: Corey F <coyotebush22@gmail.com>
Subject: GSoC git-add--interactive improvements
Date: Tue, 03 Apr 2012 21:07:26 -0700
Message-ID: <4F7BC8FE.4060808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 06:07:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFHVS-0002Ie-Ik
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 06:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918Ab2DDEHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 00:07:31 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64437 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab2DDEHa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 00:07:30 -0400
Received: by obbtb18 with SMTP id tb18so638760obb.19
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 21:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=v7Mu/YlN5Q3NgapNMMmidsB8eHb/uGruIggnKoOIR54=;
        b=z8IbWov8PTRzLVssGV2ECJAanjMf5JvnFI+t4whxXN48LbaXXDuDjNgQtJaFpOmiKJ
         t0lOheR5Qb/GFh5Ki6e6Uy0wS2wErhwIIE0+nGtNI1GywzMCEIMmVJnn/5RR9zUGpqzS
         xYVOkqqlC/EPww4WP36gjoxj0mOR7nURpvoxSYAHKCLyrLMrrHSm6azSb31zLmb5+3Ee
         G2W2GqrgrPjg1tNK1vvvz+W/Xub148xdH7wV1TNgLz5d7j/4nb0C/jMvC+p0Yusyzhb8
         u4LBOPp1mWD4AZu7KvV362Ea7DFRcXnjYg+LuDDTp7OLxPM1aWCMkMa+3+XdIlfZlv2v
         y5kw==
Received: by 10.60.0.135 with SMTP id 7mr22388600oee.25.1333512449935;
        Tue, 03 Apr 2012 21:07:29 -0700 (PDT)
Received: from [198.188.150.160] (pcp037279pcs.cabrillo.reshall.calpoly.edu. [198.188.150.160])
        by mx.google.com with ESMTPS id s2sm18942139oea.2.2012.04.03.21.07.28
        (version=SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 21:07:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120216 Icedove/8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194677>

Hi all,

I'd be interested in making improvements to the git add -p (etc.) 
interface as a Google Summer of Code project, as suggested on the ideas 
page [1].

The page lists some interesting ideas for both larger architectural 
changes and smaller interface improvements, though I agree that getting 
lots of community input during the project will be important. So at this 
point I'm wondering how much I should plan out in my proposal -- maybe 
pin down a few important features and a process for getting more input?

Last year's SoC ideas page included rewriting some commands in C, 
including this one. I'm at least as comfortable with C as with Perl, but 
I'm guessing that incorporating a rewrite into the project would be an 
ambitious and/or dangerous idea.

Any thoughts on how best to approach this project idea are welcome.

Alternately, the "ultimate content tracking" tool to find similar 
sections that might have been the basis for newly added lines sounds 
intriguing, and I will refresh myself on the previous list discussion 
regarding that idea.

Thanks,
Corey

1: https://github.com/peff/git/wiki/SoC-2012-Ideas
