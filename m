From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Teach Makefile.PL to find .pm files on its own
Date: Wed, 25 Jul 2012 09:56:22 -0700
Message-ID: <7vhasvdbk9.fsf@alter.siamese.dyndns.org>
References: <1343186471-1024-1-git-send-email-schwern@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: "Michael G. Schwern" <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 18:56:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su4sx-0004cP-4O
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 18:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756202Ab2GYQ40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 12:56:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45717 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755434Ab2GYQ4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 12:56:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19696804A;
	Wed, 25 Jul 2012 12:56:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qy0/qM9PYUFx2OHDcEHHuKMwq2M=; b=Lg75Q2
	kcz+T8FxzzsIByG7+qIKtzrhqIPoKpfYr+HxtII6WDRXuX9o81h35R3tqnjxVxzk
	5MHXkFHjNgGUZbtTJXrSC2fXNcEaQnDe1G2LBsYBPxImL5c0texN4a9cfaM423GZ
	d50KtAb0APw23xnCEag/QLICTj2R7K//FOKEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nYG4l98c+MuzP2hPnq7LpZimkrgIWq5x
	5/BKPCLkj5iIV7bukS7SZJNpFVRGdUIjRHcV+FP5hyFChStD0UcmmZBcSJMega4e
	V2glem98mTsdgS/LBJ+ZxC9vPd+C6nZEfp4Y1gITTk7/DiwvDgMi8Bi4lATd36jH
	Y11xgVj7dV4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07BCA8049;
	Wed, 25 Jul 2012 12:56:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 864948048; Wed, 25 Jul 2012
 12:56:23 -0400 (EDT)
In-Reply-To: <1343186471-1024-1-git-send-email-schwern@pobox.com> (Michael G.
 Schwern's message of "Tue, 24 Jul 2012 20:21:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AA62BC76-D679-11E1-86A0-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202176>

Looks sensible.  Will queue.

Thanks.
