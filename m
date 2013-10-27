From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes: line
Date: Sun, 27 Oct 2013 17:30:42 +0100
Message-ID: <87zjpuznf1.fsf@thomasrast.ch>
References: <20131024122255.GI9378@mwanda> <20131024122512.GB9534@mwanda>
	<20131026181709.GB10488@kroah.com> <20131027013402.GA7146@leaf>
	<526CA7D4.1070904@alum.mit.edu> <20131027071407.GA11683@leaf>
	<874n83m8xv.fsf@linux-k42r.v.cablecom.net>
	<526CDC5C.40208@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Josh Triplett <josh@joshtriplett.org>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>,
	ksummit-2013-discuss@lists.linuxfoundation.org,
	ksummit-attendees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: linux-kernel-owner@vger.kernel.org Sun Oct 27 17:31:45 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1VaTFd-0001FR-Q0
	for glk-linux-kernel-3@plane.gmane.org; Sun, 27 Oct 2013 17:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754835Ab3J0Qbd (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 27 Oct 2013 12:31:33 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:52817 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754277Ab3J0Qbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Oct 2013 12:31:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 45DCD4D6534;
	Sun, 27 Oct 2013 17:31:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id xBexHN109EDJ; Sun, 27 Oct 2013 17:31:19 +0100 (CET)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 0B8F04D6414;
	Sun, 27 Oct 2013 17:31:18 +0100 (CET)
In-Reply-To: <526CDC5C.40208@googlemail.com> (Stefan Beller's message of "Sun,
	27 Oct 2013 10:26:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236804>

Stefan Beller <stefanbeller@googlemail.com> writes:

> I assembled an overview table, which plots the long options of 
> git commands by the short letters.
[...]
> (In case thunderbird messes it up, here it is again http://pastebin.com/raw.php?i=JBci2Krx)
>
> As you can see, f is always --force except for git-config, where it is --file

Woah!  Impressive work.  Did you autogenerate this?  If so, can we have
it as a small make target somewhere?  If not, can you send a patch to
put your table in Documentation somewhere?

-- 
Thomas Rast
tr@thomasrast.ch
