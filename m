From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to ignore a modified file?
Date: Thu, 05 Mar 2009 02:21:43 -0800
Message-ID: <7v4oy82rt4.fsf@gitster.siamese.dyndns.org>
References: <20090305145308.6117@qkholland.gmail.com>
 <fabb9a1e0903050209i1e70c8b3n69d7ade9e382b617@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Quim K Holland <qkholland@gmail.com>, dealmaker <vinkhc@gmail.com>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 11:23:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfAjZ-0003Tb-SB
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 11:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbZCEKVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 05:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbZCEKVx
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 05:21:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36604 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbZCEKVx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 05:21:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BEF473B28;
	Thu,  5 Mar 2009 05:21:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1AD933B26; Thu, 
 5 Mar 2009 05:21:44 -0500 (EST)
In-Reply-To: <fabb9a1e0903050209i1e70c8b3n69d7ade9e382b617@mail.gmail.com>
 (Sverre Rabbelier's message of "Thu, 5 Mar 2009 11:09:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 704BC2F6-096F-11DE-A8C6-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112287>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Thu, Mar 5, 2009 at 09:53, Quim K Holland <qkholland@gmail.com> wrote:
>> You can run "git checkout directory".
>
> Yes, but that would destroy his changes, I do not get the impression
> that that's what he wants...

Actually, I thought the advises from you two were both horrible without
first qualifying the answers nor asking what was really wanted.

Yours didn't *ignore* changes, but staged (and would result in a later
commit) a different change to these paths, namely removal of them.

"I have these changes but I want to ignore" may mean "I didn't mean to
change them and do not care about them." and "checkout" may be the right
thing to use if that is the case.
