From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v1 1/1] +5 cases (4 fail), diff whitespace tests
Date: Sat, 17 Jan 2009 23:47:02 -0800
Message-ID: <7vd4elys21.fsf@gitster.siamese.dyndns.org>
References: <alpine.GSO.2.00.0901141633030.9831@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Sun Jan 18 08:49:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOSOc-0006BM-Ql
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 08:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757931AbZARHrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 02:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758115AbZARHrJ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 02:47:09 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36800 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773AbZARHrH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 02:47:07 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A5D0791559;
	Sun, 18 Jan 2009 02:47:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EA9A191557; Sun,
 18 Jan 2009 02:47:03 -0500 (EST)
In-Reply-To: <alpine.GSO.2.00.0901141633030.9831@kiwi.cs.ucla.edu> (Keith
 Cascio's message of "Wed, 14 Jan 2009 16:48:24 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 34218A36-E534-11DD-8CCD-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106147>

Keith Cascio <keith@CS.UCLA.EDU> writes:

>  +5 cases (4 fail), diff whitespace tests
>  There are 2^3 = eight possible combinations of the three flags:
>  -w -b --ignore-space-at-eol
>  Three of those combinations were already being tested:
>  [none]
>  -w
>  -b
>  Add tests of the other five combinations,

Hmm.  Are these three supposed to be orthogonal?
