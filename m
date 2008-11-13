From: Junio C Hamano <gitster@pobox.com>
Subject: Re: post-update hook
Date: Thu, 13 Nov 2008 14:06:53 -0800
Message-ID: <7vskpvffgi.fsf@gitster.siamese.dyndns.org>
References: <b9fd99020811130753o13c5aa0cj79126a502d449cde@mail.gmail.com>
 <7v7i77h7tp.fsf@gitster.siamese.dyndns.org>
 <b9fd99020811131048p741cd9aqdcdf4cf410830915@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jeremy Ramer" <jdramer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 23:08:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0kMf-0005gn-GF
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 23:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641AbYKMWHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 17:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbYKMWHW
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 17:07:22 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47988 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbYKMWHV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 17:07:21 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A2047D27A;
	Thu, 13 Nov 2008 17:07:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DEEEB7D26B; Thu,
 13 Nov 2008 17:07:02 -0500 (EST)
In-Reply-To: <b9fd99020811131048p741cd9aqdcdf4cf410830915@mail.gmail.com>
 (Jeremy Ramer's message of "Thu, 13 Nov 2008 11:48:52 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6FB70D34-B1CF-11DD-9D43-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100920>

"Jeremy Ramer" <jdramer@gmail.com> writes:

> I had to make one change to this example to get it to work.  I'll put
> it here for completeness
>
> #!/bin/sh
> case "$*" in
> "refs/remotes/origin/master")
>     cd ..
>     GIT_DIR=".git"
>     git merge refs/remotes/origin/master
>     ;;
> esac

Yeah, thanks for correction.  My bad not resetting GIT_DIR.

By the way, I _did_ write these seemingly extra spaces around $* and the
refname on purpose.
