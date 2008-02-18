From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 17 Feb 2008 16:37:09 -0800
Message-ID: <7vablzxfpm.fsf@gitster.siamese.dyndns.org>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
 <m38x1jbsjb.fsf@localhost.localdomain>
 <7vejbbz9x5.fsf@gitster.siamese.dyndns.org>
 <200802172301.30380.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bruno Ribas <ribas@c3sl.ufpr.br>,
	"J.H." <warthog9@kernel.org>, Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 01:38:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQu1N-0006KQ-2w
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 01:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064AbYBRAhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 19:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754143AbYBRAhX
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 19:37:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44514 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544AbYBRAhW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 19:37:22 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AE73E6BB6;
	Sun, 17 Feb 2008 19:37:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 D2B2A6BB4; Sun, 17 Feb 2008 19:37:11 -0500 (EST)
In-Reply-To: <200802172301.30380.jnareb@gmail.com> (Jakub Narebski's message
 of "Sun, 17 Feb 2008 23:01:29 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74210>

Jakub Narebski <jnareb@gmail.com> writes:

> 1. Currently tests check _built_ version:
>
>    # Test the binaries we have just built.  The tests are kept in
>    # t/ subdirectory and are run in trash subdirectory.
>
>    It would be nice if there were a switch which would allow to test
>    _installed_ (somewhere) version of git, to check for errors like
>    some script not finding some command etc.

If you are saying _in addition_ I would not stop you, but I am
not interested in testing installed version at all.  Testing
after installing is already too late.
