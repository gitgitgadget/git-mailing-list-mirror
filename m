From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] push: point to 'git pull' and 'git push --force' in
 case of non-fast forward
Date: Sun, 09 Aug 2009 13:22:56 -0700
Message-ID: <7vljls7n4v.fsf@alter.siamese.dyndns.org>
References: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr>
 <1249717868-10946-1-git-send-email-Matthieu.Moy@imag.fr>
 <87prb6r9d1.fsf@iki.fi> <vpqab2aqqia.fsf@bauges.imag.fr>
 <7vy6pujmsc.fsf@alter.siamese.dyndns.org> <vpq63cwdee3.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Aug 09 22:23:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaEvG-0005SU-Vv
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 22:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198AbZHIUXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 16:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753105AbZHIUXK
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 16:23:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60443 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbZHIUXK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 16:23:10 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ABBB3463F;
	Sun,  9 Aug 2009 16:23:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5960463C; Sun,  9 Aug
 2009 16:23:05 -0400 (EDT)
In-Reply-To: <vpq63cwdee3.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sun\, 09 Aug 2009 20\:35\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 750CF13C-8522-11DE-B857-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125377>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

>> So how about phrasing it like this?
>>
>>     Non-fast forward pushes were rejected because you would discard remote
>>     changes you have not seen.  Integrate them with your changes and then
>>     push again. See 'non-fast forward' section of 'git push --help'.
>
> I thing not pointing to 'git pull' in the message really defeats the
> purpose of the patch. I don't find an error message only telling me
> "go read the doc as you should have done from the beginning" really
> helps.

What the above three lines does much more than that.

If you read "would discard remote changes" and understand that it is what
you want, then you may know to try --force, without having to read the
doc, or if you do not remember --force, "git push --help" would remind
you.

If you read "Integrate them with your changes" and understand that it is
talking about "git pull" or "git pull --rebase", then you do not have to
read the doc.  It should "click".

If you lack such a basic understanding, you are better off go reading the
doc after all.
