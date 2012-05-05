From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-scm.com refresh
Date: Fri, 04 May 2012 18:31:40 -0700
Message-ID: <7vd36j8lc3.fsf@alter.siamese.dyndns.org>
References: <CAP2yMaJy=1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQgE0PcVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 03:31:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQTqj-0000xM-41
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 03:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889Ab2EEBbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 21:31:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51583 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754830Ab2EEBbp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 21:31:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81F028253;
	Fri,  4 May 2012 21:31:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qJDgyD+TvQE+NG0GbJu/FfH7vns=; b=sv5xiw
	B9BZTKwjIBNCvbcq5C+g1QTPyQIpCzCP6e1jwhXFPHlBAqrK1I+wCdoTXGZZ/q1q
	M0PekmCx2fkZTCu/6bWlX0GWThywXzKdpJ3Bc6muomOfVW1aBoUbK+wqwl25lgfG
	DF3Zcel2e41Jej6xTlKn8GzW3AfRAMwT+puHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q0uj4pcZjvNF4H2nHWuOPAuUBE3kE2T0
	HLfpd6XJjmPqtTSZk6DQrEWLRb1UGH81m/MH1YpwI02vnI+nhfS52v4y0ca/eskN
	6DuTSkR467rNYr66RlDzEyeyXNCH7iDw58v3obUORZsKvintrbuUOJtJfxbbfuJM
	BqaN/bMgItY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7943A8252;
	Fri,  4 May 2012 21:31:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FC7A824F; Fri,  4 May 2012
 21:31:41 -0400 (EDT)
In-Reply-To: <CAP2yMaJy=1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQgE0PcVA@mail.gmail.com> (Scott
 Chacon's message of "Fri, 4 May 2012 16:29:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 115EFA60-9652-11E1-A13F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197085>

Scott Chacon <schacon@gmail.com> writes:

> Hey everyone,
>
> I just shipped a big update to the git-scm.com website,...

Thanks.  The Reference Manual area lists "apply" in a very funny place.
It should go together with "diff", whichever section you decide to put
"diff" in.  As "diff" is listed in "Basic Snapshotting", and it will not
be able to achieve that without being able to apply its output back to the
working tree or to the index, I would suggest moving "apply" to the
section as well.

I am fairly happy about the look of the new site except for a few things
;-).

It seems that you are trying to advocate "staging area" as some sort of
official term.  I think "it is like a staging area" is a good phrase to
use when answering "what is the index?", but I think repeating it million
times without telling the casual readers what its official name is is
counterproductive.  Don't do that.  It will confuse these same people when
they start reading manuals.
