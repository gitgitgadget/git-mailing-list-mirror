From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] Documentation/urls: Rewrite to accomodate
 <transport>::<address>
Date: Sun, 18 Apr 2010 11:39:54 -0700
Message-ID: <7vk4s4wqo5.fsf@alter.siamese.dyndns.org>
References: <1271552047-sup-9523@kytes> <20100418025940.GA2249@progeny.tock>
 <1271566767-sup-7167@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 20:40:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3ZPp-0004cC-OE
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 20:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757421Ab0DRSkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 14:40:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56293 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144Ab0DRSkN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 14:40:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D0A0AC789;
	Sun, 18 Apr 2010 14:40:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g9bMCGoaty15pGWgDwLKo7/toH0=; b=cbp5O4
	oMZDFcTuJV4EZDBniy+GEiX5z2oPyLm4PTBtI4UvtFIOjhCO39htwRMJgN9KeMtx
	XKZ3nD7/CjsX+/Ya9F5uteBCu+g8vPNVojB9m460pQCmA7uLK3zgWl+GipQK2/QM
	7RbxVbDwXAraNK/CXRxGX5SK/tJ2+F5MBd30g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aeIXM3yPFJDZ63FcysycddIxVdfYDwYe
	TP4QvNBtraPy3efUEG6Z+ZB0brk+9VEEN6Ge/RKbWEOAT2b4w4MCj0zr/OZRRP3W
	mbsLC6jsko9d37Iyz1LJHVgNOa1gP0WLaR553Nvy7Tj4g1v9k8Yg5n5jOORJq2tT
	5oK9Rs/H7Rc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 16872AC783;
	Sun, 18 Apr 2010 14:40:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04A90AC780; Sun, 18 Apr
 2010 14:39:55 -0400 (EDT)
In-Reply-To: <1271566767-sup-7167@kytes> (Ramkumar Ramachandra's message of
 "Sun\, 18 Apr 2010 10\:33\:16 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CE3ACEF6-4B19-11DF-A243-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145233>

Thanks, both.  Will squash into the second patch.

Except that I'll further move rsync:// lower so that the curl family can
stay together, both in the list (that appeared in your "fixup") and in the
introductory text.
