From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/13] remote.c: make match_refs() copy src ref before
 assigning to peer_ref
Date: Mon, 23 Feb 2009 17:34:39 -0800
Message-ID: <7vocwspqhc.fsf@gitster.siamese.dyndns.org>
References: <cover.1235368324.git.jaysoffian@gmail.com>
 <75e083170cea799499bf66792a1c3950b29d6021.1235368324.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 02:36:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbmDU-0001gq-D4
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 02:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbZBXBeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 20:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbZBXBet
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 20:34:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44020 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbZBXBes (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 20:34:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7881D2BCB1;
	Mon, 23 Feb 2009 20:34:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 782342BCAE; Mon,
 23 Feb 2009 20:34:41 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 51991B96-0213-11DE-B2A0-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111190>

If this issue was present before you started touching the affected code,
it should come much earlier in the series than [10/13].  If on the other
hand this was introduced by earlier one in the series, the patch that
introduced the bug should be corrected in place in the sequence without
this patch.
