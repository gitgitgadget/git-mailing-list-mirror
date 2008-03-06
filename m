From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Add horizontal scrollbar to the diff view
Date: Thu, 6 Mar 2008 21:30:42 +1100
Message-ID: <18383.51154.695501.543720@cargo.ozlabs.ibm.com>
References: <20080305225123.GA8485@localdomain>
	<7vy78wgyu1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: kaitanie@cc.helsinki.fi, newsletter@dirk.my1.cc,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 11:32:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXDOA-0003j2-Lf
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 11:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbYCFKbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 05:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbYCFKbM
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 05:31:12 -0500
Received: from ozlabs.org ([203.10.76.45]:35812 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034AbYCFKbL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 05:31:11 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 3D324DDEFA; Thu,  6 Mar 2008 21:30:59 +1100 (EST)
In-Reply-To: <7vy78wgyu1.fsf@gitster.siamese.dyndns.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76361>

Junio C Hamano writes:

> An obvious solution is to show the scrollbar on-demand (i.e. when the
> lines are overlong), but I do not talk Tcl/Tk and do not know if you can
> do that easily.

I don't know of any extremely easy way to do it; it's certainly
possible, but I think I would have to calculate the length of each
line as it is put in, so as to get the maximum, and then have a
handler for when the pane is resized, and pack and unpack the
scrollbar as necessary.

I think it's reasonable to have the scroll bar there always.  I think
that pane could look better using the grid geometry manager (instead
of pack), but that can be a separate patch.

Paul.
