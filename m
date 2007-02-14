From: Bill Lear <rael@zopyra.com>
Subject: Re: [ANNOUNCE] GIT 1.5.0
Date: Wed, 14 Feb 2007 08:57:23 -0600
Message-ID: <17875.9043.217255.863200@lisa.zopyra.com>
References: <7vlkj1v3av.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 15:57:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHLZo-0006FK-8r
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 15:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbXBNO5f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 09:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbXBNO5f
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 09:57:35 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60899 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932322AbXBNO5e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 09:57:34 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1EEvSt19632;
	Wed, 14 Feb 2007 08:57:28 -0600
In-Reply-To: <7vlkj1v3av.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39655>

On Tuesday, February 13, 2007 at 19:14:16 (-0800) Junio C Hamano writes:
>The latest feature release GIT 1.5.0 is available at the usual places:
>...

I do think worth pointing out that, quite significantly, you can now
use git-daemon to push changes into a repo, something very handy for
private networks.

This is enabled by passing the --enable=receive-pack to the
git-daemon (usually in the [x]?inetd configuration).

This has the benefit of:

  1) More efficient git transport for both pushes and pulls.

  2) A less ugly URL to use: git://server/repo, instead of, say,
     ssh+git://server/path/to/repos/repo.

  3) Ability to easily move your repo without changing the URL in each
     client, by changing the URL in the git-daemon config file
     (xinetd) --- say, if you want to move your repo to a striped
     disk, or similar.


Bill
