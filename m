From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: Newbie question
Date: Sun, 19 Sep 2010 19:59:59 -0400
Message-ID: <04E0C626-C16F-43A9-9AB7-41760B682F13@kellerfarm.com>
References: <1284940287810-5548737.post@n2.nabble.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 20 02:00:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxToQ-00028r-5c
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 02:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815Ab0ITAAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 20:00:33 -0400
Received: from sanjose.tchmachines.com ([208.76.86.38]:38905 "EHLO
	leia.tchmachines.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754259Ab0ITAAc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Sep 2010 20:00:32 -0400
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Sep 2010 20:00:32 EDT
Received: from host-210-214.meilvil.clients.pavlovmedia.com ([96.63.210.214] helo=[192.168.0.102])
	by leia.tchmachines.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <andrew@kellerfarm.com>)
	id 1OxTnz-0005Lz-Bs
	for git@vger.kernel.org; Sun, 19 Sep 2010 20:00:23 -0400
In-Reply-To: <1284940287810-5548737.post@n2.nabble.com>
X-Mailer: Apple Mail (2.1081)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - leia.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kellerfarm.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156539>

On Sep 19, 2010, at 7:51 PM, kinley wrote:

> Hi,
> I am new to question. Please help me with this.
> I copied an already existing project from a remote server using scp to my
> local directory.
> The contents of this directory are
>   branches
>   config
>   description
>   HEAD
>   hooks
>   info
>   objects
>   ref

This directory listing is what you would expect if you were looking at the repository itself.  To access your files in the repository, you want to create a non-bare (normal) clone.

git clone path-to-git-repo

On a side note, git can clone over ssh, so you don't need to use scp to copy a project over the network.  If your intent is to create a clone of a remote project on your computer, then cloning over ssh generally takes fewer commands than doing the copy manually first.

~ Andrew Keller
