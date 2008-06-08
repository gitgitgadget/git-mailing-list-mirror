From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: git local repo export
Date: Sun, 8 Jun 2008 18:01:22 +0400
Message-ID: <20080608140122.GB7020@cvg>
References: <20080608134601.GA7020@cvg> <20080608135949.GE19777@albany.tokkee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sebastian Harl <sh@tokkee.org>
X-From: git-owner@vger.kernel.org Sun Jun 08 16:02:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5LTZ-0003oP-Kh
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 16:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbYFHOBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 10:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752758AbYFHOBh
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 10:01:37 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:44584 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbYFHOBg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 10:01:36 -0400
Received: by an-out-0708.google.com with SMTP id d40so415010and.103
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 07:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=Nbsg0LmIgQjB36Rmj2MekVL2lPVqcKDerO+o2uW697g=;
        b=t/6jvaEsmGYVmz0oYJ3eqVa6D0cHjLleyDtcfLdAiipJMAnnKiWbTPBbP/h9YFRYny
         jklJVL4clu1IF4yBIQI7UtvEjXuzSTnGqHK0UoXA1DK+8OpPlaDR91plqewBwa+XEywf
         Mq/dqETSyQqLJ9qbQgireTT3U1v7w85F7oIYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gagK79jURoStkZI3z0SM48PP8VCCkAY0vYIDhhwe+ia31Z5Xk+2uKbi21cQYpfVdMd
         bP5khBwfyjIC1kTsFF87gbQV4KM5S4RCy7RlWs323HAx6GEwh+ysQXx5aofBi7AUv0zN
         Kg+qYxm4SnsA2bETZ7L2fbGMQbEjetZHco/Xk=
Received: by 10.100.10.11 with SMTP id 11mr2297376anj.94.1212933695302;
        Sun, 08 Jun 2008 07:01:35 -0700 (PDT)
Received: from gorcunov ( [78.37.199.118])
        by mx.google.com with ESMTPS id d35sm17041180and.13.2008.06.08.07.01.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Jun 2008 07:01:34 -0700 (PDT)
Received: by gorcunov (Postfix, from userid 1000)
	id 929365EC; Sun,  8 Jun 2008 18:01:22 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <20080608135949.GE19777@albany.tokkee.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84268>

[Sebastian Harl - Sun, Jun 08, 2008 at 03:59:49PM +0200]
| Hi Cyrill,
| 
| On Sun, Jun 08, 2008 at 05:46:01PM +0400, Cyrill Gorcunov wrote:
| > could someone say me if there is a way to pack git repo in a single
| > file somehow?  I mean - sometime I have to move _whole_ git database
| > by some media without net access so I can't fetch it. Usually I just
| > create tar.gz for .git directory and copy it to some media then unpack
| > it in place where I need. But maybe there is some other more elegant
| > way exist to do the same?
| 
| Imho, that's a fairly elegant way to do that.
| 
| You might want to have a look at git-bundle as well. However, that's not
| suited for moving the whole repository, but rather to exchange patches
| without being able to use any network based protocols.
| 
| HTH,
| Sebastian
| 
| -- 
| Sebastian "tokkee" Harl +++ GnuPG-ID: 0x8501C7FC +++ http://tokkee.org/
| 
| Those who would give up Essential Liberty to purchase a little Temporary
| Safety, deserve neither Liberty nor Safety.         -- Benjamin Franklin
| 

Thanks a lot!

		- Cyrill -
