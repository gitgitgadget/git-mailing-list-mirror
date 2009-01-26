From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Common ancestor in merge diffs?
Date: Mon, 26 Jan 2009 11:55:30 -0800
Message-ID: <7vhc3l6dvx.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0901261318030.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jan 26 20:57:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRXa5-0004qz-WA
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 20:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbZAZTzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 14:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbZAZTzi
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 14:55:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43912 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbZAZTzh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 14:55:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 16EB11D59D;
	Mon, 26 Jan 2009 14:55:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2AEB31D59B; Mon,
 26 Jan 2009 14:55:31 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0901261318030.19665@iabervon.org> (Daniel
 Barkalow's message of "Mon, 26 Jan 2009 13:41:41 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4CDF9698-EBE3-11DD-A034-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107261>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I was just doing an annoying merge (I'd reorganized code while other 
> people made changes to it), and I kept having the problem that it was hard 
> to figure out what each side had done. Is there some way to ask git for 
> the diffs between the common ancestor (which is unique in my case, so it's 
> actually useful) and each of the sides of the merge?

Have you tried "git checkout --conflict=diff3 $that_conflicted_path"?
