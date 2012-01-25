From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git version not changed after installing new version
Date: Wed, 25 Jan 2012 18:03:18 +0100
Message-ID: <8739b3k949.fsf@thomas.inf.ethz.ch>
References: <loom.20120125T173801-500@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: freefly <free.fly@live.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 18:03:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rq6Fr-0005rq-0N
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 18:03:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756228Ab2AYRDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 12:03:22 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:49005 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756111Ab2AYRDV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 12:03:21 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 25 Jan
 2012 18:03:18 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 25 Jan
 2012 18:03:19 +0100
In-Reply-To: <loom.20120125T173801-500@post.gmane.org> (freefly's message of
	"Wed, 25 Jan 2012 16:45:50 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189113>

freefly <free.fly@live.com> writes:

> Hi all,
>     I am new to Mac OS X lion and I had a previous installation of XCODE 4.2
> on my mac mini. It has a git version 1.7.5.4. I installed a new version 1.7.8.4.
> and updated the Path variables by running the script comes with the 
> package as well. but when I type "git --version" in the terminal 
> I get 1.7.5.4. Can anyone tell me what is going wrong ?

Enter 'which git' in a terminal.  The 'which' utility looks up which
executable from $PATH will be run if you use 'git' (in this case) as a
command word, i.e., without specifying its path.

This should point to your newly installed git.  It probably doesn't, and
you can compare it and your $PATH (try: 'echo "$PATH"' in a terminal) to
see why.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
