From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC] Patches exchange is bad?
Date: Thu, 18 Aug 2005 14:41:06 +0100
Message-ID: <tnx7jej2wi5.fsf@arm.com>
References: <20050818133411.15529.qmail@web26306.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 15:43:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5ken-0007FO-Bg
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 15:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVHRNlv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 09:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbVHRNlv
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 09:41:51 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:32206 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S932226AbVHRNlv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 09:41:51 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j7IDekOU028186;
	Thu, 18 Aug 2005 14:40:46 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id OAA26743;
	Thu, 18 Aug 2005 14:41:39 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 18 Aug 2005 14:41:38 +0100
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20050818133411.15529.qmail@web26306.mail.ukl.yahoo.com> (Marco
 Costalba's message of "Thu, 18 Aug 2005 06:34:10 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 18 Aug 2005 13:41:39.0024 (UTC) FILETIME=[8F3D5500:01C5A3FA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Marco Costalba <mcostalba@yahoo.it> wrote:
> I was thinking at two different kind of workflow, one were you are
> tracking a remote repository ( Linux kernel project like ) and one
> as single developer with both stable and develop lines ( qgit or
> StGIT ;-) projects like ).

There is another option for the 2nd case, where you maintain both both
stable and development. You could use 'git push' to the stable
repository (actually, more like a mirror) and make the
StGIT-maintained repository track the changes from the stable one and
just update it with 'stg pull'

-- 
Catalin
