From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Intermittent failures in t9119
Date: Mon, 6 Dec 2010 11:10:55 -0800
Message-ID: <20101206191055.GA9597@dcvr.yhbt.net>
References: <7vmxoml1p7.fsf@alter.siamese.dyndns.org> <7vy684t0mt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David D. Kilzer" <ddkilzer@kilzer.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 20:11:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPgSi-0006z1-Em
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 20:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237Ab0LFTKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 14:10:55 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:37287 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671Ab0LFTKz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 14:10:55 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id A71CB1F97C;
	Mon,  6 Dec 2010 19:10:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vy684t0mt.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163015>

Junio C Hamano <gitster@pobox.com> wrote:
>  (2) Nobody uses the value from "Text Last Updated" field in practice, so
>      that bug has been unnoticed so far;
> 
>  (3) And it is not worth fixing it ;-)
> 
> For now, I would suggest fixing the failing test to ignore the "Text Last
> Updated" field while comparing, and if somebody is inclined to, we would
> update the code to match what "svn info" does.

Agreed on both points.  I consider "git svn log" and "git svn info" to
be reasonable approximations of svn behavior, not exact replicas.
Exactly matching would be extremely difficult given variations between
different svn versions, and also svn requiring network access while
git svn does not.

-- 
Eric Wong
