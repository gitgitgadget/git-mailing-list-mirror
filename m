From: Michael Gaffney <mr.gaffo@gmail.com>
Subject: Smart HTTP Protocol
Date: Fri, 09 Oct 2009 12:58:56 -0500
Message-ID: <4ACF79E0.5000606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 20:00:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwJlv-0006fT-Ny
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 20:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759124AbZJISAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 14:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758978AbZJISAs
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 14:00:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:37582 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbZJISAs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 14:00:48 -0400
Received: by fg-out-1718.google.com with SMTP id 22so390715fge.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 10:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=mf4IF0nGwMzigs/GnmlmxFoXtN7K9/CFdadih4r5hOM=;
        b=rOd/KK2mgvbN35ps8jYEtGus4W59tMd5DsWLXPd0m9Oy1TkTUiehh0ZBQd0Id5Iizm
         u3Cr/laS/oNviXBWjsqxfMLcZBo30WCxCa823nO9/lOdmWg53yD08PnQthiLwfjwq4Gq
         g75zy8M7GgU5U2nwze70myZtkDUAarRQNtQZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=azqO2tGnoE01c36YDTelDVuxFZJFTwlDIIf9Lv8geOfjnUVWpIk71lGVGL1whATzTg
         1oNGYGArIWTS1xSWxHWYXP0d3s32GLMsuFG8HZTEvnzl5YQD2O4iZYNvsg98lu+Mmdlo
         ygOFBGiygdD5orenDUVQnJfY4BbiNzN1X2ucQ=
Received: by 10.86.211.38 with SMTP id j38mr2672696fgg.26.1255111140174;
        Fri, 09 Oct 2009 10:59:00 -0700 (PDT)
Received: from ?192.168.132.157? ([66.236.120.2])
        by mx.google.com with ESMTPS id l12sm111629fgb.26.2009.10.09.10.58.58
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 10:58:59 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129826>

What ended up being the status on this? From the last I saw, the 
protocol and the fallover smart to dumb had all been worked out. It was 
just that people were waiting on an implementation server side of the 
protocol before the client was implemented?

-Mike
