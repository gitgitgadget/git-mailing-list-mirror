From: Junio C Hamano <gitster@pobox.com>
Subject: Re: is there a 'git find'?
Date: Tue, 04 Aug 2009 21:38:06 -0700
Message-ID: <7veirqub81.fsf@alter.siamese.dyndns.org>
References: <3a69fa7c0908042114v7097e87esbe18f49eef9267f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: E R <pc88mxer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 06:38:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYYGe-0000l5-99
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 06:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978AbZHEEiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 00:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbZHEEiP
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 00:38:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54432 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbZHEEiP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 00:38:15 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D47101D4B7;
	Wed,  5 Aug 2009 00:38:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C1EAD1D4A8; Wed,  5 Aug 2009
 00:38:08 -0400 (EDT)
In-Reply-To: <3a69fa7c0908042114v7097e87esbe18f49eef9267f5@mail.gmail.com>
 (E. R.'s message of "Tue\, 4 Aug 2009 23\:14\:29 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CA0A29AE-8179-11DE-BD5F-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124850>

E R <pc88mxer@gmail.com> writes:

> Within a specific commit I'd like to find all the files whose path
> names match a regular expression.

    git ls-tree -r [--name-only | -t] "$commit" | grep -e "$pattern"

?
