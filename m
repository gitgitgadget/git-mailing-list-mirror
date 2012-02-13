From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [RFC PATCH 0/3] git-p4: move to toplevel
Date: Mon, 13 Feb 2012 21:37:10 +0100
Message-ID: <20120213203709.GA31671@ecki>
References: <1329070423-23761-1-git-send-email-pw@padd.com>
 <7vehtyec64.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 21:45:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx2mJ-0005YX-AM
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 21:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758087Ab2BMUpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 15:45:35 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:41963 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758118Ab2BMUpb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 15:45:31 -0500
Received: from localhost (p5B22E0DA.dip.t-dialin.net [91.34.224.218])
	by bsmtp.bon.at (Postfix) with ESMTP id A604C2C4002;
	Mon, 13 Feb 2012 21:46:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vehtyec64.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190666>

On Mon, Feb 13, 2012 at 12:00:35PM -0800, Junio C Hamano wrote:
> Pete Wyckoff <pw@padd.com> writes:
> 
> > Users install git-p4 currently by copying the git-p4 script from
> > contrib/fast-import into a local or personal bin directory, and
> > setting up an alias for "git p4" to invoke it.
> 
> Erm,... do you really need the alias if you add git-p4 in a directory on
> your $PATH?

With recent git versions, this has stopped working. I was told it is a
feature that git only looks in exec-path now. Maybe I should not have
believed that?

Clemens
