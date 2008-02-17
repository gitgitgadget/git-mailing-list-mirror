From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Issues around C rebase--interactive
Date: Sun, 17 Feb 2008 11:42:00 -0800
Message-ID: <7vablzz7xz.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802171347060.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Feb 17 20:43:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQpPs-0008Sp-PQ
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 20:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327AbYBQTmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 14:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753007AbYBQTmK
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 14:42:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52935 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbYBQTmI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 14:42:08 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D1B8F495B;
	Sun, 17 Feb 2008 14:42:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 5586A495A; Sun, 17 Feb 2008 14:42:03 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802171347060.5816@iabervon.org> (Daniel
 Barkalow's message of "Sun, 17 Feb 2008 14:15:48 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74174>

Daniel Barkalow <barkalow@iabervon.org> writes:

> ... I think it would be good 
> to have a "git abort" that would reset a conflicted merge, abort a rebase, 

Yes, we would want a consolidated "git sequencer" that can be
reused by "am" and "rebase".  The command set to the sequencer
would be a slight superset to what rebase--interactive uses in
its todo file, I would imagine.  To support "am" (and non-merge
version of "rebase") it would add "apply <filename>" command.
