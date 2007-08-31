From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-reset.txt: Use uniform HEAD~N notation in all examples
Date: Fri, 31 Aug 2007 12:00:35 -0700
Message-ID: <7vy7frzfzg.fsf@gitster.siamese.dyndns.org>
References: <tzqfsijk.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Fri Aug 31 21:00:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRBje-0006Vb-5o
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 21:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966303AbXHaTAj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 15:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966190AbXHaTAj
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 15:00:39 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:41701 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965984AbXHaTAj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 15:00:39 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id BF56F129615;
	Fri, 31 Aug 2007 15:00:58 -0400 (EDT)
In-Reply-To: <tzqfsijk.fsf@cante.net> (Jari Aalto's message of "Fri, 31 Aug
	2007 20:47:11 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57194>

Jari Aalto <jari.aalto@cante.net> writes:

> The manual mixed both caret(HEAD^) and tilde (HEAD~N) notation in
> examples. This may be xconfusing to new users. The "counting" notation
> HEAD~N likely to be grasped more easily because it allow successive
> numbering 1, 2, 3 etc.

I am mildly negative on this change.

Referring to (rather, "having to refer to" to fix mistakes) the
previous commit happens far more often than referring to an
ancestor of an arbitrary generation away (i.e. HEAD~$n).  I
think it is a better idea to expose users early on that HEAD^
notation which is shorter to type.
