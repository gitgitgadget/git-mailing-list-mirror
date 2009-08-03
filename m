From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please make git-am handle \r\n-damaged patches
Date: Mon, 03 Aug 2009 14:30:38 -0700
Message-ID: <7vocqw8u0x.fsf@alter.siamese.dyndns.org>
References: <4A7735B0.2040703@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 23:30:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY57N-0000QC-1A
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 23:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbZHCVan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 17:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752805AbZHCVam
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 17:30:42 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34442 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbZHCVam (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 17:30:42 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3EE181F855;
	Mon,  3 Aug 2009 17:30:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id ADF801F854; Mon, 
 3 Aug 2009 17:30:39 -0400 (EDT)
In-Reply-To: <4A7735B0.2040703@zytor.com> (H. Peter Anvin's message of "Mon\,
 03 Aug 2009 12\:08\:32 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E57D56DA-8074-11DE-A71A-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124721>

"H. Peter Anvin" <hpa@zytor.com> writes:

> In a serious case of craniorectal immersion, the Thunderbird developers
> have started using \r\n line endings on saved emails:
>
> https://bugzilla.mozilla.org/show_bug.cgi?id=503271
> https://bugzilla.mozilla.org/show_bug.cgi?id=507530
>
> It would be nice if git-am could handle this case automatically.

Perhaps

    $ dos2unix *.eml | git am
