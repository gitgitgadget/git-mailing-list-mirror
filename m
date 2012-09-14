From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using Format/export-subst Howto.
Date: Fri, 14 Sep 2012 14:23:59 -0700
Message-ID: <7vfw6k2t8w.fsf@alter.siamese.dyndns.org>
References: <84EA18831601B6429E578236AE239B01A54807F242@EAGNMNSXMB07.usa.dce.usps.gov>
 <50532B35.9050607@drmicha.warpmail.net> <5053480E.2010002@viscovery.net>
 <84EA18831601B6429E578236AE239B01A54807F376@EAGNMNSXMB07.usa.dce.usps.gov>
 <50534FC6.2040207@viscovery.net>
 <1347656962.3998.140661128069097.6D9BE3C4@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"Mestnik\, Michael J - Eagan\, MN - Contractor" 
	<Michael.J.Mestnik@usps.gov>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 14 23:24:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCdN6-0005Q6-FY
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 23:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756209Ab2INVYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 17:24:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34309 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756132Ab2INVYC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 17:24:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D00E2856D;
	Fri, 14 Sep 2012 17:24:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q3oV2CqemO/K4QCYtHjkd5GSVTE=; b=WiwJen
	CzN+NrdO/pnZA8F1fSNU7JXpXRcqnGUtnE2oK3uly2rMGLqsZHwSSXyqLtHj96gi
	spFGl7j23rpRtu1blDvMNTHIpNs5uIc6lvVnDXs1bOyOMMav/jUOWbyU0XUG6Q6y
	Qyvhkl9vIDtbmObuVlJD6iXjpfZGJ8+oJTVbY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bx8M6oQnlS2LmJEMjhUEuV6AlhvJIzje
	U4Mwqm16cA3XI8tkvVfu9kedqFHwXBXT5hwPSQONPiNJcGGcCi6bWZPi/AEVszu5
	K8BYmR9dsNUfnfWHkYBxYjmM6UDOpw+1a+WOcziVENzGQR7g5X5G2aNYC/7v4jFl
	DGjM1x2ipoc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBEB7856C;
	Fri, 14 Sep 2012 17:24:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 314BB856B; Fri, 14 Sep 2012
 17:24:01 -0400 (EDT)
In-Reply-To: <1347656962.3998.140661128069097.6D9BE3C4@webmail.messagingengine.com>
 (Michael J. Gruber's message of "Fri, 14 Sep 2012 23:09:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 808BC8FA-FEB2-11E1-B1EB-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205533>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> you need to "rm file && git checkout file"). If the user has to update
> $Id$ to match the current sha1
> (by remembering to do a more forceful checkout than checkout -f) then
> one half of that feature is useless. 

As if there is any value in "$Id$" _feature_.  It's a checkbox item,
nothing more ;-).
