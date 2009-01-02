From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git reset --hard" == "git checkout HEAD" == "git reset --hard
 HEAD" ???
Date: Fri, 02 Jan 2009 14:36:19 -0800
Message-ID: <7v4p0hcp3w.fsf@gitster.siamese.dyndns.org>
References: <20090102195724.GA23119@seberino.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: chris@seberino.org
X-From: git-owner@vger.kernel.org Fri Jan 02 23:37:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIseM-0002Em-AT
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 23:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758580AbZABWg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 17:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbZABWg1
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 17:36:27 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34942 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758580AbZABWg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 17:36:26 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9FAF98D8DB;
	Fri,  2 Jan 2009 17:36:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DEE838D8D9; Fri,
  2 Jan 2009 17:36:21 -0500 (EST)
In-Reply-To: <20090102195724.GA23119@seberino.org> (chris@seberino.org's
 message of "Fri, 2 Jan 2009 11:57:24 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C95A9BF6-D91D-11DD-97D0-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104434>

chris@seberino.org writes:

> Does "git reset --hard" == "git checkout HEAD" == "git reset --hard HEAD" ???

No, but "reset --hard" without a commit-ish defaults to HEAD so the first
one and the last one are equivalent.

> It seems we have 2 ways to blow away work we haven't checked in yet then right?

Wrong.
