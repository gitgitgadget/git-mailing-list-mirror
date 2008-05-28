From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rename git-rm --cached to --index
Date: Wed, 28 May 2008 16:25:50 -0700
Message-ID: <7vprr6roxt.fsf@gitster.siamese.dyndns.org>
References: <20080528231405.GA25416@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nico -telmich- Schottelius <nico-git-20080529@schottelius.org>
X-From: git-owner@vger.kernel.org Thu May 29 01:26:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1V2m-0001TL-Jl
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 01:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507AbYE1X0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 19:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754433AbYE1X0D
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 19:26:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44844 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbYE1X0B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 19:26:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EC870302A;
	Wed, 28 May 2008 19:25:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 604E23029; Wed, 28 May 2008 19:25:54 -0400 (EDT)
In-Reply-To: <20080528231405.GA25416@denkbrett.schottelius.org>
 (nico-git-20080529@schottelius.org's message of "Thu, 29 May 2008 01:14:05
 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6C866264-2D0D-11DD-A7A4-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83146>

Please don't make naming inconsistent.  --index means "do things that
usually affect only work tree also to the index as well", while --cached
means "act only on the index" (study "git apply" for another example).

"git rm" that does not touch work tree but removes only the index entry
should be named --cached.
