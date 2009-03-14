From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][v2] http authentication via prompts (with correct line 
 lengths)
Date: Fri, 13 Mar 2009 22:55:55 -0700
Message-ID: <7vocw4ejh0.fsf@gitster.siamese.dyndns.org>
References: <49B5AF67.6050508@gmail.com>
 <7v1vt6dxg9.fsf@gitster.siamese.dyndns.org> <49B5F0BA.3070806@gmail.com>
 <7v63ihdgy6.fsf@gitster.siamese.dyndns.org>
 <e2b179460903120153u5fdb58b6tf3027eea23673df0@mail.gmail.com>
 <7vsklihsti.fsf@gitster.siamese.dyndns.org>
 <e2b179460903130353p1d3c1cb2n8286c2a284724156@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Stenberg <daniel@haxx.se>,
	Mike Gaffney <mr.gaffo@gmail.com>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 06:57:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiMsK-00006r-Cw
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 06:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbZCNF4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 01:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbZCNF4F
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 01:56:05 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47726 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbZCNF4D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 01:56:03 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 052CB50C9;
	Sat, 14 Mar 2009 01:56:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4127850C8; Sat,
 14 Mar 2009 01:55:57 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CC683FB2-105C-11DE-A9AE-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113236>

Mike Ralphson <mike.ralphson@gmail.com> writes:

> 2009/3/13 Daniel Stenberg <daniel@haxx.se>:
>>Driven by use cases such as this, I also recently produced the
>>"symbols-in-versions" document in the libcurl tree which should
>> help apps to know what should works when:
>
>> http://cool.haxx.se/cvs.cgi/curl/docs/libcurl/symbols-in-versions?rev=HEAD&content-type=text/vnd.viewcvs-markup
>
> Very helpful, thanks.

Yeah, I wish we new about it much earlier.  Thanks, Daniel.

> Junio, if I check all the unprotected CURL* options against this list,
> would that give us our absolute minimum supported version? If so,
> would it then be ok to remove any unnecessary ifdefs for lower
> versions if they exist?

Sounds like a good plan.  Please get the ball rolling.
