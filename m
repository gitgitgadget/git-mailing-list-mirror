From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git_getpass regression?
Date: Tue, 17 Jul 2012 22:53:28 -0700
Message-ID: <7vtxx5wr6v.fsf@alter.siamese.dyndns.org>
References: <CABPQNSa4uvgijjGCSJDXDMqHC3UkqQKKujG3xDFqnQ13LNrKdQ@mail.gmail.com>
 <20120629173954.GA3804@sigill.intra.peff.net>
 <CABPQNSZ4NhEA1CBiCBD_YNJZcnK8u=NtQ3PeDa5c0NDROPDyrQ@mail.gmail.com>
 <20120629203001.GA12937@sigill.intra.peff.net>
 <CABPQNSY3hJse6J7fDo0S5=ySZA4_7=JisfzLBUu135gR2nSF-w@mail.gmail.com>
 <20120630183607.GA19739@sigill.intra.peff.net>
 <CABPQNSYP6mUZb-1dCifytRxqP7_grzYzON2bjevK2zsGawb-yg@mail.gmail.com>
 <CABPQNSZGcReC4CgaYcmwsXyGSqzQgHKQceZ2M5D=zQmyAs8_Ug@mail.gmail.com>
 <20120703171121.GA3294@sigill.intra.peff.net>
 <CABPQNSZjZtRxf1=cdKqgp3FwP6Fw2W876si9=OpyHmZ6mjHRsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 18 07:53:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrNCZ-0005fE-MG
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 07:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653Ab2GRFxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 01:53:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53782 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036Ab2GRFxa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 01:53:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13FA26D6C;
	Wed, 18 Jul 2012 01:53:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xk79SVzRH0H+fTxe6u7FohXxVk4=; b=JgXU36
	EG+6lDZpL7C4Ele+Lx/e/L359rfNba656syXNrvar8Btar3HFqUB0jSj2Z91ygzy
	yGpfZ03zrxgZ2jNJxQ6IQEUM3v4zGjJ52WK1630bj/Ve86ibDlwwl7VH7kwc5KUx
	rnYUL7URO5dZ/tbrtAfa135LlLypCo3BNlZGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jHXbEx00P7YfCOw7pn/ut1RlY82A3rsx
	9nhw9GwyhPEE5FRqR6+Lahce/DywX+mQX6t6JtklEfGjDykSplKV8UHfQIZFNPql
	3+gfFZm1iU9JU7xMMhjooLclJdkvm/uyglurzl7T37DVB930lW6ZhzAxulyjBxse
	jDbSnlkOePs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 016D76D68;
	Wed, 18 Jul 2012 01:53:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 771256D67; Wed, 18 Jul 2012
 01:53:29 -0400 (EDT)
In-Reply-To: <CABPQNSZjZtRxf1=cdKqgp3FwP6Fw2W876si9=OpyHmZ6mjHRsw@mail.gmail.com> (Erik
 Faye-Lund's message of "Tue, 3 Jul 2012 19:37:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E64AAA4C-D09C-11E1-9EEC-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201648>

Ping on seemingly stalled discussion.
