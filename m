From: Brian Dessent <brian@dessent.net>
Subject: Re: [PATCH 20/40] Windows: A rudimentary poll() emulation.
Date: Fri, 29 Feb 2008 15:17:44 -0800
Organization: My own little world...
Message-ID: <47C89298.F6F8253D@dessent.net>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
		 <200802282149.36748.johannes.sixt@telecom.at>
		 <5d46db230802282019o21f9ed9fo75fed8744625289e@mail.gmail.com>
		 <200802292216.25014.johannes.sixt@telecom.at> <5d46db230802291347u5f286dadw6b532abf82c0cff7@mail.gmail.com>
Reply-To: Git Mailing List <git@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>
To: Govind Salinas <blix@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 00:18:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVEUp-00077t-Lr
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 00:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760402AbYB2XRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 18:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760227AbYB2XRu
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 18:17:50 -0500
Received: from dessent.net ([69.60.119.225]:51200 "EHLO dessent.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760163AbYB2XRt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 18:17:49 -0500
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.50)
	id 1JVEU6-0004KJ-3h; Fri, 29 Feb 2008 23:17:46 +0000
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75589>

Govind Salinas wrote:

> http://msdn2.microsoft.com/en-us/library/aa365603(VS.85).aspx
> 
> which suggests you can pass these handles to ReadFile and if you include an
> OVERLAPPED struct in the call, it will return an event handle to wait on which
> you can then use to wait.

That only applies if the handle has been opened with
FILE_FLAG_OVERLAPPED.

Brian
