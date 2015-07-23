From: Bing Tian <tianbing1212@gmail.com>
Subject: How to organize multiple small reusable components with Git?
Date: Thu, 23 Jul 2015 19:20:25 +0800
Message-ID: <CAMDZmAEf4afqhR4WT4e-dXjY5OWUSoE_WVGj1ztW-pA=ym9e3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 23 13:20:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIEYC-0005jN-1h
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 13:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbbGWLU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 07:20:28 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35541 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927AbbGWLU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 07:20:27 -0400
Received: by lblf12 with SMTP id f12so155244604lbl.2
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=4lwtz16Uq/+vk4mQOpE9kMRJd5iE3IAHSsG4ortI0H0=;
        b=Xb5L2YyY7DxQUHuIDQ6J9mKPO2H469TjojQAhJDkEVXYn9O1CfdFszrQSBrk8BrYse
         uyCIG0lS2MzRNYxCN+4eK4JXwkxMaUsKNcq4ZzTBx0dm/r5KA0/octT48kMvxuvQOAqj
         Dww+yJm67N0cYZ8KauXIi7iYqk9IZsjLjnAussFRc0hqwBehjRQjVfTncBUHpS6ldXjB
         f2ANbnynIW1Q/+RXOR6yZIP/Ji9f/EMG5bwcid7es7L6b00PGry/a4IUriWAbcr4Xx1l
         mjQuIMb7Nh8D2+t8vjf9U5rAwN5Sd23/lfmjdv1ofLgSb8KRjrZ6dspKKha8VgaXoXwR
         tUTw==
X-Received: by 10.152.27.197 with SMTP id v5mr7334161lag.64.1437650425578;
 Thu, 23 Jul 2015 04:20:25 -0700 (PDT)
Received: by 10.112.158.1 with HTTP; Thu, 23 Jul 2015 04:20:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274493>

I am using git to manage some circuit components.
Each component is small and I plan to create a "component" project in
Git to hold all the small components.
Each component may have several released version, such as
Comonent1_V1, Component1_V2, Comonent2_V1, Component2_V2.
And for future reuse, I may use Component1_V1+Component2_V2, or
Component1_V2+Component2_V1 in my local directory.
So, I plan to create several directories, each for one version of one
component. I looks like followings:
Components
     |------Component1
     |                 |------------------Version1(Dir)
     |                 |------------------Version2(Dir)
     |-------Component2
                       |------------------Version1(Dir)
                       |------------------Version2(Dir)

I want to know, is the above a suitable way in Git?   Are there some
risks for my project and Git?
Any suggestions to cover this case in Git?
