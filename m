From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] fix "stg float -s FILE" for FILE != "-"
Date: Fri, 17 Jul 2009 13:45:07 +0100
Organization: ARM Ltd
Message-ID: <1247834707.6313.5.camel@pc1117.cambridge.arm.com>
References: <20090717093504.13718.78957.stgit@jazzy.zrh.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hannes Eder <heder@google.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 14:45:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRmoV-0008JJ-Pc
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 14:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934525AbZGQMpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 08:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934516AbZGQMpN
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 08:45:13 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:39614 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934503AbZGQMpM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jul 2009 08:45:12 -0400
Received: from cam-owa1.Emea.Arm.com (cam-owa1.emea.arm.com [10.1.255.62])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n6HCfDZm029225;
	Fri, 17 Jul 2009 13:41:13 +0100 (BST)
Received: from [10.1.68.81] ([10.1.255.212]) by cam-owa1.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Fri, 17 Jul 2009 13:45:08 +0100
In-Reply-To: <20090717093504.13718.78957.stgit@jazzy.zrh.corp.google.com>
X-Mailer: Evolution 2.22.3.1 
X-OriginalArrivalTime: 17 Jul 2009 12:45:08.0278 (UTC) FILETIME=[6A7F4D60:01CA06DC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123461>

On Fri, 2009-07-17 at 11:35 +0200, Hannes Eder wrote:
> The commit:
> 
>   commit 5a1bab1ad60688471e100e310c58c7e60d18cd80
>   Author: Catalin Marinas <catalin.marinas@arm.com>
>   Date:   Thu Apr 9 23:40:59 2009 +0300
> 
>       Convert "float" to the lib infrastructure
> 
> introduces a bug in "stg float -s FILE" when FILE is not equal to "-".
> This patches fixes this issue.
> 
> Signed-off-by: Hannes Eder <heder@google.com>

Applied, thanks.

-- 
Catalin
