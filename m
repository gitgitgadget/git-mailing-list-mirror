From: Junio C Hamano <gitster@pobox.com>
Subject: Re: policy and mechanism for less-connected clients
Date: Wed, 25 Jun 2008 22:26:35 -0700
Message-ID: <7vlk0su5pw.fsf@gitster.siamese.dyndns.org>
References: <20080626052310.GC8610@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Jeske <jeske@willowmail.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 26 07:27:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBk1E-0008C4-JF
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 07:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbYFZF0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 01:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752209AbYFZF0n
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 01:26:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54265 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbYFZF0n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 01:26:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 32E8EE4F1;
	Thu, 26 Jun 2008 01:26:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 996C3E4EE; Thu, 26 Jun 2008 01:26:38 -0400 (EDT)
In-Reply-To: <20080626052310.GC8610@mit.edu> (Theodore Tso's message of "Thu,
 26 Jun 2008 01:23:10 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 75A8ED5A-4340-11DD-B184-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86394>

Theodore Tso <tytso@mit.edu> writes:

> On Wed, Jun 25, 2008 at 11:03:02PM -0000, David Jeske wrote:
>> I don't want to replicate CVS behavior, just the workflow.
>
> It's not clear exactly what you want.  If you want the CVS workflow
> (with all of its downsides), then just use "git pull; hack hack hack;
> git push" all on the master branch.

Eh, my point was more about "to preserve CVS workflow, fetch+rebase+push
is much closer than pull+push"...
