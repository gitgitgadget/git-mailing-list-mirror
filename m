From: Bill Lear <rael@zopyra.com>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Mon, 19 Feb 2007 12:55:10 -0600
Message-ID: <17881.62094.56975.799862@lisa.zopyra.com>
References: <200702191839.05784.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 19 19:55:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJDfd-0001EZ-Hu
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 19:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbXBSSzT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 13:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbXBSSzS
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 13:55:18 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61163 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932486AbXBSSzR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 13:55:17 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1JItCg12571;
	Mon, 19 Feb 2007 12:55:12 -0600
In-Reply-To: <200702191839.05784.andyparkins@gmail.com>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40138>

On Monday, February 19, 2007 at 18:39:05 (+0000) Andy Parkins writes:
>...
>+#define PATH_REMOTES             "remotes/"
>+#define STRLEN_PATH_REMOTES      8
>...

Would this be less error-prone, and just as efficient?:

#define PATH_REMOTES "remotes/"
#define LIT_STRLEN(S) ((sizeof(S) / sizeof(S[0])) -1)
#define STRLEN_PATH_REMOTES LIT_STRLEN(PATH_REMOTES)


Bill
