From: Junio C Hamano <gitster@pobox.com>
Subject: Re: commit message parsing error in rebase
Date: Fri, 04 May 2012 12:18:51 -0700
Message-ID: <7vlil7ah5w.fsf@alter.siamese.dyndns.org>
References: <CAA-jfp=F7ije9nFJio5gnmNGptDR1ZTBbCi-aOv7JokqrXBgYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Csaba Henk <csaba@lowlife.hu>
X-From: git-owner@vger.kernel.org Fri May 04 21:19:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQO2D-0007of-6u
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 21:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759437Ab2EDTS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 15:18:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61384 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759427Ab2EDTSy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 15:18:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1AD77897;
	Fri,  4 May 2012 15:18:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q5SXhsCxeRu/bii4tI186KbeWCU=; b=CaZ2jR
	mY4nP12+DSjujQpGAFDR9opGZA4d/t5rcjnnjSROPqseRZMYIZQ1I8O1oW0Zu765
	hhLmcodLKCwhXN+8bZteKxKm95a1ZUBxvC/ZMl2ty4Ur1Xrtg/BlfF5b+GGJ6hkG
	V7rvgkI5MnMma6siBOd0X/VpRq3EtWIcqe7aI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tGIOFewoWdXdGDkYm07hawhJ6dWDCD4a
	LXbCKHAgvo3Mf7KTRq+FDhJYDgZmpFZSjwx7uFL2yW0LaIdGd6vzAUq+os5dTMEj
	IWmowg58Z7atAWMQHutIA4p311vaSwFy9BpPkFo4BdsFzNLJnqqxVKDpflDxhXO+
	9fphcvxifUs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7F767896;
	Fri,  4 May 2012 15:18:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 313B97894; Fri,  4 May 2012
 15:18:53 -0400 (EDT)
In-Reply-To: <CAA-jfp=F7ije9nFJio5gnmNGptDR1ZTBbCi-aOv7JokqrXBgYA@mail.gmail.com> (Csaba
 Henk's message of "Sat, 5 May 2012 00:05:35 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC7D655C-961D-11E1-971B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197054>

Sorry, but we do not support writing "diff" output in log message as-is
(it is primarily because format-patch output from such a commit is hard to
read for humans).  A common workaround is to indent such an illustrative
patches indented in the log message.
