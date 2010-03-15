From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git checkout -b: unparent the new branch with -o
Date: Sun, 14 Mar 2010 19:06:41 -0700
Message-ID: <7vhboil4ni.fsf@alter.siamese.dyndns.org>
References: <1268173713-5224-1-git-send-email-erick.mattos@gmail.com>
 <7vr5nqrpyg.fsf@alter.siamese.dyndns.org>
 <55bacdd31003120845kc980d16s1e6006d56d6f923a@mail.gmail.com>
 <7v8w9whd3g.fsf@alter.siamese.dyndns.org>
 <m38w9wlg7i.fsf@localhost.localdomain>
 <55bacdd31003141457x74222a79lc060112d20dbbe4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 03:06:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nqzho-000199-N2
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 03:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759511Ab0COCGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 22:06:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759019Ab0COCGv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 22:06:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 51A03A1476;
	Sun, 14 Mar 2010 22:06:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F5cIGTVUJ9FipPs65iBiBrzDfIc=; b=s/vwVU
	/SXtI/20y9IsSy6DZpnj0/5Dgn4UvLxMGEMhzm+p4i3V5hY5GXXbjsgBbv2IPlai
	3QjRgww7uIU3Uu4I5/jjBBjWLhl/IvZMa2DaUxxYLzK82JSTlomBaRORFJkJLF+0
	ESc1VPvhRWmasXudck9hcIyc9WJohTTpJWWMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gu+iLWlxyMHYeIfRspDkfhRArGSc8J5z
	CxhCPfpYzHHvPgRqn/M3gobdXsrHIOy6v38Wbn7DC8gTX0vmEmgwC3luv+CEDbpb
	qYIF7AdLakhRJu9ak2paO50RalDPzfPZHg+H4OrfWwcHtDKtXZIwKJpowTzfGA07
	tbrjn/GThBA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 212F0A146E;
	Sun, 14 Mar 2010 22:06:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64C1CA1467; Sun, 14 Mar
 2010 22:06:43 -0400 (EDT)
In-Reply-To: <55bacdd31003141457x74222a79lc060112d20dbbe4c@mail.gmail.com>
 (Erick Mattos's message of "Sun\, 14 Mar 2010 18\:57\:44 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 69A0F5AE-2FD7-11DF-96AA-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142165>

Erick Mattos <erick.mattos@gmail.com> writes:

> You got it right.  HTML and man branches are really very good examples.

Not at all.  You fundamentally do not want to have checkout of these
branches in the same place as you checkout and work in the main branches.
