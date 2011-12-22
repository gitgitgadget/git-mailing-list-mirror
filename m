From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Warning from AV software about kill.exe
Date: Thu, 22 Dec 2011 09:45:37 +0100
Message-ID: <87mxalkn9q.fsf@thomas.inf.ethz.ch>
References: <4EF2E08C.3050502@icefield.yk.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Erik Blake <erik@icefield.yk.ca>
X-From: git-owner@vger.kernel.org Thu Dec 22 09:45:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdeHc-00031m-BN
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 09:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780Ab1LVIpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Dec 2011 03:45:45 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:6386 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753811Ab1LVIpo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2011 03:45:44 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 22 Dec
 2011 09:45:39 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 22 Dec
 2011 09:45:41 +0100
In-Reply-To: <4EF2E08C.3050502@icefield.yk.ca> (Erik Blake's message of "Thu,
	22 Dec 2011 08:47:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187605>

Erik Blake <erik@icefield.yk.ca> writes:

> I'm running git under Win7 64. As I selected "Repository|Visualize all
> branch history" in the git gui, my AV software (Trustport) trapped the
> bin\kill.exe program for "trying to modify system global settings
> (time, timezone, registry quota, etc.)"
>
> Does anyone know the details of this process and what it's function
> is? First time I've seen it, though I'm a relatively new user.

'kill' is a standard unix utility that sends signals to processes, in
particular signals that cause the processes to exit or be killed
forcibly by the kernel, hence the name.  (I don't know how the windows
equivalent works under the hood, but presumably it's something similar.)

git-gui and gitk use kill to terminate background worker processes that
are no longer needed because you closed the window their output would
have been displayed in, etc.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
