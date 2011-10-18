From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 2/2] daemon: report permission denied error to clients
Date: Tue, 18 Oct 2011 22:41:01 +0200
Message-ID: <20111018204101.GB2072@ecki>
References: <20111014211921.GB16429@sigill.intra.peff.net>
 <1318803076-4229-1-git-send-email-drizzd@aon.at>
 <1318803076-4229-2-git-send-email-drizzd@aon.at>
 <20111017020912.GB18536@sigill.intra.peff.net>
 <7vhb37l4ag.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 22:40:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGGSj-0005Ey-7B
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 22:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873Ab1JRUkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 16:40:32 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:42083 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752422Ab1JRUkb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 16:40:31 -0400
Received: from localhost (p5B22FE7E.dip.t-dialin.net [91.34.254.126])
	by bsmtp.bon.at (Postfix) with ESMTP id E28E91001C;
	Tue, 18 Oct 2011 22:40:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vhb37l4ag.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183903>

On Mon, Oct 17, 2011 at 02:03:03PM -0700, Junio C Hamano wrote:
> 
> I personally think this is going a bit too far, even for "informative"
> option, by allowing to fish for possible list of usernames. It would make
> it a tougher sell to later default to "informative", I am afraid.

I guess if permission is denied for access over git://, then nobody
can use the repository. So it's clearly a server side issue.

This change probably makes more sense for local access and over
ssh. I already have a similar patch brewing for that.

Clemens
