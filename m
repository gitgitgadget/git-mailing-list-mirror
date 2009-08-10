From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] push: point to 'git pull' and 'git push --force' in
 case of non-fast forward
Date: Mon, 10 Aug 2009 01:49:07 -0700
Message-ID: <7v1vnk3vgc.fsf@alter.siamese.dyndns.org>
References: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr>
 <1249717868-10946-1-git-send-email-Matthieu.Moy@imag.fr>
 <87prb6r9d1.fsf@iki.fi> <vpqab2aqqia.fsf@bauges.imag.fr>
 <7vy6pujmsc.fsf@alter.siamese.dyndns.org> <vpq63cwdee3.fsf@bauges.imag.fr>
 <7vljls7n4v.fsf@alter.siamese.dyndns.org> <vpq8whsawjs.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Aug 10 10:50:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaQa1-0005aD-Q3
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 10:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbZHJItO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 04:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752377AbZHJItO
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 04:49:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41897 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbZHJItN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 04:49:13 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C1C3F5666;
	Mon, 10 Aug 2009 04:49:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 248205664; Mon, 10 Aug
 2009 04:49:09 -0400 (EDT)
In-Reply-To: <vpq8whsawjs.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon\, 10 Aug 2009 10\:43\:35 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AD56E3FA-858A-11DE-837D-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125411>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> If you read "Integrate them with your changes" and understand that it is
>> talking about "git pull" or "git pull --rebase", then you do not have to
>> read the doc.  It should "click".
>
> But what's the point is being so vague, while you could just add "(see
> git pull)"? See what you've just wrote: one should "understand that it
> is about ...". So, why write Y thinking that the user should
> understand that it is about X while you could write X directly?

In order to cover both "pull" and "pull --rebase"?
