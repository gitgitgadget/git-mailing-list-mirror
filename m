From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] mailinfo: allow individual e-mail files as input
Date: Thu, 06 Aug 2009 20:37:31 -0700
Message-ID: <7vhbwk8fb8.fsf@alter.siamese.dyndns.org>
References: <MEhvdM_GHnyaFj9ZU3lxKS47vmOk5BKslGm0FxkE_lg0SQT5Zx6KhA@cipher.nrlssc.navy.mil> <COrzR9ThNBy5SQ7chsXyUOUuBmX-VWMCz3MUVwvBOlIZzlIXRRMP6EMS7BRy_6uJvxt5H-FbtdY@cipher.nrlssc.navy.mil> <COrzR9ThNBy5SQ7chsXyUB30jVGIijxZQ3LI9L_y7Ab5vWcDcy_HolvjjuHTC7DHI9ntV-eR_v0@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ni.s@laposte.net, giuseppe.bilotta@gmail.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Aug 07 05:37:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZGH4-0007za-TP
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 05:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757002AbZHGDhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 23:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756980AbZHGDhj
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 23:37:39 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54714 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbZHGDhj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 23:37:39 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B696823009;
	Thu,  6 Aug 2009 23:37:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A929F23005; Thu, 
 6 Aug 2009 23:37:33 -0400 (EDT)
In-Reply-To: <COrzR9ThNBy5SQ7chsXyUB30jVGIijxZQ3LI9L_y7Ab5vWcDcy_HolvjjuHTC7DHI9ntV-eR_v0@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Thu\,  6 Aug 2009 20\:08\:12 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A82C9610-8303-11DE-BBE5-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125170>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> You'll notice that I changed your grep -E to an egrep and dropped the -e.

That's the right thing to do.  I was re-reading Nicolas Sebrecht's series
and checked with  "git grep -e 'egrep ' -e 'grep .*-E '" to reach the same
conclusion.  Thanks.
