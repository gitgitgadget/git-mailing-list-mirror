From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: set default stat_width to 72
Date: Thu, 03 Apr 2008 23:12:23 -0700
Message-ID: <7vr6dmywqg.fsf@gitster.siamese.dyndns.org>
References: <20080403102214.GA23121@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jan Engelhardt <jengelh@computergmbh.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 04 08:13:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhfAw-0004LF-S5
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 08:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbYDDGMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 02:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbYDDGMj
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 02:12:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43336 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbYDDGMi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 02:12:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3465E3200;
	Fri,  4 Apr 2008 02:12:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8BBE431FF; Fri,  4 Apr 2008 02:12:33 -0400 (EDT)
In-Reply-To: <20080403102214.GA23121@coredump.intra.peff.net> (Jeff King's
 message of "Thu, 3 Apr 2008 06:22:14 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78794>

Jeff King <peff@peff.net> writes:

>> format-patch already defaults to "--stat --summary -p" if you give it
>> no format options. The default stat is 80, I believe; for format-patch
>> it should probably be bumped to 72 anyway.

> This should be totally harmless and maint-worthy, I would think.

Harmless it might be, in the sense that it won't eat your data.

But it loses information, and I am not sure if it is worth it.  Why do you
even worry about "a few layers of quoting"?  Isn't it a much worse offense
from responder/commenter's part to quote and NOT trimming diffstat part?

 
