From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] handle concurrent pruning of packed objects
Date: Fri, 02 Jun 2006 09:03:18 -0700
Message-ID: <7vodxbbl4p.fsf@assigned-by-dhcp.cox.net>
References: <20060602153223.GA4223@coredump.intra.peff.net>
	<7vwtbzblkf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 18:03:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmC7P-0008MZ-DA
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 18:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWFBQDV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 12:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWFBQDU
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 12:03:20 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:13743 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932420AbWFBQDU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 12:03:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060602160319.HDHV24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Jun 2006 12:03:19 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <7vwtbzblkf.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 02 Jun 2006 08:53:52 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21167>

Junio C Hamano <junkio@cox.net> writes:

> Also I suspect this might have funny interaction with the case
> where there are hand-added packs (see how verify-pack does it).
> We do not silently "fix" missing object problems we discover
> there.

The last sentence should read 'We do not want to silently...'.
Sorry.
