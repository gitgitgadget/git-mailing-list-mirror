From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-subtree Next Round Ready
Date: Tue, 10 Apr 2012 09:02:02 -0700
Message-ID: <7vmx6jqzug.fsf@alter.siamese.dyndns.org>
References: <87398we3ox.fsf@smith.obbligato.org>
 <7vobrgs5tb.fsf@alter.siamese.dyndns.org>
 <87bon01cpx.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Tue Apr 10 19:08:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHeYT-00086a-6r
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 19:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668Ab2DJRI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 13:08:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42289 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753319Ab2DJRI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 13:08:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E5D26FF9;
	Tue, 10 Apr 2012 13:08:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=VuyZ67RhJCaXEmULbQBdZIZh/EU=; b=HmN0a2sad97SfjikgQd5
	mzA01rc8eZJ/kuH+UC4MIarngEwc26DSaoGLls10fLOVrgQsVevGcpYW7y0aPpFl
	J963avVlCymvoFD352ejjwlul4TkiU+jo+IRpXypAOEiJGQq6xeQHTHx4+nxqagp
	OaU7Ged2eDdlGqczZPySmF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=dYtZfzK7S4zYNEVRmwEAXro7WZV6MAbpPANRnzhSrEOQsB
	/BrUR9uzRCV5+5Rhv/M2/ekd9Y+k1PfPSjE1DLKz6YHeEfQCHmf3TFblKh1CA70I
	+0Zzqz/uTnZjZ4JUjgLWBCpfmGT47l336zMqL0GoQVUwJTP9yRipbz8KnyzQ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 509316FF8;
	Tue, 10 Apr 2012 13:08:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCCCA6FF7; Tue, 10 Apr 2012
 13:08:24 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C88C1956-832F-11E1-84EE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195103>

greened@obbligato.org writes:

> All right, this should be ready to go.
>
> git clone git://sources.obbligato.org/git/git.git
>
> Branch is "for-upstream."

I'll pull this directly to 'master' as this touches nothing outside
contrib/subtree/ directory.

If this will eventually become part of git-core, the default set for
$(prefix) in contrib/subtree/Makefile may want to watch what we set in the
toplevel Makefile, but minor things like that can be tweaked in-tree.

Thanks.
