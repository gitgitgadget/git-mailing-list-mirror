From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] Recognize magic pathspec as filenames
Date: Wed, 12 Oct 2011 23:06:55 -0700
Message-ID: <7vsjmx5ssg.fsf@alter.siamese.dyndns.org>
References: <1318373083-13840-1-git-send-email-pclouds@gmail.com>
 <1318373083-13840-2-git-send-email-pclouds@gmail.com>
 <7v4nze7x61.fsf@alter.siamese.dyndns.org>
 <CACsJy8CY=myfLpAbEA0=LCm+tCgS7jzEAxH3rnwQt4-RXyjW9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 08:07:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REERb-0004q0-5v
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 08:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023Ab1JMGG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 02:06:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36178 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491Ab1JMGG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 02:06:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B66128C6;
	Thu, 13 Oct 2011 02:06:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0MXiV8W76Z7mjwmei0YdUyMsufM=; b=GkxiUp
	oEUUFOn4ssJiz8LRr5Hj+hnIx8e+lkd0FXL59HlHolXIKdtQLzgRalCzFJEpUE7s
	mp1l+dQTD6BM6NE0AKNZ9SuCoDVOAZFfHAHzle88VwckIbMBib8HvwUUmOeODCL3
	boi/FxDR4ZM7hEZ6It//iAg/baOESJzpu/jhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RkR+1ymUn6zVFv1eCoArR0Y68T9Y6GSk
	acmzM/29zQrpJzQzqibXujDpPHGFCbXql/p1KlNRHmXt+v2VaBkr97/XadTyzNfV
	HnYrchrzxft5ZAfOjFK9B3Jh5w3zUlTQfUKZsy9Cxd92OdCWeYKbKsoVmOUZwhkh
	efBuS25xti0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 531F728C5;
	Thu, 13 Oct 2011 02:06:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCBE828C3; Thu, 13 Oct 2011
 02:06:56 -0400 (EDT)
In-Reply-To: <CACsJy8CY=myfLpAbEA0=LCm+tCgS7jzEAxH3rnwQt4-RXyjW9w@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 13 Oct 2011 15:23:39 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E4CDEEE-F561-11E0-A7E4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183443>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> It's unfortunate that ":" has so many meanings attached to it.

Yeah, I still recall that there were people who said ":/$path looks
similar to the way how the object at the $path in the index is named" as
if it were an advantage.  Maybe they were all misguided ;-).
