From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] Add option for using a foreign VCS
Date: Wed, 25 Mar 2009 11:03:14 -0700
Message-ID: <7vhc1h5vkt.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0903242303330.19665@iabervon.org>
 <7v1vsm9jwd.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0903251042280.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 19:06:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmXU9-0002oK-Lg
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 19:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757872AbZCYSDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 14:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756634AbZCYSDW
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 14:03:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756435AbZCYSDV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 14:03:21 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C9908A5B95;
	Wed, 25 Mar 2009 14:03:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6D0A5A5B93; Wed,
 25 Mar 2009 14:03:16 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3919C19A-1967-11DE-BB54-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114634>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> > -	if (!prefixcmp(url, "rsync:")) {
>> > +	if (remote && remote->foreign_vcs) {
>> > +	} else if (!prefixcmp(url, "rsync:")) {
>> 
>> 	if (...) {
>>         	; /* empty */
>> 	} else ...
>
> I don't think I've ever tried writing an empty block for git before. It's 
> braces containing a semicolon and comment? (Of course, the reason I wrote 
> this one this way is so that the next patch could put two "+" lines in 
> there and have no "-" lines)

Wasn't a serious "this has to be the final style" suggestion, but more
about "what do you mean by this?  are you going to add more code here in
the later round?" question.
