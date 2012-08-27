From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: exporting a .git file ?
Date: Mon, 27 Aug 2012 18:53:16 +0400
Message-ID: <20120827185316.a18222bf90216d87dea9f23a@domain007.com>
References: <CANkmNDc7VP4QiocxuB7JMuQyZy5nDT=ertow_ib2Hri_=XRMOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 16:53:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T60gx-0006Kg-1p
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 16:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597Ab2H0OxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 10:53:21 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:41595 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab2H0OxU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 10:53:20 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id q7RErGU9014145;
	Mon, 27 Aug 2012 18:53:17 +0400
In-Reply-To: <CANkmNDc7VP4QiocxuB7JMuQyZy5nDT=ertow_ib2Hri_=XRMOA@mail.gmail.com>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204348>

On Mon, 27 Aug 2012 15:32:40 +0100
Aaron Gray <aaronngray.lists@gmail.com> wrote:

> Is there anyway to get my git repository as a single file ?
Depends on what you really need.

If you need to export the repository *history* of one or more
references (branches or tags), use `git bundle` to create a
specially-formatted file which can be imported using Git on another
machine.

If you need to just export the snapshot of the files maintained in the
repository at the specified commit, use `git export`.
