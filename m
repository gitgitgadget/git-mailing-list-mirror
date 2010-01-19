From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: git describe --contains
Date: Tue, 19 Jan 2010 07:11:50 +0000 (UTC)
Message-ID: <loom.20100119T080907-579@post.gmane.org>
References: <43d8ce651001181537w667f71b7te7fac56b4f562c30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 19 08:15:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX8J5-0004mg-Pd
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 08:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448Ab0ASHPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 02:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754432Ab0ASHPN
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 02:15:13 -0500
Received: from lo.gmane.org ([80.91.229.12]:33481 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754418Ab0ASHPM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 02:15:12 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NX8Iq-0004ja-Md
	for git@vger.kernel.org; Tue, 19 Jan 2010 08:15:05 +0100
Received: from 203.110.246.230 ([203.110.246.230])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Jan 2010 08:15:04 +0100
Received: from artagnon by 203.110.246.230 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Jan 2010 08:15:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 203.110.246.230 (Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/532.8 (KHTML, like Gecko) Chrome/4.0.295.0 Safari/532.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137438>

> Doing:   git describe --contains SHA

The problem resides in builtin-describe.c:377. It uses cmd_name_rev from builtin-
name-rev.c. I'm attempting to rewrite this, and have a describe_contains() - 
Hopefully, I'll get a patch out by the end of the day.
