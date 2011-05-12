From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCHv1] git-p4: test harness directory handling tidyup
Date: Thu, 12 May 2011 07:29:37 -0400
Message-ID: <20110512112937.GA3128@arf.padd.com>
References: <1305177299-27130-1-git-send-email-luke@diamand.org>
 <1305177299-27130-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu May 12 13:29:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKU5V-0000HP-9n
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 13:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651Ab1ELL3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 07:29:44 -0400
Received: from honk.padd.com ([74.3.171.149]:41731 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752569Ab1ELL3n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 07:29:43 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id B121B21A4;
	Thu, 12 May 2011 04:29:41 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 455065AA98; Thu, 12 May 2011 07:29:37 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1305177299-27130-2-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173461>

luke@diamand.org wrote on Thu, 12 May 2011 06:14 +0100:
> The git-p4 test harness relied a lot on cd'ing to the target directory
> and then cd'ing back explicitly. That caused problems if the test failed
> partway through. i.e.
>   cd $git && stuff && cd "$TRASH_DIRECTORY"
> 
> Instead, use:
>   (cd $git && stuff)
> 
> Signed-off-by: Luke Diamand <luke@diamand.org>
> Suggested-by: Junio C Hamano <gitster@pobox.com>

I'm glad that Junio noticed and that you took the time to fix
this.  It was indeed a problem.

Acked-by: Pete Wyckoff <pw@padd.com>
