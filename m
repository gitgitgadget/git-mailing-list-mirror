From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2011, #06; Wed, 21)
Date: Thu, 22 Sep 2011 16:45:27 -0700
Message-ID: <7vvcskw38o.fsf@alter.siamese.dyndns.org>
References: <7vaa9xyxpf.fsf@alter.siamese.dyndns.org>
 <m3r538qj0j.fsf@localhost.localdomain>
 <7v4o04xjcb.fsf@alter.siamese.dyndns.org>
 <201109230133.33214.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 01:45:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6sxZ-0007Gt-D2
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 01:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754416Ab1IVXpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 19:45:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37831 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653Ab1IVXpb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 19:45:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76D9763B6;
	Thu, 22 Sep 2011 19:45:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dB8ljhZYd87QM9TXp1miFPMKcLQ=; b=T5XpmA
	D5uVpV6h28OwKVh5QB+T9nAyfGlo7aXYjQCz9T/ag6UUo+hWMtXqmk9Rd7RY0dXi
	HIsHPJisYA5HP2o1v9/19vWupUB/4M3wtjapkVwn1Fu863QyCLv3nyv3eS5DWrYf
	oIg1/9PnWlleF5ncRWzIxd0myuopUA4qk2g+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iHPuX6SWdCoY07BF5OI5WWP/vh9eDALt
	mi/mnKoxIvu1TgR4+AmE2liUOqtn0Ie9Rb+ANjexzZ0VWEFXc8vE5bfCxQf75PvK
	RbYKaNt1LUSBV22I93KxxyWL5pqekHHY0bTIGXbWjC0rDjLVbeImb5oQV+h0h4at
	7cxGfxDAOkM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DB4E63B5;
	Thu, 22 Sep 2011 19:45:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0464763B4; Thu, 22 Sep 2011
 19:45:29 -0400 (EDT)
In-Reply-To: <201109230133.33214.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 23 Sep 2011 01:33:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F46429DC-E574-11E0-8732-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181937>

Jakub Narebski <jnareb@gmail.com> writes:

> I don't think _modern_ distributions need this workaround... asciidoc 8.4.5
> which fixed the issue with "Synopsis" section was released 2009-05-24:

Thanks for a clarification.  I'll then hold it off until the upcoming
release and then merge it to see if anybody screams.
