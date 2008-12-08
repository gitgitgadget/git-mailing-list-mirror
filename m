From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-stash: use git rev-parse -q
Date: Sun, 07 Dec 2008 17:42:46 -0800
Message-ID: <7vhc5fcui1.fsf@gitster.siamese.dyndns.org>
References: <1228179369-3766-1-git-send-email-vmiklos@frugalware.org>
 <20081207231723.GA5068@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 08 02:44:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9VAt-0005Jo-76
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 02:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287AbYLHBnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 20:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755769AbYLHBnE
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 20:43:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41851 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755572AbYLHBnA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 20:43:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6B571185A8;
	Sun,  7 Dec 2008 20:42:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 26DB3185A7; Sun, 
 7 Dec 2008 20:42:53 -0500 (EST)
In-Reply-To: <20081207231723.GA5068@atjola.homenet> (=?utf-8?Q?Bj=C3=B6rn?=
 Steinbrink's message of "Mon, 8 Dec 2008 00:17:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8AA1343C-C4C9-11DD-BE66-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102514>

Thanks; I'll revert this one.  Use of -q is simply not worth this
aggravation.
