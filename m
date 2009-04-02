From: Junio C Hamano <gitster@pobox.com>
Subject: Re: More help with "pull" please
Date: Wed, 01 Apr 2009 19:24:20 -0700
Message-ID: <7viqlnokrv.fsf@gitster.siamese.dyndns.org>
References: <450196A1AAAE4B42A00A8B27A59278E70A7D4D9A@EXCHANGE.trad.tradestation.com>
 <4659A860-4AF5-4E34-B38E-60C926E2BAE1@dbservice.com>
 <450196A1AAAE4B42A00A8B27A59278E70A7D4E71@EXCHANGE.trad.tradestation.com>
 <F364AB31-EC5B-4719-834E-58613BDBC433@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Dlugosz <JDlugosz@tradestation.com>, <git@vger.kernel.org>
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 04:26:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpCd3-0003Wx-M1
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 04:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756021AbZDBCY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 22:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753670AbZDBCY3
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 22:24:29 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46672 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbZDBCY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 22:24:28 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 487A6BC9C;
	Wed,  1 Apr 2009 22:24:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 80F7BBC9B; Wed, 
 1 Apr 2009 22:24:22 -0400 (EDT)
In-Reply-To: <F364AB31-EC5B-4719-834E-58613BDBC433@dbservice.com> (Tomas
 Carnecky's message of "Thu, 2 Apr 2009 01:14:45 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 62FF9932-1F2D-11DE-BDE1-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115431>

Tomas Carnecky <tom@dbservice.com> writes:

>> OK, that works by adding something to the config file, right?  The
>> docs
>> don't say, but does mention "having Pull: <refspec> lines for a
>> <repository>".  Does tracking add Pull: lines, or is that another
>> feature?
>
> I think Pull: lines are not used anymore in newer
> repositories.

If your repository is using .git/remotes/origin to name the "origin"
remote, they are still honored.  But you are correct to point out that
branch.<name>.remote and with the remote.<name>.* variables in .git/config
are used to control these more recent features.  So in that sense the
documentation is still correct.
