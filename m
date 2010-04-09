From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH] Makefile: Remove excess backslashes from sed
Date: Fri, 9 Apr 2010 10:33:57 -0400
Message-ID: <1C4F213E-9DF1-4184-B953-303DEDD69AC1@gernhardtsoftware.com>
References: <1270783330-35215-1-git-send-email-brian@gernhardtsoftware.com> <7vvdc12mmz.fsf@alter.siamese.dyndns.org> <20100409080256.GA12527@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 16:34:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0FHe-0008He-4A
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 16:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731Ab0DIOeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 10:34:00 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:60713 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178Ab0DIOeA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Apr 2010 10:34:00 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 1C8271FFC058; Fri,  9 Apr 2010 14:33:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.5.113] (unknown [64.134.102.129])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 50E6E1FFC056;
	Fri,  9 Apr 2010 14:33:55 +0000 (UTC)
In-Reply-To: <20100409080256.GA12527@gmail.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144435>


On Apr 9, 2010, at 4:02 AM, David Aguilar wrote:

> Is the \n@@STARTUP\n thing portable?

No.  OS X's sed renders it as 

  #!/usr/bin/pythonnimport os, sys; sys.path.insert(0, os.getenv("GITPYTHONLIB", "/usr/local/lib/python2.6/site-packages"))

So NAK for your patch.

~~ Brian