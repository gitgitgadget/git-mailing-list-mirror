From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/1] Introduce a way to create a branch and worktree at
 the same time
Date: Thu, 10 Mar 2016 14:24:16 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603101422190.4690@virtualbox>
References: <cover.1457609615.git.johannes.schindelin@gmx.de> <CACsJy8BA7-ev9wTt6K45TgiNxOaBUXbN1P03U4EUAzAPy=7Faw@mail.gmail.com> <CACsJy8D7+sXF9gRj15kidgK_xzSVHqChSFdqHpJ3PwxMOw2rHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 14:24:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae0Zx-0006cE-QY
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 14:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbcCJNYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 08:24:24 -0500
Received: from mout.gmx.net ([212.227.15.19]:61756 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398AbcCJNYX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 08:24:23 -0500
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lt1eU-1ZhCtn0Zkw-012c1J; Thu, 10 Mar 2016 14:24:17
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CACsJy8D7+sXF9gRj15kidgK_xzSVHqChSFdqHpJ3PwxMOw2rHA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:9uKtEyK1Mby7LrkMm5apZ9W6ylPM61NHnkxiHlgl4r15GAv31WV
 yVqoqdGqGO21v1L8e0v+GU3rakEnusiE61T4k+nJIaLFdN3PgaW+s/GHol6F7kNrfQHJx8B
 avuqXyXrsYljvsjwBDI1g7bq/eOZ8wz3MIsQowlKYmqCNKD5cx7s8BnM3LflIRr6jxjTRMW
 71ROQa4bdBCBXhhbmWicg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jB74Nc2weIg=:a1rmw89Q0gr+8WxX3gML/S
 lHNpWNGWZyNijkPCXcxda2l8Y8ULNy0ZuZshuYYAzdYjprpR4ozaZTZcn9iGa/bXIobPOPEXT
 OWv7PteTgoaaQzc4sCnZl1CyDj8cEZXiRSEsojBtN69NCbOnuFFmlvSx2HdZPRoSrXaMRmQm2
 +jecrY37h7IkbJImdrlSZf9m2hVzxPK1Yl3iR2rNUQuaoJ1X/FCDx1TYXb8MmhhTjubtgHIB6
 BL620Vp6e0L1SKCcHyMynwYFJdQXaPEQz3XamNBB4wn/KCE0Kxg/+F4h/zrWlUIgZHcJVuR98
 enCvPCzMJQ1q5KnWcPQCXUPmQG2oI85cNyA2BJw1oXus+RvhhiCN49kmkAuH/cEmmyrPzeF19
 ifhAPb8rKY1CZij/ZlzMAUNc4Qdol/RZI+5+L5SS0ht4JqfTn7L2OxTyxsPgL1DmGxgHQYw8/
 yAnrZmNq5gHlOQxKjv3x0xCY1Hz2+5ULbVcm5XLwoFK75oPGyhVJ5Ad01MyEZ3h10cF3L/kOa
 Oc2OtA9dr5BUu9RdcWwZ3lH2DOYaKJv5LdpWmTyx0gw/8Spbmmlys6+jEd9ow3JKe9IdBMnQE
 fBvhH+aJ2T0yQOCaOywelTIBUrWdS/Rb1tCujcV4la3kRBy2gPu+RkTwLdNfhrW5mtEXV3GuY
 0/1/KL0GFwS/lP/VEx9klKe2Cf1iY+JmWvAIPZGfJWyY+M6iksWvWJ/1LVmBWxUO76C9EYds7
 IfqjjkC9ps/5uq88gisjD88nH7vbC752L3m+YyR3fGef6XVFWfVCc0cmIS7U8mlwsnWF7Obm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288622>

Hi Duy,

On Thu, 10 Mar 2016, Duy Nguyen wrote:

> On Thu, Mar 10, 2016 at 6:51 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> >> It gets rather tiresome, and also typo-prone, to call "git branch xyz
> >> upstream/master && git worktree add xyz xyz" all the time.
> >
> > You can actually do "git worktree -b xyz xyz upstream/master" for the
> > same effect. Maybe we can avoid "xyz" duplication with "-b -" or a new
> > option name?
> 
> Another option is just do "worktree -b xyz . upstream/master"
> 
> when the destination already exists and is a directory, the real
> worktree location is <dest>/<branch name>. Similar to "mv abc def"
> becomes "mv abc def/abc" when def is already a directory.

Hmm. That sounds too clever to me. It is clever, alright, but it is also
confusing: "Wait, what? Where is my... Darn! It already existed! And now I
have my-cool-worktree/my-cool-worktree/! Blergh."

Please count that as mild opposition to that idea :-)

Ciao,
Dscho
