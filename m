From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: Does GIT has vc keywords like CVS/Subversion?
Date: Mon, 09 Oct 2006 10:44:10 +0800
Message-ID: <4529B77A.707@gmail.com>
References: <4b3406f0610081825y1d066579yba305b6540c8d0e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 09 04:45:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWl8j-0002cg-LX
	for gcvg-git@gmane.org; Mon, 09 Oct 2006 04:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbWJICo6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 22:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbWJICo6
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 22:44:58 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:20262 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751616AbWJICo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Oct 2006 22:44:58 -0400
Received: by py-out-1112.google.com with SMTP id n25so2134433pyg
        for <git@vger.kernel.org>; Sun, 08 Oct 2006 19:44:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=tOomFwIkvlOZO0InkhZY8GHbFkKbAbXtXxvUdihOVpxwK4Gv7BIb6LH6VrgBDup+FVKJw+4OH99dOewYmsbzoLFbjCwsTr6Jq0a08izwdPaQgNrhFzYOWGUpJeuuQhLBdOQ9oDFsGnvvakfvjzGPjYJOM23NJt5ggVoDbSFN9Hw=
Received: by 10.35.43.10 with SMTP id v10mr597071pyj;
        Sun, 08 Oct 2006 19:44:57 -0700 (PDT)
Received: from ?192.168.88.85? ( [221.122.47.70])
        by mx.google.com with ESMTP id n80sm2995541pye.2006.10.08.19.44.55;
        Sun, 08 Oct 2006 19:44:56 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Dongsheng Song <dongsheng.song@gmail.com>
In-Reply-To: <4b3406f0610081825y1d066579yba305b6540c8d0e9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28558>

Dongsheng Song wrote:
> I want to know whether there is a plan to add this feature, or GIT
> doesn't require it at all.
> 
> Keywords like LastChangedDate, LastChangedRevision, LastChangedBy, Id
> are useful for version control.
> 
I almost mistake I sent my last question twice:-), maybe we need more FAQs
like this:
Q: Does GIT [some feature] like [some vcs] ?
A: No. Because ...

IMHO, I don't think keyword substitution is a good idea, as it will confuse
the external diff/merge tools.
