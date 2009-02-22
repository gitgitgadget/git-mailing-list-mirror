From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-blame and finding previous version of a line
Date: Sun, 22 Feb 2009 08:48:36 -0800
Message-ID: <7vy6vy2za3.fsf@gitster.siamese.dyndns.org>
References: <200902211539.43312.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 17:50:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbHWw-0004dZ-Vl
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 17:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645AbZBVQsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 11:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753165AbZBVQsq
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 11:48:46 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085AbZBVQsp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 11:48:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5393B9CACB;
	Sun, 22 Feb 2009 11:48:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AAFD99CAC5; Sun,
 22 Feb 2009 11:48:38 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AA1A9AC4-0100-11DE-8151-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111013>

Jakub Narebski <jnareb@gmail.com> writes:

> What algorithm do you propose to find previous version of a line? It is
> not a question with definitive answer, I think, so some heuristic would
> be required. Previous version of a line might not even exists! (in that
> case we would probably want to be in the place it is inserted). 
> Fortunately this is a situation where approximation is good enough.

I think Peff and Jonas had discussion on this in the previous thread on
tig.
