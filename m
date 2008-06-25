From: Junio C Hamano <gitster@pobox.com>
Subject: Re: policy and mechanism for less-connected clients
Date: Wed, 25 Jun 2008 10:34:36 -0700
Message-ID: <7vwskd1kr7.fsf@gitster.siamese.dyndns.org>
References: <20080625133458.GE20361@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Jeske <jeske@willowmail.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 25 19:36:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBYuE-0002ak-3N
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 19:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbYFYRep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 13:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbYFYRep
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 13:34:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53176 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbYFYRep (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 13:34:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BB68F1AE8A;
	Wed, 25 Jun 2008 13:34:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2030A1AE86; Wed, 25 Jun 2008 13:34:38 -0400 (EDT)
In-Reply-To: <20080625133458.GE20361@mit.edu> (Theodore Tso's message of
 "Wed, 25 Jun 2008 09:34:58 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FEE3A574-42DC-11DD-A0CB-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86306>

Theodore Tso <tytso@mit.edu> writes:

> And when you have shared push repositories, as long as users don't use
> the '+', in practice they can only add new changes.  And if you don't
> trust them not to use the '+' character in refspecs, are you really
> going to trust them not to introduce either bone-headed mistakes into
> the code?

Well, if you do not trust them, just set receive.denynonfastforwards
and they won't be able to.
