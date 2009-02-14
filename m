From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3 v2] send-email: correct logic error with 
 --suppress-cc=cc
Date: Fri, 13 Feb 2009 23:35:16 -0800
Message-ID: <7vvdrdxyh7.fsf@gitster.siamese.dyndns.org>
References: <1234583491-61260-2-git-send-email-jaysoffian@gmail.com>
 <1234592519-71980-1-git-send-email-jaysoffian@gmail.com>
 <7viqndzf0o.fsf@gitster.siamese.dyndns.org>
 <76718490902132315l1a9d9463n255cdfe5cce15d22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 08:36:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYF54-0007RX-8X
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 08:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbZBNHf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 02:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbZBNHf0
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 02:35:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60470 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbZBNHf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 02:35:26 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6FA312B18D;
	Sat, 14 Feb 2009 02:35:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7ADF72B186; Sat,
 14 Feb 2009 02:35:18 -0500 (EST)
In-Reply-To: <76718490902132315l1a9d9463n255cdfe5cce15d22@mail.gmail.com>
 (Jay Soffian's message of "Sat, 14 Feb 2009 02:15:45 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0AB9DD24-FA6A-11DD-A03A-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109840>

Jay Soffian <jaysoffian@gmail.com> writes:

> Who let the original code in w/o tests, hmm? :-)

Reviewers and list participants, including you.
