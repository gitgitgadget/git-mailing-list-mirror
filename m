From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Teach Makefile.PL to find .pm files on its own
Date: Wed, 25 Jul 2012 13:32:58 -0700
Message-ID: <7vehnzbmyt.fsf@alter.siamese.dyndns.org>
References: <1343186471-1024-1-git-send-email-schwern@pobox.com>
 <7vhasvdbk9.fsf@alter.siamese.dyndns.org> <5010567B.1060907@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 22:33:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su8GZ-0006wQ-9x
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 22:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755Ab2GYUdC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 16:33:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49663 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590Ab2GYUdA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 16:33:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 600A864C4;
	Wed, 25 Jul 2012 16:33:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QtVsoc5EBRqCId+ggKpzTNMRL8w=; b=Q9+1Ka
	sw8tjNOVlHDw/vET2v1FZOB5YKQp/n1RLyzxzeIXbaoDNmL1Khmact+iCYk2c9fG
	jJcsmFWwpfQhoNeK+uRXIiHoddWDSkp5zQ51hF/5GkONFbZd3i+F4BVT03ZHCjF4
	MZdAjEc0rSJ9CP+sgkjc7Pp2N6I9HvCzV52h4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=If1uDvIHPH6Rqo7RN93RAn/298q5kYvN
	M4aiAJHDGIwtHLEMYqzqEOFzwccVSmwLYkWwosi1/odZS9gqUppAPedNQ03r7Akt
	aZLzM1D3ypu4e77MM5C5X0UrfmkzsZDJICuL0CX0r+kX4+hZnSYPhGi2ksvf20Jw
	Rk2t4NRoUb8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4910664C3;
	Wed, 25 Jul 2012 16:33:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB46F64C2; Wed, 25 Jul 2012
 16:32:59 -0400 (EDT)
In-Reply-To: <5010567B.1060907@pobox.com> (Michael G. Schwern's message of
 "Wed, 25 Jul 2012 13:26:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ECB8DF9C-D697-11E1-B958-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202192>

Michael G Schwern <schwern@pobox.com> writes:

> What's the lag time on it showing up in the repo, and which branch will it
> appear in?

There is nothing special in this topic, so it is likely to start on
'pu', and unlikely to come to 'master' before 1.7.12 ships sometime
next month.

> Also I just realized I've been basing my work on master.  Should I move to maint?

I don't think so.  It is not fixing any urgent breakage (iow, by
being told about .pm explicitly, it knows about them just fine
without being taught how to find them).
