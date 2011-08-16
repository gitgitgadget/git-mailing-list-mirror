From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2011, #03; Thu, 11) : Guidance
 for new contributors?
Date: Tue, 16 Aug 2011 09:40:00 -0700
Message-ID: <7v1uwljonz.fsf@alter.siamese.dyndns.org>
References: <7vr54rpogf.fsf@alter.siamese.dyndns.org>
 <AFD36BA266B14DAAA919E1AC1BDF0857@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Aug 16 18:40:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtMgd-0006Kz-5G
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 18:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627Ab1HPQkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 12:40:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65131 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552Ab1HPQkL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 12:40:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72EEE4CF5;
	Tue, 16 Aug 2011 12:40:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+DWEWARfEJ6MmNWf2lDZO5CtiaA=; b=TL8gDu
	7wK6NMn4SM0o/opmwNDzmXaZVSnLGC/SshfAg0hu/pWfykWmEzmaNZ/WaRFIpb4N
	DxWtGEfoR9pDRFt7p7qfyhHlnqklYVl12d1ku7BxkbzylK2jEGvcAXQqDcE3v1es
	Z79cnZrKqOU3n2TwyJ4VQYcjpZ0B6x8XEjPNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DRkdDn+H2caMdBCxh7dFf698O7Aq1X4O
	TVJPHs94SCCzllA7F0jy5/3NHZoWn7U5p99NFFhqWZ5KArXC0AzMBxqlrLidYEoZ
	hnY4098izLbcYC5vIf1nEH+R5PWN7hb0mgjaI6S/fACIp4xykA97RIVNKvuU5TdT
	bS0q75RJzN0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51E644CF4;
	Tue, 16 Aug 2011 12:40:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF24C4CEA; Tue, 16 Aug 2011
 12:40:01 -0400 (EDT)
In-Reply-To: <AFD36BA266B14DAAA919E1AC1BDF0857@PhilipOakley> (Philip Oakley's
 message of "Sat, 13 Aug 2011 19:40:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 632BF6AE-C826-11E0-B799-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179457>

"Philip Oakley" <philipoakley@iee.org> writes:

> Would it it be possible to include a regular link to an explanation
> for new contributors?

After each release from the 'master' branch I try to send out a copy of

  http://git-blame.blogspot.com/p/note-from-maintainer.html

to the list, which is meant to be that piece of information.
