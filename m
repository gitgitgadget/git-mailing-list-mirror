From: Junio C Hamano <gitster@pobox.com>
Subject: Re: reverting initial commit
Date: Wed, 25 Mar 2009 11:26:27 -0700
Message-ID: <7v1vsl4fxo.fsf@gitster.siamese.dyndns.org>
References: <49CA7428.70400@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Wed Mar 25 19:28:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmXps-0004yA-6x
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 19:28:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758662AbZCYS0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 14:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757858AbZCYS0e
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 14:26:34 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50139 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756517AbZCYS0d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 14:26:33 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 56F7A9350;
	Wed, 25 Mar 2009 14:26:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BD272934F; Wed,
 25 Mar 2009 14:26:28 -0400 (EDT)
In-Reply-To: <49CA7428.70400@obry.net> (Pascal Obry's message of "Wed, 25 Mar
 2009 19:12:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7686CD22-196A-11DE-AAF1-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114639>

Pascal Obry <pascal@obry.net> writes:

> Starting a new project I create a new repo and added some files for the
> initial revision of the project, something like:
>
> mkdir repo.git
> cd repo.git
> git init
> touch file
> git add file
> git ci -m "initial revision"
>
> Now one file was not meant to be committed, I wanted to revert this commit:

That's not even an revert.  Can't you simply amend it away?

	$ git rm not-this-file
        $ git commit --amend
