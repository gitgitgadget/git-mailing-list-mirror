From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: handle trailing slash, warn about
 non-submodules
Date: Thu, 05 Feb 2009 21:29:42 -0800
Message-ID: <7vzlh0875l.fsf@gitster.siamese.dyndns.org>
References: <cover.1233892769u.git.johannes.schindelin@gmx.de>
 <b14e34d2529721c24437ec9da3f8f15c916d4051.1233892769u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 06 06:31:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVJJ8-0000ez-S3
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 06:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbZBFF3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 00:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbZBFF3w
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 00:29:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48754 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbZBFF3w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 00:29:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 20C912A893;
	Fri,  6 Feb 2009 00:29:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 61A212A88F; Fri, 
 6 Feb 2009 00:29:44 -0500 (EST)
In-Reply-To: <b14e34d2529721c24437ec9da3f8f15c916d4051.1233892769u.git.johannes.schindelin@gmx.de> (Johannes Schindelin's message of "Fri, 6 Feb 2009 05:00:22 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2AD38AF8-F40F-11DD-B862-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108658>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Earlier, when you called
>
> 	git submodule path/to/submodule/
>
> (which happens easily if you are a heavy user of tab-completion), Git
> would silently ignore the given path, as "git ls-files path/to/submodule/"
> does not return anything due to the trailing slash.

Does --error-unmatch help in such a case to avoid shell loops?
