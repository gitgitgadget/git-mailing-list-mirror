From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/gitcli.txt: dashed forms not allowed
 anymore
Date: Thu, 01 Jan 2009 13:00:39 -0800
Message-ID: <7vabaaivwo.fsf@gitster.siamese.dyndns.org>
References: <87ljtvmygk.fsf@jidanni.org>
 <20090101144045.GC21154@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jidanni@jidanni.org, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Jan 01 22:02:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIUgK-0005jH-5D
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 22:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598AbZAAVAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 16:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbZAAVAs
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 16:00:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64593 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbZAAVAr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 16:00:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0ABF61B8D3;
	Thu,  1 Jan 2009 16:00:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 848391B8D4; Thu, 
 1 Jan 2009 16:00:41 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 42765C00-D847-11DD-9E81-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104324>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Thu, Jan 01, 2009 at 12:39:39PM +0800, jidanni@jidanni.org wrote:
>> - * it's preferred to use the non dashed form of git commands, which means that
>> -   you should prefer `"git foo"` to `"git-foo"`.
>> + * it's required to use the non dashed form of git commands, which means that
>> +   you must use `"git foo"` and not `"git-foo"`. The latter no longer works.
>
> I would append: "unless you add the output of `git --exec-path` to your
> PATH."

I actually wouldn't.

There needs to be a description about use of PATH=$(git --exec-path):$PATH
if you choose to use the dashed forms in your script.  Don't we already
have that elsewhere more basic in the documentation set?

The quoted part of the documentation talks about the syntax and convention
used while scripting, and what it wants to say with the sentence is that
the dashless form is preferred, even with PATH=$(git --exec-path):$PATH
(iow, it was preferred before 1.6.0, and it still is preferred with the
$PATH adjustments after 1.6.0).

I think it muddies the point of the list if you talk about the necessity
of $PATH adjustment, which is a irrelevant detail.
