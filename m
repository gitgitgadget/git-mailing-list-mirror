From: Russ Brown <pickscrape@gmail.com>
Subject: Re: git-svn eliminating master
Date: Fri, 28 Sep 2007 17:34:17 -0500
Message-ID: <46FD8169.6040505@gmail.com>
References: <46FD5DAF.7030204@gmail.com> <7vlkaqo49n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 00:34:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbOPq-0004ub-94
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 00:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754675AbXI1We0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 18:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753790AbXI1We0
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 18:34:26 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:3644 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbXI1WeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 18:34:25 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2516721wxd
        for <git@vger.kernel.org>; Fri, 28 Sep 2007 15:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=ti/nzo9P208GQh2vwUVqcM/5bWYlD5lDnVll+5a7Ahw=;
        b=Dvlf9BD+sFyN5H9Ab6+xGld5y2SLHByVBYmPOY7xh4fEdQD5saQkFd8Y/GEhv06uP6zeb2GH3o+9mnYogSyc3DxKFzSuq3HBhMWB1gPzdGC0wTKixgu0xPxE3taFxIh7Tnfer2kqzlk79EyUq/9Avq+PWQQuxsoWbQR4oqDm6ZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=MVVpI8OBXKDHehhcQ2JEjFA8HmnxDvj6PH0Em5ciTWWrlXqcZwVAq07S+Uh5dRAjYOGVGyRCQnc+KLUfWi4l90W+c/6Qg19/zaAXKL43NEN/DxXj29rr4Vj6RpIzXVm1hg5Sq2TlJeCyTb5wykUfXz/1ErYeJS8JDJx3wV2ZkwY=
Received: by 10.70.89.1 with SMTP id m1mr4479262wxb.1191018864617;
        Fri, 28 Sep 2007 15:34:24 -0700 (PDT)
Received: from ?192.168.0.100? ( [71.252.196.170])
        by mx.google.com with ESMTPS id b3sm4054384ana.2007.09.28.15.34.20
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 28 Sep 2007 15:34:23 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070807)
In-Reply-To: <7vlkaqo49n.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59428>

Junio C Hamano wrote:
> Russ Brown <pickscrape@gmail.com> writes:
> 
>> So I've been using git-svn for a while, and just decided to try
>> publishing my repo via gitweb so I can experiment with showing others my
>> local branches before I dcommit them to the subversion repository (i.e.
>> allowing code review prior to commit).
>>
>> It's working pretty nicely: the only problem I have is the master
>> branch. I don't use master at all, and I'm willing to be that a lot of
>> other git-svn users don't either. I take all of my branches from either
>> trunk or one of the other upstream svn server branches.
>>
>> The problem is gitweb appears to show the master branch by default,
>> while I'd rather show trunk by default.
> 
> I think gitweb shows wherever HEAD points at.  Update the file
> on the server and see if it helps.

Nice tip. I've updated that now. I'll know if it's worked once trunk
gets committed to again: I've rebased master against it so both
currently point at the same commit.

-- 

Russ
