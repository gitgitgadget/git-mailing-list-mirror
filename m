From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] blame: show "previous" information in
 --porcelain/--incremental format
Date: Fri, 06 Jun 2008 08:17:31 -0700
Message-ID: <7vabhywq2c.fsf@gitster.siamese.dyndns.org>
References: <940824.46903.qm@web31808.mail.mud.yahoo.com>
 <7vd4mw4dpp.fsf@gitster.siamese.dyndns.org>
 <7v4p884dlh.fsf_-_@gitster.siamese.dyndns.org>
 <200806061128.04031.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luben Tuikov <ltuikov@yahoo.com>,
	Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org, Lea Wiemann <lewiemann@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 17:18:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4diB-0004Oe-0M
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 17:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757642AbYFFPRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 11:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757492AbYFFPRq
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 11:17:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35894 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757466AbYFFPRp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 11:17:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9633B5883;
	Fri,  6 Jun 2008 11:17:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CC87A5880; Fri,  6 Jun 2008 11:17:38 -0400 (EDT)
In-Reply-To: <200806061128.04031.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 6 Jun 2008 11:27:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B6A3751A-33DB-11DD-988C-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84078>

Jakub Narebski <jnareb@gmail.com> writes:

> What happens if attributed (blamed) commit is "evil merge"?
> Would git-blame emit multiple "previous <sha-1 of commit> <filename>"
> headers?

Read the code.  There is only one previous pointer in each origin.
