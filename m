From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Sun, 05 Apr 2009 12:02:42 -0700
Message-ID: <7vmyausz3h.fsf@gitster.siamese.dyndns.org>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 21:04:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqXdj-0002DL-Vu
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 21:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbZDETCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 15:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754007AbZDETCs
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 15:02:48 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52693 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009AbZDETCs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 15:02:48 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4709FC96E;
	Sun,  5 Apr 2009 15:02:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B0E54C96B; Sun, 
 5 Apr 2009 15:02:43 -0400 (EDT)
In-Reply-To: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sun, 5 Apr 2009 16:48:49 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 596EC57A-2214-11DE-A1E9-DD19768B9EAE-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115678>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This is the list of actions I've mapped:
>
>  * add: git stage = git stage add (git add)
>  * rm: (git rm --cached)
>  * diff: (git rm --cached)
>  * import: stage all files; modified, deleted, new
>  * ls: (git ls-files --stage)

I do not think these are good ideas at all, as it just spreads more
confusion, not less.
