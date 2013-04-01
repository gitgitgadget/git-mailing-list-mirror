From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse: clarify documentation for the --verify option
Date: Mon, 01 Apr 2013 09:56:48 -0700
Message-ID: <7vli92jijz.fsf@alter.siamese.dyndns.org>
References: <1364625865-8459-1-git-send-email-mhagger@alum.mit.edu>
 <7vwqsnnpwj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 01 18:57:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMi2r-0001wb-Kk
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 18:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759088Ab3DAQ4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 12:56:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44223 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759028Ab3DAQ4v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 12:56:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4BBF11C3E;
	Mon,  1 Apr 2013 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EE2a2FbIc5jJtI0ysmYQOqhJyrk=; b=oe1LaR
	V80yX7JOhS97gCFZz2NtAbxj5O39Y+5SrBPXuj9qHFaUQfrQvZ/jQ4/cR0buc4wh
	DJEB9dzfXqAtEltweWRJ9juJ/v1RXhV3QXgnoEKxJp+Qj/J6U1JSHMdwmo6o4SMG
	6VDrHIF2U0YLrFVXIbPbM87oA17Ff4I3C/h/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yDecSBs7VX4G+XBDj5cBHeege8Ga5WsN
	m8VMzF+201F+wxlc9B5faDK+U8WCFjtDeX1mviXhkxmIOrHwhk9J7ELxG5FqOAXY
	6ITkWEAzR+JZ3AbepQpHpMAh0D9SrN5isXLGm+/C8OgUyOfoeHCtkyhrk6IZBMha
	M5Z2OJ/0kAA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A90E411C3D;
	Mon,  1 Apr 2013 16:56:50 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32AE111C3C; Mon,  1 Apr
 2013 16:56:50 +0000 (UTC)
In-Reply-To: <7vwqsnnpwj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 31 Mar 2013 15:52:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 25884C94-9AED-11E2-A141-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219693>

Junio C Hamano <gitster@pobox.com> writes:

> Because the primary use case of this option is to implement end-user
> input validation, I think it would be helpful to clarify use of the
> peeler here.  Perhaps
> ...

A "SQUASH???" patch on top of your original is queued on 'pu',
together with the earlier "^{object}" peeler patch.  Comments,
improvements, etc. would be nice.

Thanks.
