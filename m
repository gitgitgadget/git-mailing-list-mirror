From: Brian Koehmstedt <bkoehm@gmail.com>
Subject: Re: git-svn: Fetch svn branches only and have git recognize them as branches?
Date: Mon, 16 Mar 2015 14:27:25 +0000 (UTC)
Message-ID: <loom.20150316T152127-59@post.gmane.org>
References: <CAMMCKnc9AKjuwQ_RNxD_g3tn=xFQkbO1i-U=rP2VLWPi7qizGA@mail.gmail.com> <xmqq385924j3.fsf@gitster.dls.corp.google.com> <loom.20150313T004740-11@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 16 15:30:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXW1m-0005Z1-Mw
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 15:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933513AbbCPO2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 10:28:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:51273 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933508AbbCPO2C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 10:28:02 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YXVzm-0004KH-2n
	for git@vger.kernel.org; Mon, 16 Mar 2015 15:27:54 +0100
Received: from 68-186-62-85.dhcp.mdfd.or.charter.com ([68.186.62.85])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Mar 2015 15:27:54 +0100
Received: from bkoehm by 68-186-62-85.dhcp.mdfd.or.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Mar 2015 15:27:54 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 68.186.62.85 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:36.0) Gecko/20100101 Firefox/36.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265559>

Just to close the loop on this, I wasn't able to get git-svn to deal with
this remote repository the way I wanted, so what I did is write some perl
scripts to mirror the remote subversion repository locally and then use
git-svn on that local "fixed" svn mirror.

The hard part was mirroring the svn repo locally, primarily because the
remote subversion server was denying access to the root.  Also complicating
matters was the dump files weren't completely loading properly.

In case anyone else is needing to do this, I've published my perl script
code that overcame all these issues.  Here it is:
https://github.com/ucidentity/failsafe-svn-sync
