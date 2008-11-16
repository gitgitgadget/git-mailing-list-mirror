From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Conflict-free merging (i.e. concat) of conflicting branches?
Date: Sun, 16 Nov 2008 08:28:31 -0800
Message-ID: <7viqqn4ouo.fsf@gitster.siamese.dyndns.org>
References: <2d460de70811160550g75e50e00gb50d3b2045c460af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, markus.heidelberg@web.de
To: "Richard Hartmann" <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 17:30:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1kVx-0002Gj-05
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 17:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbYKPQ3C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 11:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752705AbYKPQ3B
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 11:29:01 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbYKPQ3B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 11:29:01 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 945657ECD3;
	Sun, 16 Nov 2008 11:28:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 231777ECD0; Sun,
 16 Nov 2008 11:28:38 -0500 (EST)
In-Reply-To: <2d460de70811160550g75e50e00gb50d3b2045c460af@mail.gmail.com>
 (Richard Hartmann's message of "Sun, 16 Nov 2008 14:50:34 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AAE00914-B3FB-11DD-978F-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101140>

"Richard Hartmann" <richih.mailinglist@gmail.com> writes:

> The question is if there is a way to to merge these
> branches in a way that is conflict-free and includes
> all lines. Obviously, the order of the lines is irrelevant
> and can be random.

gitattributes(5) and look for "union"?
