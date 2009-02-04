From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Confused about diff-tree --cc output
Date: Wed, 04 Feb 2009 13:56:19 -0800
Message-ID: <7vk585n9x8.fsf@gitster.siamese.dyndns.org>
References: <76718490902041313y44eeb99bya33513bc9818aeb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 22:57:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUpkm-0006lz-BQ
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 22:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756238AbZBDV4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 16:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754007AbZBDV4Z
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 16:56:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756223AbZBDV4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 16:56:25 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B508A2A721;
	Wed,  4 Feb 2009 16:56:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D42B72A71D; Wed, 
 4 Feb 2009 16:56:20 -0500 (EST)
In-Reply-To: <76718490902041313y44eeb99bya33513bc9818aeb0@mail.gmail.com>
 (Jay Soffian's message of "Wed, 4 Feb 2009 16:13:39 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A9ED87D0-F306-11DD-B42F-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108441>

Jay Soffian <jaysoffian@gmail.com> writes:

> My understanding of "git show <merge commit>" is that it should only
> show changes if the merge resulted in a conflict that needed to be
> touched up (ignoring the possibility of an evil merge). Yet git show
> on this commit shows this diff:

I think this is "more than two versions", in

    http://thread.gmane.org/gmane.comp.version-control.git/15486/focus=15491

Nothing new to see here, I think.
