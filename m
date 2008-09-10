From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Start conforming code to "git subcmd" style part 2
Date: Tue, 09 Sep 2008 18:43:41 -0700
Message-ID: <7v3ak83hde.fsf@gitster.siamese.dyndns.org>
References: <20080909102830.GA9856@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Andreas Ericsson <ae@op5.se>
To: Heikki Orsila <heikki.orsila@iki.fi>
X-From: git-owner@vger.kernel.org Wed Sep 10 03:45:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdElQ-00073F-CS
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 03:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbYIJBnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 21:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbYIJBnu
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 21:43:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40918 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbYIJBnu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 21:43:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4C2E65A1B9;
	Tue,  9 Sep 2008 21:43:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 863A35A1AF; Tue,  9 Sep 2008 21:43:43 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EA2FE1AE-7ED9-11DD-BADB-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95473>

Heikki Orsila <heikki.orsila@iki.fi> writes:

> User notifications are presented as 'git cmd', and code comments
> are presented as '"cmd"' or 'git's cmd', rather than 'git-cmd'.
>
> Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>

All changes here look good to me.  Also "git grep -e git-" on the affected
files I do not see any leftover that should have been converted.

Thanks.
