From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cherry-pick lost
Date: Wed, 18 Jun 2014 11:16:17 -0700
Message-ID: <xmqqppi6hymm.fsf@gitster.dls.corp.google.com>
References: <1958581451.1669669.1403088403521.JavaMail.zimbra@travelzen.com>
	<581006621.1669726.1403088884141.JavaMail.zimbra@travelzen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: guangai.che@travelzen.com
X-From: git-owner@vger.kernel.org Wed Jun 18 20:16:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxKPY-0006xU-5U
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 20:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564AbaFRSQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 14:16:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65396 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753657AbaFRSQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 14:16:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 033E71F20E;
	Wed, 18 Jun 2014 14:16:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uPx6CYIrnH+P/EOokNQ9unaU8ZM=; b=R1FLFo
	/JTpQsmCUirou5UmGI3QlRbnDRGLn3DReaiKSQouyTDx3bIRIrzk227XGFZ3lK0p
	RGO2nf2Dz1jgMXD1C7PQIfmtH2CXGOOe+kXDhC5BiygGhrNThlSLcyoh4JTJ5Ydf
	eDWtOnz98yv5q8VWBKfs2TRcalTZYYHyQlS7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mYXbmvSB247j+nRNF/e1fx7rfid2GEA0
	RyD+Vo90SKWDinkajdcJ9WVt28QTAx5gJxvF1AG7NXgqtq9zwQNIRhQXrKWFalGY
	JdZm7CF6uk75udNY8ieqPYR97SLL8gp1DEG4B6y4li5z0P+NmiH4HSuYAagGui40
	QQS+5ALcJ2g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EC5101F20D;
	Wed, 18 Jun 2014 14:16:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3C0FD1F20A;
	Wed, 18 Jun 2014 14:16:17 -0400 (EDT)
In-Reply-To: <581006621.1669726.1403088884141.JavaMail.zimbra@travelzen.com>
	(guangai che's message of "Wed, 18 Jun 2014 18:54:44 +0800 (CST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A3E82EE0-F714-11E3-8A6A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252018>

guangai.che@travelzen.com writes:

>   I delete a file and push to master branch, after code reviewing
>   in gerrit, then click 'Cherry Pick To' button to cherry-pick to
>   release/1.1 branch, and then code review and merge...

Gerrit folks, for which this list may not be the best place to get
in touch with, may know a lot better than anybody on this list what
"Cherry Pick To" button does, how it does so, what the typical user
errors are, etc.

https://code.google.com/p/gerrit/ tells me that perhaps you would
have better luck with these places:

  https://groups.google.com/forum/#!forum/repo-discuss
  IRC freenode #gerrit
