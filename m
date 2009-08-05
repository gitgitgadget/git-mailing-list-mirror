From: Junio C Hamano <gitster@pobox.com>
Subject: Re: blame on a deleted/renamed file
Date: Wed, 05 Aug 2009 10:25:53 -0700
Message-ID: <7vskg69nq6.fsf@alter.siamese.dyndns.org>
References: <449c10960908050516k25ef0a92sd8616de29a93ea5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 19:26:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYkFY-0003QW-Oc
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 19:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbZHERZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 13:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751879AbZHERZ5
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 13:25:57 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60349 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbZHERZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 13:25:57 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3513C21638;
	Wed,  5 Aug 2009 13:25:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5FCF421635; Wed, 
 5 Aug 2009 13:25:55 -0400 (EDT)
In-Reply-To: <449c10960908050516k25ef0a92sd8616de29a93ea5f@mail.gmail.com>
 (Dan McGee's message of "Wed\, 5 Aug 2009 07\:16\:13 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 09ED90B8-81E5-11DE-A49B-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124928>

Dan McGee <dpmcgee@gmail.com> writes:

> $ git annotate --follow "scripts/makepkg.in" e19d7da4~1
> fatal: cannot stat path 'scripts/makepkg.in': No such file or directory

Syntax error.  "git blame e19d7da4~1 -- scrits/makepkg.in".
