X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: Mozilla, git and Windows
Date: Mon, 27 Nov 2006 15:34:22 +0000
Message-ID: <456B057E.4000904@shadowen.org>
References: <9e4733910611270728p36e58e08w6cc7a2989b7843ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 27 Nov 2006 15:35:05 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
In-Reply-To: <9e4733910611270728p36e58e08w6cc7a2989b7843ce@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32421>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoiV2-0008R2-Qz for gcvg-git@gmane.org; Mon, 27 Nov
 2006 16:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758292AbWK0Pe0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 10:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758294AbWK0PeZ
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 10:34:25 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:19209 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S1758292AbWK0PeZ
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 10:34:25 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1GoiUF-0001Wb-L3; Mon, 27 Nov 2006 15:33:39 +0000
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org

Jon Smirl wrote:
> In the other thread we are discussing the conversion of Mozilla CVS to
> git format. This is something that has to be done but it is not the
> only issue. Without a native Windows port they won't even consider
> using git. There is also the risk that the features needed by Mozilla
> will be completed after they choose to use a different SCM.
> 
> Even if we implement all of the needed features git still needs to win
> the competition against the other possible choices. The last I heard
> the leading candiate is SVN/SVK.

Do we need to worry too much about taking over the world in one day?
Yes of course git is _the_ superior solution etc, but too many new users
at once is always painful.

I think you are more likely to win letting them convert over to SVN.
From there people naturally start using git mirrors from the SVN trunk.
 Cirtainly I have two projects which do not use git, one in CVS and one
in SVN.  I just svnimport that and work in git.  I am confident with
time the project will migrate, but I am happy other git users are happy
all without it being the tool of choice.

-apw
