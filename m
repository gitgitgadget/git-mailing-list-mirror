From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2009, #06; Sun, 30)
Date: Tue, 01 Sep 2009 09:51:49 -0700
Message-ID: <7vtyzmliai.fsf@alter.siamese.dyndns.org>
References: <7viqg48nxi.fsf@alter.siamese.dyndns.org>
 <m37hwili5q.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 18:52:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiWaS-0007so-Hm
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 18:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116AbZIAQvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 12:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbZIAQvy
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 12:51:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36377 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbZIAQvy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 12:51:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4879421CF8;
	Tue,  1 Sep 2009 12:51:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RTzf27oW6EcUfdATTJyt+8k676A=; b=IkVQBX
	2neVHUbF+4BkcQQDEQq71piB0yoO1s07azkz+JfFGN+kKEDwYpHbj9iRf6uJWhlx
	iqUqfQLtW0Y/EC8gUcLLZUrVuUfXIjOvwjjTzygFp2y7YB5VVbbg47oClDhRPlD9
	o5+TxswDE0NrlGxyk3Ai5wMnBOL9oPDzbDsvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xhs84Sk0374fshCl4xV4lhxn4ds/40Nj
	8w42x5uOVOtZaK7etLwEWfT1P0mzhF5ZfJHkDnUrF+S7ydVpKhCq05AjF83VPt+X
	SYumwwgCf9OUPiVgT293ePs6/C5qNUESWg08N/79Vhc5hgu4MI4Fq2WoKGyeYLA7
	OtMxqgaFeZg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 29FB121CF7;
	Tue,  1 Sep 2009 12:51:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A12B21CF6; Tue,  1 Sep
 2009 12:51:51 -0400 (EDT)
In-Reply-To: <m37hwili5q.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Tue\, 01 Sep 2009 09\:47\:11 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C0BE6726-9717-11DE-9ED5-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127544>

Jakub Narebski <jnareb@gmail.com> writes:

> There is replacement series sent to git mailing list a little while
> ago.  

Thanks; I've replaced and pushed them out on 'pu' for now.  Will hopefully
start merging earlier parts to 'next', but how widely is Hires available?
