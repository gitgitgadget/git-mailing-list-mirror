From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: removal of "percent done" messages from git pull
Date: Mon, 19 Feb 2007 13:11:21 +0000
Message-ID: <tnxr6sm5m2u.fsf@arm.com>
References: <45D5E06B.6020706@lightspeed.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Larry Streepy <larry@lightspeed.com>
X-From: git-owner@vger.kernel.org Mon Feb 19 14:12:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ8JE-00081v-Qc
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 14:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbXBSNLw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 08:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbXBSNLw
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 08:11:52 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:58153 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932211AbXBSNLw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Feb 2007 08:11:52 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id l1JDBNYo001593;
	Mon, 19 Feb 2007 13:11:27 GMT
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Mon, 19 Feb 2007 13:12:22 +0000
In-Reply-To: <45D5E06B.6020706@lightspeed.com> (Larry Streepy's message of
 "Fri, 16 Feb 2007 10:48:43 -0600")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 19 Feb 2007 13:12:23.0049 (UTC) FILETIME=[97CB4F90:01C75427]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40124>

Larry Streepy <larry@lightspeed.com> wrote:
> I run a nightly script to build and test our product.  I capture all
> the output and email it to interested parties.  One very annoying
> thing is the "percent done" messages that come out of git pull.  It
> results in log files that look like this:
[...]
> I have found no way to make these messages go away.  When running in a
> "batch" mode, IMHO, interactive messages like these should not be
> emitted. At least there should be a switch to suppress them.

Or (as done in StGIT for some messages), only print those interactive
messages when stdout is a tty, i.e. "if (isatty(1))".

-- 
Catalin
