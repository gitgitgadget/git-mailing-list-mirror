From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCHv2 2/2] git p4: add support for 'p4 move' in P4Submit
Date: Mon, 5 Nov 2012 17:37:15 +0000 (UTC)
Message-ID: <loom.20121105T183530-627@post.gmane.org>
References: <1342135740-30290-1-git-send-email-pw@padd.com> <1342135740-30290-3-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 18:37:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVQcL-0004Uv-5B
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 18:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521Ab2KERhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 12:37:32 -0500
Received: from plane.gmane.org ([80.91.229.3]:53862 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753768Ab2KERhb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 12:37:31 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TVQcC-0004P3-HX
	for git@vger.kernel.org; Mon, 05 Nov 2012 18:37:36 +0100
Received: from 57.79.130.182 ([57.79.130.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Nov 2012 18:37:36 +0100
Received: from vitor.hda by 57.79.130.182 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Nov 2012 18:37:36 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 57.79.130.182 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20100101 Firefox/16.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209077>

Pete Wyckoff <pw <at> padd.com> writes:

> 
> From: Gary Gibbons <ggibbons <at> perforce.com>
> 
> For -M option (detectRenames) in P4Submit, use 'p4 move' rather
> than 'p4 integrate'.  Check Perforce server for exisitence of
> 'p4 move' and use it if present, otherwise revert to 'p4 integrate'.
> 

Hi Pete,

I've just been hit by a situation where this command is available but is
disabled in the server. I don't know what is the best approach to avoid
this issue.

Thanks,
Vitor
