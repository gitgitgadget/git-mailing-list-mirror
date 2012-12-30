From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Aw: Re: [PATCH 0/3] Move CodingGuidelines and SubmittingPatches
 to ./Documentation/technical
Date: Sun, 30 Dec 2012 13:40:50 -0800
Message-ID: <7v1ue7fcbh.fsf@alter.siamese.dyndns.org>
References: <1965427282.405137.1356879393533.JavaMail.ngmail@webmail18.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: artagnon@gmail.com, git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Dec 30 22:41:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpQdB-0001V3-RF
	for gcvg-git-2@plane.gmane.org; Sun, 30 Dec 2012 22:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176Ab2L3Vky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 16:40:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38170 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753046Ab2L3Vkw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2012 16:40:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78214A5E6;
	Sun, 30 Dec 2012 16:40:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UrdF9QDcFQqm87uK1WsKa/8hngA=; b=tQevUX
	sXjnHs1pBZd1rUnDrImbmww31W2EsRMS9zwJn5t1jJcb2SKKPZJpqKgfyJCBOPi4
	3iS3yaf4jJd6SsWEAatGgzqeE1t3kjTjyBs/21+q9/ACsodbny8W0Z/luc6dkc+O
	UOEyWiH9we6wiZDUK3vIskQqBNPyt9g40nTG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AQ044Lyp3V1y5tHiGN4xn3RWON2irebr
	OBbAeaLRo3wYBbMiDH25YZWsVuexJ/yOvz2ve0dOM+fPZkZ7q75vl8kmfa7iR55R
	E+fx+6cPDPIsiEss/s3qdUMKDKMTmqwWEBMfd9Jix9FPGDMxzX+TIWnvlO55TUUq
	4D9GORktBfA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6445FA5E5;
	Sun, 30 Dec 2012 16:40:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB086A5E3; Sun, 30 Dec 2012
 16:40:51 -0500 (EST)
In-Reply-To: <1965427282.405137.1356879393533.JavaMail.ngmail@webmail18.arcor-online.net>
 (Thomas Ackermann's message of "Sun, 30 Dec 2012 15:56:33 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 952AB08A-52C9-11E2-99B3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212344>

Thomas Ackermann <th.acker@arcor.de> writes:

>  
> ./Documentation/technical contains not only API documentation but also
> several other documents describing Git implementation topics and thus
> is the place someone wanting to join Git development should look at.

Implementation details are part of API; CG and SP are social not
technical.

Also CG and SP are in the part of the documents that are not
installed for end-users and that is their right place.  They matter
only to the people who grab our source code.
