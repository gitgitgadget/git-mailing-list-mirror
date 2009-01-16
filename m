From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'mail' link on http://repo.or.cz/w/git.git no workee?
Date: Thu, 15 Jan 2009 17:59:54 -0800
Message-ID: <7vmydsovs5.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901151651460.3586@pacific.mpi-cbg.de>
 <20090116015439.GF12275@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jan 16 03:02:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNe2C-0005Jx-Hm
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 03:02:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759685AbZAPCAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 21:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759912AbZAPCAI
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 21:00:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33868 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935756AbZAPCAF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 21:00:05 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2D2471C9C7;
	Thu, 15 Jan 2009 21:00:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D57EE1CA0B; Thu,
 15 Jan 2009 20:59:56 -0500 (EST)
In-Reply-To: <20090116015439.GF12275@machine.or.cz> (Petr Baudis's message of
 "Fri, 16 Jan 2009 02:54:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 63739B68-E371-11DD-9F5A-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105906>

Petr Baudis <pasky@suse.cz> writes:

>> That is, it links to marc (not gmane?) but finds no matches...
>
>   what mailing list post should it point to?

I think Dscho's point is that you shouldn't be generating these links that
lead to nowhere ;-).

It would really be nice if we can maintain an exterenal database that
links mailing list discussion threads and individual commits, and have
gitweb and other visualization tools to make use of that information.

I do not care what storage mechanism that external database uses.  It
could use notes or it could just be a BDB that can be indexed with commit
object names.
