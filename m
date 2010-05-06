From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem with git merge/rebase with conflicts
Date: Thu, 06 May 2010 12:13:03 -0700
Message-ID: <7v8w7wj134.fsf@alter.siamese.dyndns.org>
References: <19426.38028.501924.921359@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Thu May 06 21:13:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA6Va-0001it-Io
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 21:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756550Ab0EFTNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 15:13:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756150Ab0EFTNL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 15:13:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A979B1398;
	Thu,  6 May 2010 15:13:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3B4OLA5iodwMW2aeYgL33i8/w9E=; b=U/uG0o
	XGhp3nTdZcHnz3D1qsW8hgSGZ+1T2vTjW4PidGx3IBxd4bLcWa562qdcOmHJMDgg
	v/IK+OtFjj7/CIZgpsiXYUGwKFYVpe8FBbl84h/ed8PL6MV+oHIJmtnGUDiZrgal
	Auxf0mmd5j+QASXmgWWaiAg391EV5OtOm5aSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mu8SVNcEx6hydy7R1xhuiPhkkj31ntzA
	9084JejpE58M+3+s2WdMDOJtKaBdLL1QcHNTZ2NGcLvfKvBvv+3X/bumFAwG/res
	zuGF1p6QXWyR/D14olIBMKif3r8Skeifq4z8/vPJ4kfg4+3BBgojXTZseidwd8uQ
	2V/pHf8DyIQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 65793B1397;
	Thu,  6 May 2010 15:13:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0FFDB1395; Thu,  6 May
 2010 15:13:04 -0400 (EDT)
In-Reply-To: <19426.38028.501924.921359@winooski.ccs.neu.edu> (Eli Barzilay's
 message of "Thu\, 6 May 2010 06\:06\:04 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6738ACF4-5943-11DF-AE66-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146488>

Eli Barzilay <eli@barzilay.org> writes:

> 1. I get this:
> 3. Again, starting from the same setup:

I don't have time to look at the second one, but these are quite obvious
and natural.  "status" in these cases notices that you haven't made any
change relative to HEAD (in either the index nor in the working tree)
after all, and that is what is being reported.
