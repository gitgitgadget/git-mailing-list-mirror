From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] don't mention index refreshing side effect in git-status docs
Date: Sun, 09 Dec 2007 10:15:51 -0800
Message-ID: <7vhcirpwdk.fsf@gitster.siamese.dyndns.org>
References: <20071209082133.GA2257@coredump.intra.peff.net>
	<57518fd10712090816pa43cf97mbc1b8f5fbe81c66f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jonathan del Strother" <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 19:16:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1Qhd-0001bX-W3
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 19:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbXLISQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 13:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbXLISQK
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 13:16:10 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:38149 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbXLISQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 13:16:09 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 176835BE3;
	Sun,  9 Dec 2007 13:16:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B2CD85BE2;
	Sun,  9 Dec 2007 13:16:02 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67642>

"Jonathan del Strother" <maillist@steelskies.com> writes:

> ... the GIT-VERSION-GEN
> script occasionally gives me spurious 'dirty' results (eg when a file
> timestamp changes despite the content having changed).

Good eyes.  Either refreshing before diff-index or using the "git diff"
Porcelain would be more appropriate.
